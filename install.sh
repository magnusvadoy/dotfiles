#!/bin/sh
DIR=$pwd

cd $DIR

git submodule init
git submodule update

touch ~/.env
mkdir ~/.nvm
mkdir ~/.vim
mkdir -p ~/.config/nvim/lua

ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitignore ~/.gitignore
ln -s $DIR/nvm/default-packages ~/.nvm/default-packages
ln -s $DIR/vim/vimrc ~/.vim/vimrc
ln -s $DIR/nvim ~/.config/nvim

# Install vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
