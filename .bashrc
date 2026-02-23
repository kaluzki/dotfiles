#!/usr/bin/env bash

# shellcheck source=/dev/null
[[ -f ~/.profile ]] && . ~/.profile
case $- in
  *i*) ;;
  *) return;;
esac

PATH="$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH"

command -v mise >/dev/null && eval "$(mise activate bash)" && eval "$(mise completion bash --include-bash-completion-lib)"
command -v starship >/dev/null && eval "$(starship init bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v atuin >/dev/null && eval "$(atuin init bash)"

## PROMPT
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
if [[ -n "$HISTFILE" ]]; then
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
fi

if command -v xclip > /dev/null; then
  alias pbpaste-last='history -p "!!" | tr -d "\n" | xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# navigation
export LC_COLLATE="C"
shopt -s autocd 2> /dev/null
shopt -s dirspell 2> /dev/null
shopt -s cdspell 2> /dev/null
CDPATH="."

alias ll='ls --group-directories-first -FlAh --color=auto'
alias l='ls --group-directories-first -Flah --color=auto'
alias lt='ls --group-directories-first -FlAht --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# disk usage
#alias dus='du -hs .'

# grep
#alias gr='grep -Hirn --exclude-dir=.git --exclude-dir=.svn --exclude-dir=.idea'

# docker
#alias d-install='curl -sSL https://get.docker.com/ | sh && sudo usermod -aG docker $USER'

### nw
alias shop='cd ~/apps/oxid-shop/ && docker compose up -d --remove-orphans && docker compose exec shop-php bash'

## completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
