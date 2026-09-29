# Minimal fallback config. fish is the main shell, see ~/.config/fish/config.fish

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR="nvim"
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/.local/bin:$GOPATH/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

### History ###
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

### Completion & key bindings ###
autoload -Uz compinit && compinit
bindkey -v

### Tools ###
command -v mise >/dev/null && eval "$(mise activate zsh)"
command -v fzf >/dev/null && source <(fzf --zsh)
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

alias vim="nvim"
alias ls="eza --git --icons --group --time-style=long-iso"
alias ll="ls --all --header --long"

PROMPT='%F{yellow}%~%f ❯ '
