#!/bin/zsh

# Define the home directory and target directories
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOME_DIR="$HOME"
TMUX_PLUGIN_DIR="$HOME_DIR/.tmux/plugins"
ZSH_DIR="$HOME_DIR/.zsh"
CONFIG_DIR="$HOME_DIR/.config"

# Define an array of symlinks
declare -A symlinks=(
    ["zshrc"]="$HOME_DIR/.zshrc"
    ["gitignore"]="$HOME_DIR/.gitignore"
    ["gitconfig"]="$HOME_DIR/.gitconfig"
    ["nvim"]="$CONFIG_DIR/nvim"
    ["wezterm"]="$CONFIG_DIR/wezterm"
    ["tmux"]="$CONFIG_DIR/tmux"
    ["bat"]="$CONFIG_DIR/bat"
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
    "delta"
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
    "google-cloud-sdk"
)
# Install Homebrew packages
brew install $brew_packages

# Install Homebrew casks
brew install --cask $brew_casks

# Install font
brew tap homebrew/cask-fonts
brew install font-jetbrains-mono-nerd-font
