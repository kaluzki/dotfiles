#!/bin/sh
#===============================================================================
## SYNOPSIS
##    curl https://git.io/dotfiles.sh -L | sh -s kaluzki/dotfiles/uninstall.sh
##
## IMPLEMENTATION
##    author          Demajn Kaluzki
##    license         The MIT License (MIT)
#===============================================================================

sudo apt-get -y remove zsh
cd
rm -rf .z* dotfiles