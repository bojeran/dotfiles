
# REASONING

#######################################
## - - DO NOT SYMLINK THIS FILE - - ###
# A .bash_profile file is supposed to be changed by the user at ANYTIME.
# Using a `.bash_profile` from a git repository has often the reason to be able
# to update the file later on.
# - You probably will never run the update
# - The update will probably a merge-conflict nightmare
# - ...

###########################
### - - PERFORMANCE - - ###
# As a snappy terminal is one of the most important things (see README) the
# following decisions were made:
# Use a lot of function definitions as they do not cost a lot of execution time
# AND do not run ALL of them everytime you start a new terminal sessions.

####################
### - - TMUX - - ###
# To get different behaviour depending on when you are in a tmux session or not
# tmux::is_this_a_tmux_session

BASH_LIBRARY_LOCATION="${HOME}/.bash-defaults"

############
### helper

source "${BASH_LIBRARY_LOCATION}/common_helper" || { echo "bash profile helper not found."; sleep 10; exit 1; }

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

declare -a AUTO_CHECK_ENVS=( "brew" "brew-nvm" "brew-cargo" "brew-pyenv" )

if helper::source-bash "${BASH_LIBRARY_LOCATION}/common_lazy_loading"; then
  : "Lazy loading makes the terminal super snappy (first time running some commands takes a little longer)"
  # uses special bash method "command_not_found_handle"; Do not shadow/overwrite!
fi

############
### common

if helper::source-bash "${BASH_LIBRARY_LOCATION}/common"; then
    common::history-security "erasedups:ignorespace"

    # Change the following to your preferred editor (usually: vim or nano)
    common::set-default-editor vim
fi


###################
### environments

if helper::source-bash "${BASH_LIBRARY_LOCATION}/brew"; then
  : "loaded"
fi

if helper::source-bash "${BASH_LIBRARY_LOCATION}/brew_cargo"; then
  : "loaded"
fi

if helper::source-bash "${BASH_LIBRARY_LOCATION}/brew_nvm"; then
  : "loaded"
fi

if helper::source-bash "${BASH_LIBRARY_LOCATION}/brew_pyenv"; then
  : "loaded"
fi




######################
### feature: .bash_profile new content checker
if helper::source-bash "${BASH_LIBRARY_LOCATION}/common_new_content"; then
  if common::bash_profile_content_check; then
    echo "New content detected in the .bash_profile"
    echo "Please check and EDIT"
  fi
fi



# DO NOT REMOVE THIS LINE - NEW CONTENT CHECK
#asdf