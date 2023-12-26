######################################
##     HOMEBREW
######################################

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

######################################
##     ANTIGEN
######################################

# Load the oh-my-zsh's library.
source ~/.zsh/antigen/antigen.zsh
antigen use oh-my-zsh
 
# Bundles from oh-my-zsh
antigen bundle git # git aliases
antigen bundle gitfast # faster completion for git
antigen bundle kubectl # adds some useful aliases and functions
antigen bundle fzf # enabled fzf's key bindings and auto-completion
antigen bundle history-substring-search # fish shell history search feature

# Bundles from other repos
antigen bundle zsh-users/zsh-completions # additonal completions
antigen bundle zsh-users/zsh-autosuggestions # fisk like autosuggestions based on history
antigen bundle zsh-users/zsh-syntax-highlighting # fish shell like syntax highlighting 
antigen bundle agkozak/zsh-z # jump quickly to recent directories
antigen bundle jeffreytse/zsh-vi-mode # vi mode
antigen bundle wfxr/forgit # git commands with fzf

# Theme
antigen theme spaceship-prompt/spaceship-prompt

# Apply antigen setup
antigen apply

#######################################
###     Aliases 
#######################################

alias vim="nvim"
alias vi="vim"
alias cat="bat --paging=never"
alias dc="docker compose"
alias ...="../.."
alias ....="../../.."

#######################################
###     Bindings 
#######################################

# bind UP and DOWN arrow keys to history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

#######################################
###     Environment 
#######################################

export EDITOR="nvim"
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$HOME/.local/bin:$PATH"

# FZF
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude '.git' --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type directory '' $HOME"
export FZF_DEFAULT_OPTS="
--ansi 
--prompt ' '
--pointer ''
--marker '┃'
--layout reverse 
--preview-window 'right:60%' 
--preview 'bat --color=always --line-range :300 {}'
--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down
"

# eza
export eza_params=('--git' '--icons' '--classify' '--group-directories-first' '--time-style=long-iso' '--group' '--color-scale')

alias ls='eza $eza_params'
alias l='eza --git-ignore $eza_params'
alias ll='eza --all --header --long $eza_params'
alias llm='eza --all --header --long --sort=modified $eza_params'
alias la='eza -lbhHigUmuSa'
alias lx='eza -lbhHigUmuSa@'
alias lt='eza --tree $eza_params'
alias tree='eza --tree $eza_params'
