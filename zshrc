export PATH=/home/magnus/bin/:$PATH
alias open="xdg-open"
alias zshconfig="vim ~/.zshrc"

source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
# antigen theme candy
# antigen theme clean
# antigen theme jnrowe
# antigen theme mh
antigen theme geometry-zsh/geometry

# Tell Antigen that you're done.
antigen apply
