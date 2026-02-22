#!/usr/bin/env zsh

command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v sheldon >/dev/null && eval "$(sheldon source)"