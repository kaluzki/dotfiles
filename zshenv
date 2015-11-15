#!/bin/sh
#===============================================================================
## IMPLEMENTATION
##    author          Demajn Kaluzki
##    license         The MIT License (MIT)
#===============================================================================

# Configuration
PREZTO_DIR=~/dotfiles/prezto
PREZTORC="${PREZTO_DIR}/runcoms/zpreztorc"

# Load original files
[ -s "${PREZTO_DIR}/runcoms/zshenv" ] && source "${PREZTO_DIR}/runcoms/zshenv"
[ -s "${PREZTO_DIR}/runcoms/zprofile" ] && source "${PREZTO_DIR}/runcoms/zprofile"