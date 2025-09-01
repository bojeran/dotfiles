#!/usr/bin/env python3
import os
import re
import sys
from typing import Dict, List, Optional


# Variables to expand in paths
variables: Dict[str, str] = {
    'BASH_DEFAULTS_LOCATION': './.bash-defaults',
    'BASH_ENVS_LOCATION': './.bash-envs'
}

def substitute_variables(path: str) -> str:
    """Simple variable expansion for known variables."""
    for var_name, var_value in variables.items():
        # Handle ${VAR_NAME} format
        if f'${{{var_name}}}' in path:
            return path.replace(f'${{{var_name}}}', var_value)
        # Handle $VAR_NAME format
        if f'${var_name}' in path:
            return path.replace(f'${var_name}', var_value)
    return path

def inline_file(filepath: str, original_line: str) -> None:
    """Inline a file's content or print original line if file doesn't exist."""
    if os.path.exists(filepath):
        # Check for nested source commands (not allowed)
        with open(filepath, 'r') as f:
            content = f.read()
            # if re.search(r'^\s*source\s+', content, re.MULTILINE):
            #     print(f'# WARNING: Nested source command found in '
            #           f'{filepath}', file=sys.stderr)
        
        # Print the file content
        print(f'# Inlined: {filepath}')
        print(content.rstrip())
    else:
        # Keep the original line if file doesn't exist
        print('# kept line')
        print(original_line)

def process_file(filepath: str) -> None:
    """Process a file and inline source commands."""
    if not os.path.exists(filepath):
        print(f'# ERROR: File not found: {filepath}', file=sys.stderr)
        sys.exit(1)
    
    print(f'# >>> Inlined from: {filepath}')
    
    with open(filepath, 'r') as f:
        lines: List[str] = f.readlines()
    
    line_index: int = 0
    while line_index < len(lines):
        line: str = lines[line_index].rstrip('\n')
        
        # Check for variable assignments we need to track
        # Matches: '   ASDF="123"'
        var_match: Optional[re.Match[str]] = re.match(
            r'^\s*([A-Z_]+)=["\'](.*?)["\']', line)
        if var_match:
            var_name: str = var_match.group(1)
            var_value: str = var_match.group(2)
            known_vars = ['BASH_DEFAULTS_LOCATION', 'BASH_ENVS_LOCATION']
            if var_name in known_vars:
                # Skip known variable assignments
                line_index += 1
                print(f'# skipped: {line}')
                continue
            else:
                raise Exception(
                    f'Unexpected variable assignment found: '
                    f'{var_name}={var_value}. Only '
                    f'BASH_DEFAULTS_LOCATION and BASH_ENVS_LOCATION '
                    f'are expected.')
        
        # Check for standard source command
        # Matches: source "path/to/file" || { error handling }
        # Captures: The file path (without quotes) in group 1
        source_pattern = r'^\s*source\s+["\']?([^"\']+)["\']?(?:\s*\|\|.*)?$'
        source_match: Optional[re.Match[str]] = re.match(source_pattern, line)
        if source_match:
            source_path: str = substitute_variables(
                source_match.group(1).strip())
            
            # Make relative paths absolute
            if not os.path.isabs(source_path):
                source_path = os.path.join(
                    os.path.dirname(filepath), source_path)

            print(f'# source import: {source_path}')

            inline_file(source_path, line)
            line_index += 1
            continue
        
        # Check for standalone helper::source-bash command
        # Matches: helper::source-bash "path"
        # Captures: The file path (without quotes) in group 1
        helper_pattern = r'^\s*helper::source-bash\s+["\']?([^"\']+)["\']?$'
        helper_match: Optional[re.Match[str]] = re.match(helper_pattern, line)
        if helper_match:
            source_path = substitute_variables(
                helper_match.group(1).strip())
            
            # Make relative paths absolute
            if not os.path.isabs(source_path):
                source_path = os.path.join(
                    os.path.dirname(filepath), source_path)

            print(f'# helper_source import: {source_path}')

            inline_file(source_path, line)
            line_index += 1
            continue
        
        # Check for if statements with helper::source-bash command
        # Matches: if helper::source-bash "path"; then OR
        #          if ! helper::source-bash "path"; then
        # Captures: negation (!) in group 1, file path (without quotes) in group 2
        if_pattern = (r'^\s*if\s+(!?)\s*helper::source-bash\s+'
                      r'["\']?([^"\']+)["\']?(?:\s*;.*)?$')
        if_helper_match: Optional[re.Match[str]] = re.match(if_pattern, line)
        if if_helper_match:
            is_negated: bool = bool(if_helper_match.group(1))
            source_path = substitute_variables(
                if_helper_match.group(2).strip())
            
            # Make relative paths absolute
            if not os.path.isabs(source_path):
                source_path = os.path.join(
                    os.path.dirname(filepath), source_path)

            print(f'# helper_source import: {source_path}')

            inline_file(source_path, line)

            # Skip to matching fi
            line_index += 1
            if_count: int = 1
            while line_index < len(lines) and if_count > 0:
                next_line: str = lines[line_index].rstrip('\n')
                if re.match(r'^\s*if\b', next_line):
                    if_count += 1
                elif re.match(r'^\s*fi\b', next_line):
                    if_count -= 1
                
                # When the fi to the original if is found
                # the line containing the fi is not printed
                # For negated conditions (if !), don't print inner lines
                if if_count > 0 and not is_negated:
                    print(next_line)

                line_index += 1
            
            # we don't rely on the line_index += 1 of the outer loop
            continue
        
        # If none of the above matches, just print the line
        print(line)
        line_index += 1
    
    # We cannot print something at the end as there is
    # a new content check feature in the .bash_profile
    # print(f'# <<< End of: {filepath}')

def main() -> None:
    """Main function to process the bash profile."""
    # Print header
    print('#!/usr/bin/env bash')
    print('# Merged bash profile - generated from modular dotfiles')
    print('# Source: https://github.com/bojeran/dotfiles')
    print('')
    print('# This is a self-contained version with all sourced files inlined')
    print('')
    
    # Process .bash_profile
    try:
        process_file('.bash_profile')
    except Exception as e:
        print(f'# ERROR: {e}', file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()