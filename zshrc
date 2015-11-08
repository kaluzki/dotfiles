source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# alias to add the current running virtual box to the local list of vagrant boxes
alias vagrant-box-add='vagrant package --base $(VBoxManage list runningvms | cut -d " " -f 1 | tr -d "\"")'