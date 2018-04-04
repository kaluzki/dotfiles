#!/usr/bin/env bash

# include .bashrc if it exists
[ -n "$BASH_VERSION" ] && [ -s "$HOME/.bashrc" ] && . "$HOME/.bashrc"

[ -s "$HOME/etc/profile.d/profile.sh" ] && . "$HOME/etc/profile.d/profile.sh"