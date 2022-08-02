source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load bundles
# Bundles from oh-my-zsh
antigen bundle git # adds some useful aliases and functions
antigen bundle gitfast # faster completion for git
antigen bundle npm # completion and aliases
antigen bundle mvn # completion and aliases
antigen bundle fzf # enabled fzf's key bindings and auto-completion
antigen bundle nvm # sources nvm and adds completion
antigen bundle docker # completion and aliases
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

# Apply antigen setup
antigen apply

# bind UP and DOWN arrow keys to history search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Aliases
export EDITOR="nvim"

alias vi="nvim"
alias vim="nvim"
alias cat="bat"

# start with a space to be ignored in history
alias zedit=" $EDITOR ~/.zshrc"
alias viedit=" $EDITOR ~/.config/nvim/init.vim"

# Functions
# Allow switching between different JDKs
jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
}

# Load env vars
source ~/.env

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/magnus/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
