#!/usr/bin/env zsh

[[ -f ~/.zshenv ]] && . ~/.zshenv
[[ -o interactive ]] || return

command -v mise >/dev/null && eval "$(mise activate zsh)" && eval "$(mise completion zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v sheldon >/dev/null && eval "$(sheldon source)"
command -v atuin >/dev/null && eval "$(atuin init zsh)"

## completion
fpath=(~/.local/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"