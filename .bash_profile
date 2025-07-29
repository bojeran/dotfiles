
# Dependencies

BASH_DEFAULTS_LOCATION="${HOME}/.bash-defaults"
BASH_ENVS_LOCATION="${HOME}/.bash-envs"


# helper

source "${BASH_DEFAULTS_LOCATION}/common_helper" || { echo "bash profile helper not found."; sleep 10; exit 1; }


###########################################
### FEATURE: lazy loading commands/envs
#

# Variables contains all environments to check for missing commands.
#  1. First-Environment containing the command is the fallback environment.
#  2. Second-Environment containing the command is the environment that will be used.
#  3. Successive-Environment containing the command will be used instead.
#  4. If only the First-Environment contains the command this environment will be used. (Fallback)
declare -a AUTO_CHECK_ENVS=( "local-bin" "brew" "brew-nvm" "brew-cargo" "brew-pyenv" "brew-bash-completion" "macports" "brew-go" "brew-java" "dev-envs" "nix" )

# Lazy loading makes the terminal super snappy (first time running some commands takes a little longer)
# uses special bash method "command_not_found_handle"; Do not shadow/overwrite!
helper::source-bash "${BASH_DEFAULTS_LOCATION}/common_lazy_loading"

############
### common

if helper::source-bash "${BASH_DEFAULTS_LOCATION}/common"; then
  # collect existing envs
  existing_envs="$(echo "$PS1" | grep -o '\[[^]]*\]')"

  alias ls="ls --color"

  # when there is an environment loaded preserve precious PS1
  if [[ -z "${existing_envs}" ]]; then
    #common::prompt-string '\h:\W \u\$ '  # default macOS
    common::prompt-string '\W \$ '
  else
    # When any environment is loaded based on the PS1 content it assumed
    # that we are in an environment that we don't want to mess with.
    #echo "Preserved existing envs: ${existing_envs}"
    return
  fi

  common::history-security "erasedups:ignorespace"

  # Warning: Long load time with increasingly big $HISTFILE
  common::enable-preserved-history
  # Warning: Long load time on each new terminal prompt with big $HISTFILE
  # common::enable-shared-history

  # Change the following to your preferred editor (usually: vim or nano)
  common::set-default-editor vim
fi

if ! helper::source-bash "${BASH_DEFAULTS_LOCATION}/common_shadows"; then
  alias common::register-shadow=":"
fi


###################
### environments & shadowing binaries

if helper::source-bash "${BASH_ENVS_LOCATION}/local_bin"; then
  : "No shadowing needed"
  alias local-bin="unalias local-bin; env::local-bin"
  alias env::local-bin="unalias env::local-bin local-bin &>/dev/null; env::local-bin"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew"; then
  : "Partially load brew environment : SHADOWING EXISTING COMMANDS"
  brew::coreutils && common::register-shadow  # ~107 commands (ls, du, cat, ...)
  brew::gnu-sed && common::register-shadow    # 1 command
  # brew::gnu-getopt  # can cause issues
  brew::ncurses && common::register-shadow    # projects with ncurses dependency
  brew::bash && common::register-shadow       # the shell

  : "shadow and non-shadow commands"
  brew::man-db && common::register-shadow     # introduces "gman" (does not shadow man)

  : "Partially load brew environment with aliases : NON-SHADOWING"
  #brew::bash-completion@2
  : "bash-completion implemented as environment (some completions take very long to load)"
  #alias jq="/opt/homebrew/bin/jq"

  : "Alias environment:"
  alias brew="unalias brew &>/dev/null; env::brew; brew"
  alias env::brew="unalias env::brew brew jq &>/dev/null; env::brew"

  : "Build environments"
  #function brew::build-solvespace {
  #  export OpenMP_ROOT=$(brew --prefix)/opt/libomp
  #}
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_cargo"; then
  : "No shadowing needed"
  alias cargo="unalias brew cargo &>/dev/null; env::brew-cargo; cargo"
  alias env::brew-cargo="unalias env::brew-cargo brew cargo &>/dev/null; env::brew-cargo"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_nvm"; then
  : "No shadowing needed"
  alias nvm="unalias brew nvm &>/dev/null; env::brew-nvm; nvm"
  alias env::brew-nvm="unalias env::brew-nvm brew nvm &>/dev/null; env::brew-nvm"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_pyenv"; then
  : "No shadowing needed"
  alias pyenv="unalias brew pyenv &>/dev/null; env::brew-pyenv; pyenv"
  alias env::brew-pyenv="unalias env::brew-pyenv brew pyenv &>/dev/null; env::brew-pyenv"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_bash_completion"; then
  : "No shadowing needed"
  alias bash-completion="unalias brew bash-completion &>/dev/null; env::brew-bash-completion"
  alias env::bash-completion="unalias env::bash-completion brew bash-completion &>/dev/null; env::bash-completion"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/macports"; then
  : "No shadowing needed"
  alias macports="unalias brew macports ports &>/dev/null; env::macports"
  alias ports="unalias ports macports &>/dev/null; env::macports; ports"
  alias env::macports="unalias env::macports ports macports &>/dev/null; env::macports"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_go"; then
  : "No shadowing needed"
  alias go="unalias go &>/dev/null; env::brew-go; go"
  alias env::brew-go="unalias env::brew-go go &>/dev/null; env::brew-go"
  # load go by default (for VS-Code to detect go):
  if [[ "$TERM_PROGRAM" == "vscode" ]] || [[ -n "$VSCODE_PID" ]]; then
    env::brew-go
  fi
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_java"; then
  : "No shadowing needed"
  alias java="unalias java &>/dev/null; env::brew-java; java"
  alias env::brew-java="unalias env::brew-java java &>/dev/null; env::brew-java"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/dev_envs"; then
  : "No shadowing needed"
  alias dev="unalias dev &>/dev/null; env::dev-envs"
  alias env::dev-envs="unalias env::dev-envs dev &>/dev/null; env::dev-envs"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_docker_lima"; then
  : "No shadowing needed"
  #alias docker="echo ENVIRONMENT IS NOT ENABLED"
  alias docker="unalias docker &>/dev/null; env::brew-docker-lima; docker"
  alias env::brew-docker-lima="unalias env::brew-docker-lima docker &>/dev/null; env::brew-docker-lima"
fi


if helper::source-bash "${BASH_ENVS_LOCATION}/nix"; then
  : "No shadowing needed"
  alias nix="unalias nix &>/dev/null; env::nix; nix"
  alias env::nix="unalias env::nix nix &>/dev/null; env::nix"
  # load nix by default
  if [[ "$TERM_PROGRAM" == "vscode" ]] || [[ -n "$VSCODE_PID" ]]; then
    # vs-code
    env::nix
  else
    # any other terminal
    env::nix
  fi
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/nix_shell"; then
  : "THIS SHADOWS nix-shell"
  # The following alias shadows the `nix-shell` command and changes it's behaviour slightly
  # Examples:
  # - `nix-shell -p BLA` -> as soon as there is a `-` or `--` in the command
  #                         the call is passed on to the normal nix-shell cmd.
  # - `nix-shell shell.nix` -> is affected and will be wrapped and extended
  # - `nix-shell` (./shell.nix exists) -> is affected
  # - `nix-shell` (./shell.nix does not exist) -> a special system-wide shell
  #                                               environment is loaded

  # to wrap every nix-shell with user specific stuff
  # This is an intrusive experimental overwrite and doesn't take a lot of things into consideration
  env::nix-shell-alias
  #alias nix-shell="unalias nix nix-shell &>/dev/null; env::nix-shell"
  #alias env::nix-shell="unalias env::nix-shell nix nix-shell &>/dev/null; env::nix-shell"
  common::register-shadow
fi



######################
### feature: macOS only iterm2 shell integration
[[ -f $HOME/.iterm2_shell_integration.bash ]] && source $HOME/.iterm2_shell_integration.bash


######################
### feature: show shadow counter
common::show-shadow-counter-in-title



######################
### feature: .bash_profile new content checker
if helper::source-bash "${BASH_DEFAULTS_LOCATION}/common_new_content"; then
  if common::bash_profile_content_check; then
    echo "New content detected in the .bash_profile"
    echo "Please check and EDIT"
  fi
fi


# ! For every new `export PATH` you have to:
#    - create an environment under .bash-envs
#    - source the the created environment under the above environments section.
#    - add the environment under "AUTO_CHECK_ENVS"
#   -> See `$HOME/.bash-envs/local_bin` as simple example.

# DON'T DO: export PATH=.... see above

# DO NOT REMOVE THIS LINE - NEW CONTENT CHECK
#asdf