#!/bin/sh

DIR=$(pwd)

cd "$DIR" || exit 1

git submodule init && git submodule update || exit 1

touch ~/.env
mkdir ~/.nvm

if [ ! -f "$DIR/zshrc" ]; then
    echo "Error: $DIR/zshrc not found."
    exit 1
fi
ln -s "$DIR/zshrc" ~/.zshrc

if [ ! -f "$DIR/tmux.conf" ]; then
    echo "Error: $DIR/tmux.conf not found."
    exit 1
fi
ln -s "$DIR/tmux.conf" ~/.tmux.conf

if [ ! -f "$DIR/gitignore" ]; then
    echo "Error: $DIR/gitignore not found."
    exit 1
fi
ln -s "$DIR/gitignore" ~/.gitignore

if [ ! -f "$DIR/nvm/default-packages" ]; then
    echo "Error: $DIR/nvm/default-packages not found."
    exit 1
fi
ln -s "$DIR/nvm/default-packages" ~/.nvm/default-packages
