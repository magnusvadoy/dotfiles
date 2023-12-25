#!/bin/sh

CONFIG_DIR="$HOME_DIR/.config"
TMUX_PLUGIN_DIR="$HOME_DIR/.tmux/plugins"
ANTIGEN_DIR="$HOME_DIR/.zsh"

# Create required directories
mkdir -p "$TMUX_PLUGIN_DIR" "$ANTIGEN_DIR" "$CONFIG_DIR"

# Clone necessary repos
git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
git clone https://github.com/zsh-users/antigen.git "$ZSH_DIR/antigen"

# necessary packages to install
brew_packages=(
    "git"
    "zsh"
    "nvim"
    "tmux"
    "go"
    "nodejs"
    "fzf"
    "rg"
    "fd"
    "bat"
    "git-delta"
    "yq"
    "tree"
    "lazygit"
    "grpcurl"
    "kubectx"
    "k9s"
)

# necessary casks to install
brew_casks=(
    "wezterm"
    "docker"
    "alt-tab"
    "rectangle"
    "scroll-reverser"
    "obsidian"
    "spotify"
    "caffeine"
    "clipy"
    "google-cloud-sdk"
    "postman"
)

# Install Homebrew packages
brew install $brew_packages

# Install Homebrew casks
brew install --cask $brew_casks

# Install font
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
