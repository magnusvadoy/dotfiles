######################################
##     HOMEBREW
######################################

# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
# fi

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

# Theme: https://github.com/yardnsm/blox-zsh-theme
antigen bundle yardnsm/blox-zsh-theme
BLOX_CONF__ONELINE=false
BLOX_CONF__BLOCK_SEPARATOR=' '
BLOX_BLOCK__CWD_TRUNC=3

BLOX_SEG__UPPER_LEFT=( host cwd git exec_time )
BLOX_SEG__UPPER_RIGHT=( bgjobs nodejs time )
BLOX_SEG__LOWER_LEFT=( symbol )
BLOX_SEG__LOWER_RIGHT=( )

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
export PATH="$GOPATH/bin:$PATH"

# FZF
export FZF_DEFAULT_COMMAND="fd --type file --follow --hidden --exclude '.git' --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type directory '' $HOME"
export FZF_DEFAULT_OPTS="--ansi --layout reverse --preview-window 'right:60%' --preview 'bat --color=always --line-range :300 {}'"
