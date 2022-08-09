# ! Scroll to the bottom and comment in the function calls you like
#    - functions are used because of performance reasons
#      (not used function definitions do not cost a lot of performance)

function profile::history-security {
    # 1. prepended space " " will not be added to history, for example:
    #
    #     Your-PC:~ name$  sshpass "blabla" | ssh ...
    #
    # 2. removes duplicate entries from history

    export HISTCONTROL=erasedups:ignorespace
}


function profile::iterm2-shell-integration {
    # See: https://iterm2.com/documentation-shell-integration.html
    test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
}


function profile::bash-completion {
    # brew info bash-completion@2
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
}


function profile::gnu-sed {
    # brew info gnu-sed
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
}


function profile::soft-upgrade-ncurses {
    # As MacOS comes with an old version of ncurses that can lead to various
    # issues. This commands adds the latest version of ncurses in front to
    # preinstalled version.
    # brew info ncurses
    export PATH="/usr/local/opt/ncurses/bin:$PATH"
}

function profile::various-aliases {
    alias cp='cp -iv'
    alias mv='mv -iv'
    alias mkdir='mkdir -pv'
    alias ll='ls -FGlAhp'
    alias less='less -FSRXc'
    alias cd..='cd ../'
    alias ..='cd ../'
    alias ...='cd ../../'
}


function profile::set-encoding {
    # The following allows you to see UTF-8 with urwid.
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
}


function profile::set-default-editor {
    # Change the following to your preferred editor (usually: vim or nano)
    export EDITOR="vim"
}


function profile::user-scoped-scripts-enable {
    # Your own user scoped scripts for SHELL invocation purposes
    export PATH="${PATH}:${HOME}/.local/bin"
}


function profile::keychain-scripting-enable {
    # add scripting capabilities for osx keychain
    # WARNING: might be dangerous if done wrong
    # Add keys: security add-generic-password -s machine -a root -w PaSSW0rd
    # Get User (root): keychain.sh -u -s google
    # Get password: keychain.sh -p -s google
    export PATH=$PATH:${HOME}/Documents/scripts/keychain/bin
}


function profile::fswatch-scripting-enable {
    # Add fswatch-do script which simplifies the usage of fswatch
    export PATH=${PATH}:${HOME}/Documents/scripts/fswatch/bin
}


function profile::tmux-scripting-enable {
    # Add tmux- commands to quickly open specific workspaces which are pre setup
    export PATH=$PATH:${HOME}/Documents/scripts/tmux/bin
}


function profile::fzf {
    # brew info fzf
    # gdate +"%T.%N" >> /tmp/fzfA
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
    # gdate +"%T.%N" >> /tmp/fzfB
}


function profile::glyphs {
    # codepoints for glyphs
    . ${HOME}/Documents/git/awesome-terminal-fonts/build/devicons-regular.sh
    . ${HOME}/Documents/git/awesome-terminal-fonts/build/fontawesome-regular.sh
    . ${HOME}/Documents/git/awesome-terminal-fonts/build/octicons-regular.sh
    . ${HOME}/Documents/git/awesome-terminal-fonts/build/pomicons-regular.sh
}


function profile::itermocil-autocompletion {
    # brew info TomAnthony/brews/itermocil
    complete -W "$(itermocil --list)" itermocil
}


# This command is not namespaced as
function docker-enable {
    # To activate docker on MacOS you usually use following command:
    #
    #    eval $(docker-machine env vbox)
    #
    # But this command is super slow. One fix is to use the following commands.
    : ${DOCKER_MACHINE_NAME="vbox"}
    eval $(docker-machine inspect ${DOCKER_MACHINE_NAME} --format \
    "export DOCKER_HOST=tcp://{{ .Driver.IPAddress }}:2376
    export DOCKER_TLS_VERIFY=1
    export DOCKER_CERT_PATH={{ .HostOptions.AuthOptions.StorePath }}
    export DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME}")
}


function pyenv-enable {
    # brew info pyenv
    #gdate +"%T.%N" >> /tmp/pyenvA
    eval "$(pyenv init -)"
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    #gdate +"%T.%N" >> /tmp/pyenvB
}


function nvm-enable {
    # brew info nvm
    #gdate +"%T.%N" >> /tmp/nvmA
    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
    #gdate +"%T.%N" >> /tmp/nvmB
}


# set title from command line
function title {
    echo -ne "\033]0;"$*"\007"
}


# narrow terminal mode
function n {
    export PS1="\h:\W \u\n\$ "
}
alias narrow=n


# https://www.npmjs.com/package/iterm2-tab-set
# make sure to install it via npm globally WITHOUT nvm enabled
# brew install npm && npm install -g iterm2-tab-set
alias ts='tabset'


# The following feature allows you to create
# or attach tmux sessions whenever you open a new terminal window.
#
# Create session:
#  - give it a name
#  -> a color is automatically picked
#  -> detach session with `Cmd+w` or `Ctrl+b + d`
#
# Attach session:
#  - open new terminal window
#  - fuzzy find your session and press enter
#

# check if we are in a tmux session (0=yes, 1=no)
{ [ -n "$TMUX" ]; }
export IN_TMUX_SESSION_RC=$?


function t {
    # when not in a tmux session
    if [ ${IN_TMUX_SESSION_RC} -ne 0 ]; then
        sessions="$(tmux ls -F '#{session_name}' 2>/dev/null)"
        if [ -z "${sessions}" ]; then
            sessions="$(printf 'exit')"
        else
            sessions="$(printf '%s\nexit' "${sessions}")"
        fi
        result=$(echo "${sessions}"|fzf -e --prompt 'tmux session: ' --print-query)
        # does not work because xargs has wrong default behaviour for empty string in OS X
        # result="$(tmux ls -F '#{session_name}'|xargs -0 printf '%sexit'|fzf -e --prompt 'tmux session: ' --print-query)"
        if [ $(echo "$result"|wc -l) -eq 2 ]; then
            session_name=$(echo "${result}"|head -2|tail -1)
        else
            session_name="${result}"
        fi

        if { [ "${session_name}" == "exit" ] || [ -z "${session_name}" ]; } then
            return
        fi

        ts $session_name
        tmux attach -t "$session_name" || tmux new -s "$session_name"
        # When I just exited the tmux session (without errors then exit)
        local rc=$?
        if [ ${rc} -eq 0 ]; then
            # when the session is within an ssh session then go run
            exit
        fi
    fi
}
alias tmuxtab=t
tmuxtab

# IN TMUX: selectively enable features
# WITHOUT TMUX: terminal with no modifications (system default)
if [ ${IN_TMUX_SESSION_RC} -eq 0 ]; then
    profile::history-security
    profile::iterm2-shell-integration
    profile::bash-completion
    profile::gnu-sed
    profile::soft-upgrade-ncurses
    profile::various-aliases
    profile::set-encoding
    profile::set-default-editor
    profile::user-scoped-scripts-enable

    # Experimental:
    #profile::keychain-scripting-enable
    #profile::fswatch-scripting-enable
    #profile::tmux-scripting-enable
    #profile::fzf
    #profile::glyphs
    #profile::itermocil-autocompletion

    tput setaf 4; echo "Commands: docker-enable, pyenv-enable, nvm-enable, narrow/n."; tput sgr 0
fi
