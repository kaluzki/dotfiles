#!/usr/bin/env bash

# interactive
case $- in
  *i*) ;;
  *) return;;
esac

# prompt
PS1='\n\w\n\$ '
set -o noclobber
shopt -s checkwinsize
#PROMPT_DIRTRIM=2
bind Space:magic-space
shopt -s globstar 2> /dev/null
shopt -s nocaseglob;
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

# history
shopt -s histappend
shopt -s cmdhist
PROMPT_COMMAND='history -a'
HISTFILESIZE=100000
HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
HISTTIMEFORMAT='%F %T '
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# navigation
export LC_COLLATE="C"
shopt -s autocd 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null
CDPATH="."
alias ll='ls --group-directories-first -FlAh --color=auto'
alias l='ls --group-directories-first -Flah --color=auto'
alias lt='ls --group-directories-first -FAlht --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# disk usage
alias du='du -h'
alias df='df -h'
alias dus='du -hs .'

# grep
alias gr='grep -Hirn --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.idea'

# docker
alias d-install='curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker $USER'

# go
export GOPATH=$HOME/go
PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$GOPATH/bin"

# completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# bashrc.d
[[ -d "$HOME/bashrc.d" ]] && {
  for script in "$HOME/bashrc.d/"*.sh; do
    # shellcheck disable=SC1090
    . "$script"
  done
  unset script
}
