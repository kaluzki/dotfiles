#!/usr/bin/env bash

[[ -d "$HOME/etc/profile.d" ]] && {
    for script in "$HOME/etc/profile.d/"*.sh; do
        . "$script"
    done
    unset script
}
