source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load bundles
antigen bundle gitfast
antigen bundle npm
antigen bundle mvn
antigen bundle fzf
antigen bundle docker
antigen bundle docker-compose
antigen bundle command-not-found
antigen bundle history-substring-search
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle reegnz/jq-zsh-plugin
antigen bundle agkozak/zsh-z
antigen bundle yardnsm/blox-zsh-theme

# Apply antigen setup
antigen apply

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Allow switching between different JDKs
jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
}

# File transfer from terminal
transfer() {
    curl --progress-bar --upload-file "$1" https://transfer.sh/$(basename "$1") | tee /dev/null;
    echo
}

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

source ~/.env

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/magnus/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)