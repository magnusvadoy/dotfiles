#!/bin/zsh

# Define the home directory and target directories
HOME_DIR="$HOME"
TMUX_PLUGIN_DIR="$HOME_DIR/.tmux/plugins"
ZSH_DIR="$HOME_DIR/.zsh"
CONFIG_DIR="$HOME_DIR/.config"

# Define an array of symlinks
declare -A symlinks=(
    ["zshrc"]="$HOME_DIR/.zshrc"
    ["gitignore"]="$HOME_DIR/.gitignore"
    ["gitconfig"]="$HOME_DIR/.gitconfig"
    ["wezterm.lua"]="$HOME_DIR/.wezterm.lua"
    ["tmux.conf"]="$TMUX_PLUGIN_DIR/.tmux.conf"
    ["nvim"]="$CONFIG_DIR/nvim"
)

# necessary packages to install
brew_packages=(
    "git"
    "zsh"
    "nvim"
    "tmux"
    "fzf"
    "go"
    "rg"
    "fd"
    "bat"
    "yq"
    "tree"
)

# necessary casks to install
brew_casks=(
    "wezterm"
    "docker"
    "alt-tab"
    "rectangle"
    "scroll-reverser"
    "obsidian"
    "google-cloud-sdk"
    "spotify"
    "caffeine"
)

# Create required directories
mkdir -p "$TMUX_PLUGIN_DIR" "$ZSH_DIR" "$CONFIG_DIR"

# Clone necessary repos
git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
git clone https://github.com/zsh-users/antigen.git "$ZSH_DIR/antigen"

# Create symlinks
for source_file in "${(@k)symlinks}"; do
    target_file="${symlinks[$source_file]}"
    ln -s "$DIR/$source_file" "$target_file"
done

# Source zsh to install nvm, then copy default packages over
source "$HOME_DIR/.zshrc"
ln -s "$DIR/nvm/default-packages" "$HOME_DIR/.nvm/default-packages"

# Install LTS version of Node using nvm
nvm install --lts

# Install Homebrew packages
brew install $brew_packages

# Install Homebrew casks
brew install --cask $brew_casks

# Install font
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
