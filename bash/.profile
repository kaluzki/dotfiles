#!/usr/bin/env bash

[[ -d "$HOME/profile.d" ]] && {
  for script in "$HOME/profile.d/"*.sh; do
    # shellcheck disable=SC1090
    . "$script"
  done
  unset script
}

# Added by Toolbox App
PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# Generated for envman
[ -s "$HOME/.config/envman/load.sh" ] && . "$HOME/.config/envman/load.sh"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && . "$HOME/.sdkman/bin/sdkman-init.sh"

[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
