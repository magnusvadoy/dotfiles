#######################################
###     ANTIGEN 
#######################################

# Load the oh-my-zsh's library.
source ~/code/dotfiles/antigen/antigen.zsh
antigen use oh-my-zsh
 
# Bundles from oh-my-zsh
antigen bundle git # adds some useful aliases and functions
antigen bundle gitfast # faster completion for git
antigen bundle npm # completion and aliases
antigen bundle mvn # completion and aliases
antigen bundle fzf # enabled fzf's key bindings and auto-completion
antigen bundle nvm # sources nvm and adds completiontigen bundle docker # completion and aliases
antigen bundle docker-compose # completion and aliases
antigen bundle history-substring-search # fish shell history search feature

# Bundles from other repos
antigen bundle zsh-users/zsh-completions # additonal completions
antigen bundle zsh-users/zsh-autosuggestions # autosuggestions based on history
antigen bundle zsh-users/zsh-syntax-highlighting # fish shell like syntax highlighting 
antigen bundle reegnz/jq-zsh-plugin # interactive jq expression builder (alt + j)
antigen bundle agkozak/zsh-z # jump quickly to recent directories

# Theme
antigen bundle yardnsm/blox-zsh-theme
BLOX_CONF__ONELINE=true

# Apply antigen setup
antigen apply

#######################################
###     Aliases 
#######################################

alias vi="vim"

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

export PATH=$HOME/.rd/bin:$PATH
export EDITOR="vim"

# iterm 2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.env

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
