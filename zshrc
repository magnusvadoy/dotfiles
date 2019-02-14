export PATH=/home/magnus/bin/:$PATH
alias home="cd /mnt/c/Users/net"
alias zshconfig="vim ~/.zshrc"
alias ghci="ghci.exe"

source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle zsh-users/zsh-completions
antigen bundle rupa/z

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme clean
# antigen theme jnrowe
# antigen theme mh
antigen theme geometry-zsh/geometry
# antigen theme agnoster/agnoster-zsh-theme
# antigen theme agkozak/agkozak-zsh-prompt

# Tell Antigen that you're done.
antigen apply

#Change ls colours
LS_COLORS="ow=01;36;40" && export LS_COLORS

##make cd use the ls colours
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -Uz compinit
compinit

