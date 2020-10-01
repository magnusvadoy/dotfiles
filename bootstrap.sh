#!/bin/sh
DOTFILES_DIR=$(dirname $(readlink -f $0))

cd $DOTFILES_DIR

git submodule init
git submodule update

ln -s $DOTFILES_DIR/zshrc ~/.zshrc
ln -s $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -s $DOTFILES_DIR/gitignore ~/.gitignore

touch ~/.secrets
