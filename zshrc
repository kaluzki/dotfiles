#!/bin/sh
#===============================================================================
## IMPLEMENTATION
##    author          Demajn Kaluzki
##    license         The MIT License (MIT)
#===============================================================================

# Load original configuration
[ -s "${PREZTO_DIR}/runcoms/zshrc" ] && source "${PREZTO_DIR}/runcoms/zshrc"

# Alias to create a base box from the current running virtual box
alias vagrant-package='vagrant package --base $(VBoxManage list runningvms | cut -d " " -f 1 | tr -d "\"")'