#######################################
###     ANTIGEN 
#######################################

# Configure Completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Load the oh-my-zsh's library.
source ~/code/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
 
# Bundles from oh-my-zsh
antigen bundle git # adds some useful aliases and functions
antigen bundle gitfast # faster completion for git
antigen bundle npm # completion and aliases
antigen bundle mvn # completion and aliases
antigen bundle docker-compose # completion and aliases
antigen bundle fzf # enabled fzf's key bindings and auto-completion
antigen bundle history-substring-search # fish shell history search feature

# Bundles from other repos
antigen bundle zsh-users/zsh-completions # additonal completions
antigen bundle zsh-users/zsh-autosuggestions # fisk like autosuggestions based on history
antigen bundle zsh-users/zsh-syntax-highlighting # fish shell like syntax highlighting 
antigen bundle agkozak/zsh-z # jump quickly to recent directories
antigen bundle lukechilds/zsh-nvm # installs and sources nvm

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

alias vi="vim"
alias vim="nvim"
alias tmux="tmux -CC"
alias newtmux="/opt/homebrew/bin/tmux -CC new -A -s main"

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

export EDITOR="code -w"
export PATH="$PATH:/Users/magnus/.dotnet/tools"

# Dotnet autocompletions
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

compdef _dotnet_zsh_complete dotnet

# iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

source ~/.env
