source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# alias to create a base box from the current running virtual box
alias vagrant-package='vagrant package --base $(VBoxManage list runningvms | cut -d " " -f 1 | tr -d "\"")'