#!/bin/sh
#===============================================================================
## SYNOPSIS
##    curl https://git.io/dotfiles.sh -L | sh -s kaluzki/dotfiles/uninstall.sh
##
## IMPLEMENTATION
##    author          Demajn Kaluzki
##    license         The MIT License (MIT)
#===============================================================================

cd
for f in .*
  do
  dst=$(readlink -m "${f}")
  case $dst in
    ${HOME}/dotfiles/*) rm "${f}";;
  esac
done