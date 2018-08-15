#!/usr/bin/env bash

[ -d "$HOME/etc/profile.d" ] && {
    for i in "$HOME/etc/profile.d/"*.sh; do
      . "$i"
    done
    unset i
}