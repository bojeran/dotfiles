
# REASONING

#######################################
## - - DO NOT SYMLINK THIS FILE - - ###
# A .bash_profile file is supposed to be changed by the user at ANYTIME.
# Using a `.bash_profile` from a git repository has often the reason to be able
# to update the file later on.
# - You probably will never run the update
# - The update will probably cause a merge-conflict nightmare
# - ...

###########################
### - - PERFORMANCE - - ###
# As a snappy terminal is one of the most important things (see README) the
# following decisions were made:
# Use a lot of function definitions as they do not cost a lot of execution time
# AND do not run ALL of them everytime you start a new terminal session.

####################
### - - TMUX - - ###
# To get different behaviour depending on when you are in a tmux session or not
# tmux::is_this_a_tmux_session

BASH_DEFAULTS_LOCATION="${HOME}/.bash-defaults"
BASH_ENVS_LOCATION="${HOME}/.bash-envs"

############
### helper

source "${BASH_DEFAULTS_LOCATION}/common_helper" || { echo "bash profile helper not found."; sleep 10; exit 1; }

###########################################
### FEATURE: lazy loading commands/envs
#
# When a command is not found. The command_not_found_handle will check in all
# environments below whether that command exists and when found, loads the
# environment automatically for you and executes the command.
# Make sure a function exists named: "env::${ENV}" e.g. "env::brew".
#
# Chicken/Egg problem: When you put the more generic environment such as homebrew first then
# it will find homebrew's 'node command' first before it tries the NVM environment.
# However, when you put NVM before homebrew. You have the problem that they load
# homebrew as dependency and therefore find ALL homebrew installed packages also
# in the NVM environment, even when it is not part of NVM.

# Solution: Load all environments and do some logic. Assume the more generic
#           environments being in the front. The first environment that has the
#           executable will be the (default) environment for this executable.
#           When a later environment has a different executable it will used
#           instead aka. the (overwrite) environment. When there are
#           multiple overwrites the last overwrite will be used.

declare -a AUTO_CHECK_ENVS=( "local-bin" "brew" "brew-nvm" "brew-cargo" "brew-pyenv" "brew-bash-completion" "macports" "dev-envs" )

if helper::source-bash "${BASH_DEFAULTS_LOCATION}/common_lazy_loading"; then
  : "Lazy loading makes the terminal super snappy (first time running some commands takes a little longer)"
  # uses special bash method "command_not_found_handle"; Do not shadow/overwrite!
fi

############
### common

if helper::source-bash "${BASH_DEFAULTS_LOCATION}/common"; then
    #common::prompt-string '\h:\W \u\$ '  # default macOS
    common::prompt-string '\W \$ '

    common::history-security "erasedups:ignorespace"

    # Change the following to your preferred editor (usually: vim or nano)
    common::set-default-editor vim
fi

if helper::source-bash "${BASH_DEFAULTS_LOCATION}/common_shadows"; then
    : "shadow counter initialized"
else
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
  brew::coreutils && common::register-shadow
  brew::gnu-sed && common::register-shadow
  # brew::gnu-getopt  # can cause issues
  brew::ncurses && common::register-shadow
  brew::bash && common::register-shadow

  : "shadow and non-shadow commands"
  brew::man-db && common::register-shadow

  : "Partially load brew environment with aliases : NON-SHADOWING"
  #brew::bash-completion@2
  : "bash-completion implemented as environment (some completions take very long to load)"
  #alias jq="/opt/homebrew/bin/jq"

  : "Alias environment:"
  alias brew="unalias brew &>/dev/null; env::brew"
  alias env::brew="unalias env::brew brew jq &>/dev/null; env::brew; brew"

  : "Build environments"
  #function brew::build-solvespace {
  #  export OpenMP_ROOT=$(brew --prefix)/opt/libomp
  #}
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_cargo"; then
  : "No shadowing needed"
  alias cargo="unalias brew cargo &>/dev/null; env::brew-cargo"
  alias env::brew-cargo="unalias env::brew-cargo brew cargo &>/dev/null; env::brew-cargo; cargo"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_nvm"; then
  : "No shadowing needed"
  alias nvm="unalias brew nvm &>/dev/null; env::brew-nvm"
  alias env::brew-nvm="unalias env::brew-nvm brew nvm &>/dev/null; env::brew-nvm; nvm"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_pyenv"; then
  : "No shadowing needed"
  alias pyenv="unalias brew pyenv &>/dev/null; env::brew-pyenv"
  alias env::brew-pyenv="unalias env::brew-pyenv brew pyenv &>/dev/null; env::brew-pyenv; pyenv"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/brew_bash_completion"; then
  : "No shadowing needed"
  alias bash-completion="unalias brew bash-completion &>/dev/null; env::brew-bash-completion"
  alias env::bash-completion="unalias env::bash-completion brew bash-completion &>/dev/null; env::bash-completion"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/macports"; then
  : "No shadowing needed"
  alias macports="unalias brew macports ports &>/dev/null; env::macports"
  alias ports="unalias ports macports &>/dev/null; env::macports"
  alias env::macports="unalias env::macports ports macports &>/dev/null; env::macports; ports"
fi

if helper::source-bash "${BASH_ENVS_LOCATION}/dev_envs"; then
  : "No shadowing needed"
  alias dev="unalias dev &>/dev/null; env::dev-envs"
  alias env::dev-envs="unalias env::dev-envs dev &>/dev/null; env::dev-envs"
fi

alias docker="echo ENVIRONMENT IS NOT ENABLED"


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