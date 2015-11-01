#!/bin/sh

command -v ansible >/dev/null 2>&1 || {
  echo >&2 "
Please install ansible first:

sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible

"; exit 1;
}

ansible all -i "localhost," -c local -b -m apt -a 'name=git state=latest'
ansible all -i "localhost," -c local -m git -a 'repo=https://github.com/kaluzki/dotfiles.git dest=~/dotfiles'