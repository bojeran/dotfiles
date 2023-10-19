
# a .bash_profile file is supposed to be changed by the user
# this file should not be a symlink to a file in a github repository
# the following lines are configurations options that are implemented in separate files that can be updated via github

# functions are used because of performance reasons
# function definitions do not cost a lot of time.

# To get different behaviour depending on when you are in a tmux session or not
# tmux::is_this_a_tmux_session

BASH_LIBRARY_LOCATION="${HOME}/.bash-defaults"

############
### helper

source "${BASH_LIBRARY_LOCATION}/bash_profile_helper" || { echo "bash profile helper not found."; sleep 10; exit 1; }

############
### common

if helper::source-bash "${BASH_LIBRARY_LOCATION}/bash_profile_common"; then
    common::history-security "erasedups:ignorespace"
    common::bash-completion

    # Change the following to your preferred editor (usually: vim or nano)
    common::set-default-editor vim
fi


############
### homebrew

if helper::source-bash "${BASH_LIBRARY_LOCATION}/bash_profile_homebrew"; then
    brew::homebrew


fi

