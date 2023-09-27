#!/bin/sh

DIR=$(pwd)
cd "$DIR"

# create required file structure
mkdir -p ~/.tmux/plugins
mkdir -p ~/.zsh/
mkdir ~/.config
touch ~/.env

# clone the necessary repos
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen 

# setup symlinks
ln -s "$DIR/zshrc" ~/.zshrc
ln -s "$DIR/tmux.conf" ~/.tmux.conf
ln -s "$DIR/gitignore" ~/.gitignore
ln -s "$DIR/gitconfig" ~/.gitconfig

# source zsh to install nvm, then copy default packages over
source ~/.zshrc
ln -s "$DIR/nvm/default-packages" ~/.nvm/default-packages
