#!/usr/bin/env bash

# include .bashrc if it exists
[ -n "$BASH_VERSION" ] && [ -s "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
