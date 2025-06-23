# Merge Bash Profile Documentation

## Overview

The `merge_bash_profile.py` script creates a self-contained `.bash_profile` by inlining all dynamically sourced files. This produces a single file with zero external dependencies, perfect for distribution or isolated environments.

## How It Works

The script:
1. Reads `.bash_profile` line-by-line
2. Detects `source` commands and `helper::source-bash` calls
3. Replaces these with the actual file contents
4. Outputs a merged profile to stdout

**Exit codes:**
- `0`: Success
- `1`: Failure (file not found, nested sources in repo files, etc.)

## Usage

```bash
# Generate merged profile
python3 nix-build-utils/merge_bash_profile.py > merged_profile.sh

# Test the merged profile
bash --norc --noprofile -c 'source merged_profile.sh && echo "Success"'

# Use with Nix build
nix-build default.nix
```


## Supported Constructs

### Standard source command
```bash
source "${BASH_DEFAULTS_LOCATION}/common"
source .bash-envs/brew
source /absolute/path/to/file
```

### Helper source with conditional
```bash
if helper::source-bash "${BASH_ENVS_LOCATION}/nvm"; then
    echo "NVM loaded"
fi
```

### Variable substitution
The script recognizes and expands:
- `${BASH_DEFAULTS_LOCATION}` → `./.bash-defaults`
- `${BASH_ENVS_LOCATION}` → `./.bash-envs`

## Limitations

### Not supported - Multiline source
```bash
# This will break parsing
source bla && \
  echo other command
```

### Not supported - Complex expressions
```bash
# These won't be processed correctly
source $(find_config_file)
source "$HOME/.bashrc" || source "/etc/bashrc"
```

### Not supported - Nested sources in repo files
Sourced files within this repository cannot contain a `source` command except they point to external files.



## Processing Logic

### Step-by-Step Process

1. **Line parsing**: Reads `.bash_profile` line-by-line
2. **Pattern detection**: Identifies source commands using regex
3. **Path resolution**: 
   - Expands variables (`${BASH_DEFAULTS_LOCATION}`)
   - Converts relative paths to absolute
4. **File inlining**:
   - If file exists: Replace command with file contents
   - If file missing: Keep original line
5. **Conditional handling**: For `if helper::source-bash`, tracks nested if/fi blocks

### Transformation Examples

#### Example 1: Simple source
**Input:**
```bash
echo "Starting profile"
source "${BASH_DEFAULTS_LOCATION}/common"
echo "Profile loaded"
```

**Output:**
```bash
echo "Starting profile"
# source import: ./.bash-defaults/common
# Inlined: ./.bash-defaults/common
[contents of common file here]
echo "Profile loaded"
```

#### Example 2: Conditional source (positive)
**Input:**
```bash
if helper::source-bash "${BASH_ENVS_LOCATION}/nvm"; then
    export NVM_LOADED=1
    echo "NVM environment loaded"
fi
```

**Output:**
```bash
# helper_source import: ./.bash-envs/nvm
# Inlined: ./.bash-envs/nvm
[contents of nvm file here]
export NVM_LOADED=1
echo "NVM environment loaded"
```

#### Example 3: Conditional source (negative)
**Input:**
```bash
if ! helper::source-bash "${BASH_ENVS_LOCATION}/optional"; then
    echo "Optional environment not available"
    export FALLBACK=1
fi
```

**Output:**
```bash
# helper_source import: ./.bash-envs/optional
# Inlined: ./.bash-envs/optional
[contents of optional file here]
```
Note: The lines inside the if block are NOT printed because the condition is negated.

#### Example 4: Missing file
**Input:**
```bash
source /etc/optional-config
```

**Output:**
```bash
# kept line
source /etc/optional-config
```

## Error Handling

### Common Errors

1. **File not found**: Script exits with code 1
   ```
   # ERROR: File not found: .bash_profile
   ```

2. **Nested source in repo file**: Currently commented out. Comment in to get a warning.
   ```
   # WARNING: Nested source command found in .bash-defaults/common
   ```

3. **Unexpected variable**: Raises exception
   ```
   Exception: Unexpected variable assignment found: FOO=bar
   ```

## Testing

### Verify the merged profile

1. **Syntax check**:
   ```bash
   python3 merge_bash_profile.py | bash -n
   ```

2. **Functionality test**:
   ```bash
   # Create test script
   python3 merge_bash_profile.py > test_profile.sh
   
   # Test in isolated environment
   env -i bash --norc --noprofile -c '
     source test_profile.sh
     # Tests could be implemented here.
   '
   ```
