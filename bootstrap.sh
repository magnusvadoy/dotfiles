#!/bin/sh
DIR=$pwd

cd $DIR

git submodule init
git submodule update

touch ~/.env
mkdir ~/.nvm

ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitignore ~/.gitignore
ln -s $DIR/nvm/default-packages ~/.nvm/default-packages
