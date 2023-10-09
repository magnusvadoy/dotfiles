#######################################
###     HOMEBREW & MAC OS 
#######################################

if type brew &>/dev/null; then
  # Configure Completions
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  # Configure PATH
  export PATH="/usr/local/bin:/Users/magnus/go/bin:$PATH"

  # iterm2 shell integration
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

  # for iterm2 tmux integration
  alias tmux="tmux -CC"
fi

#######################################
###     ANTIGEN 
#######################################

# Load the oh-my-zsh's library.
source ~/.zsh/antigen/antigen.zsh
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
source ~/.env

export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
