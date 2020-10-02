source ~/dotfiles/antigen/antigen.zsh

# Avoid background processes to not bother Windows
unsetopt BG_NICE

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load bundles
antigen bundle git
antigen bundle npm
antigen bundle fzf
antigen bundle command-not-found
antigen bundle history-substring-search

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen bundle agkozak/zsh-z
antigen bundle lukechilds/zsh-nvm
antigen bundle yardnsm/blox-zsh-theme

# Apply antigen setup
antigen apply

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

source ~/.secrets
