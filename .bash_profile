# comment in what you like

# HISTCONTROL
# - ignorespace:
# $  cmd-with-secret  # -> not added to the history because of prepended space
# - removes duplicate entries from history
export HISTCONTROL=erasedups:ignorespace


# iterm2 shell integration
#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# brew install bash-completion@2
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# brew install gnu-sed
# export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"


# alias
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlAhp'
alias less='less -FSRXc'
alias cd..='cd ../'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
#alias f='open -a Finder ./'
alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
#trash () { command mv "$@" ~/.Trash ; }
#ql () { qlmanage -p "$*" >& /dev/null; }


# brew install docker docker-machine virtualbox
#function docker_enable {
#    : ${DOCKER_MACHINE_NAME="vbox"}
#    eval $(docker-machine inspect ${DOCKER_MACHINE_NAME} --format \
#    "export DOCKER_HOST=tcp://{{ .Driver.IPAddress }}:2376
#    export DOCKER_TLS_VERIFY=1
#    export DOCKER_CERT_PATH={{ .HostOptions.AuthOptions.StorePath }}
#    export DOCKER_MACHINE_NAME=${DOCKER_MACHINE_NAME}")
#}


# brew install pyenv
#eval "$(pyenv init -)"
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


# brew install TomAnthony/brews/itermocil
# complete -W "$(itermocil --list)" itermocil


# add scripting capabilities for osx keychain
# WARNING: might be dangerous if done wrong
# export PATH=$PATH:$HOME/Documents/scripts/keychain/bin


# brew install fswatch
# add wrapper for fswatch
# export PATH=$PATH:$HOME/Documents/scripts/fswatch/bin


# tmux
# Add tmux- commands to quickly open specific workspaces which are pre setup
# export PATH=$PATH:$HOME/Documents/scripts/tmux/bin


# brew install fzf
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash


# codepoints for glyphs
#. $HOME/Documents/git/awesome-terminal-fonts/build/devicons-regular.sh
#. $HOME/Documents/git/awesome-terminal-fonts/build/fontawesome-regular.sh
#. $HOME/Documents/git/awesome-terminal-fonts/build/octicons-regular.sh
#. $HOME/Documents/git/awesome-terminal-fonts/build/pomicons-regular.sh


# set encoding differently to be able to see UTF-8 with urwid
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8


# set EDITOR to vim
export EDITOR="vim"


# iterm2: set title from command line
#function title {
#    echo -ne "\033]0;"$*"\007"
#}


# npm install tabset
# alias t='tabset'


# productivity (with a lot of tabs): force tmux
#  - sets iterm2 tab name
#  - sets tmux session name
#  - fzf for attach and new sessions
#if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
#    result="$(tmux ls -F '#{session_name}'|fzf -e --prompt 'tmux session: ' --print-query)"
#    if [ $(echo "$result"|wc -l) -eq 2 ]; then
#        session_name=$(echo "$result"|head -2|tail -1)
#    else
#        session_name="$result"
#    fi
#    t $session_name
#    tmux attach -t "$session_name" || tmux new -s "$session_name"
#fi


