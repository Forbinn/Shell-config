#!/bin/bash

function parse_git_branch() {
    var="$(type -P git)"
    if [ ! -z "$var" ]; then
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
    fi
}

function proml() {
    local BLACK="\[\033[0;30m\]"
    local RED="\[\033[0;31m\]"
    local GREEN="\[\033[0;32m\]"
    local YELLOW="\[\033[0;33m\]"
    local BLUE="\[\033[1;34m\]"
    local PINK="\[\033[0;35m\]"
    local LIGTH_BLUE="\[\033[0;36m\]"
    local WHITE="\[\033[1;37m\]"
    local DEFAULT="\[\033[0m\]"

    hostname="$(hostname -s)"
    if [ "$hostname" == "localhost" ]; then
        hostname=""
    fi

    if [ "$(id -u)" == "0" ]; then # root
        export PS1="\d $RED\t $GREEN[\w]$BLUE\$(parse_git_branch) $LIGTH_BLUE$hostname$DEFAULT\n# "
    else # user
        export PS1="\d $RED\t $GREEN[\w]$BLUE\$(parse_git_branch) $LIGTH_BLUE$hostname$DEFAULT\n$ "
    fi
}

# Standard PATH
export PATH="/usr/bin"
export PATH="${PATH}:/usr/local/sbin:/usr/local/bin"
export PATH="${PATH}:/usr/sbin:/usr/bin:/sbin:/bin"

export JAVA_HOME="/usr/lib/jvm/java-1.8.0/"

export NAME="vincent leroy"

export EDITOR='vim'
export HISTSIZE=1000
export PAGER='less'
export SAVEHIST=1000
export WATCH='all'

# Prompt
proml

# ls alias
alias ls='ls --color=auto'
alias l='ls -lh'
alias ll='ls -lh'
alias la='ls -ha'
alias lla='ls -lha'

# gcc/g++ alias
alias gw='gcc -Wextra -Wall'
alias gw+='g++ -Wextra -Wall'

# color alias
alias tree='tree -C'
alias grep='grep --color=auto'

# security alias
alias rm='rm --preserve-root'
alias su='su -'

# shortcut alias
alias vi='vim'
alias svnci='svn ci -m "" && svn st'
alias svnup='svn up && svn st'
alias gitlist='git ls-tree --full-tree -r HEAD'

# utils alias
alias pong='ping 8.8.8.8'
alias norandom='setarch x86_64 -R'
alias pdf='evince'
alias iftop='iftop -B'
alias trenfr='translate -s freetranslation -f en -t fr'
alias trfren='translate -s freetranslation -f fr -t en'

# Disable core dumps
ulimit -S -c 0

if [ -f /usr/share/bash-completion/bash_completion ] && ! shopt -oq posix; then
    . /usr/share/bash-completion/bash_completion
fi
