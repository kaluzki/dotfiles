#!/usr/bin/env bash

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# navigation
alias ll='LC_COLLATE=C ls -alFh --group-directories-first'
alias la='LC_COLLATE=C ls -A --group-directories-first'
alias l='LC_COLLATE=C ls -AlFh --group-directories-first'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .....='cd ../../../..'

mkcd() {
  mkdir "$1"
  cd "$1"
}

alias rm='rm -r'
alias gr='grep -Hirn --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.idea'

# disk usage
alias du='du -h'
alias df='df -h'
alias dus='du -hs .'

# user administration
alias ua='sudo useradd -m -s /bin/bash'
alias ur='sudo userdel'

# apt
alias apt-install='sudo apt-get install -y --show-progress'
alias apt-remove='sudo apt-get remove -y --show-progress'
alias apt-update='sudo apt-get update -y'
alias apt-upgrade='sudo apt-get upgrade -y'
alias apt-repo='sudo add-apt-repository -y -u'

# internet
alias dw='curl -LO --progress-bar'
alias x='tzz extract'

# development
alias di='meld .'
alias st='git status -s'
alias ci='git commit'

# system
alias reboot='sudo reboot'

# docker
alias d-install='curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker $USER'
alias d-images='docker images'

alias d-ps='docker ps'
alias d-id='docker ps --quiet --latest'
alias d-id-running='docker ps --quiet --latest --filter status=running'
alias d-ids='docker ps --quiet --all'
alias d-ids-running='docker ps --quiet --all --filter status=running'

alias d-run='docker run'
alias d-run-daemon='docker run --detach'
alias d-run-interactive='docker run --interactive --tty'
alias d-sh='_docker_run true /bin/sh'
alias d-bash='_docker_run true /bin/bash'

alias d-stop='docker stop'
alias d-rm='docker rm'

alias d-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias d-tags="_docker_tags"

##
# @param bool interactive
# @param mixed... cmd
# @param string image
##
_docker_run() {
    local interactive image cmd
    [ $1 = 'true' ] && interactive='--interactive --tty' || interactive='--detach'
    image="${@: -1}" # the last argument
    cmd=${@:2:$(($#-2))} # all arguments except the first and last one
    docker run --publish-all $interactive $image $cmd
}

# FUNCTIONS

##
# hide stdout
##
tzz() {
    "$@" > /dev/null || return $?
}

##
# hide stdout and stderr
##
TZZ() {
    "$@" &> /dev/null || return $?
}

##
# extract archives in unified manner
##
extract() {
    mime_type=`file -b --mime-type "$1"`
    case "$mime_type" in
        'application/gzip') tar xfz "$1"
        ;;
        'application/x-bzip2') tar xfj "$1"
        ;;
        'application/x-tar') tar xf "$1"
        ;;
        'application/zip') unzip "$1"
        ;;
    esac
}