source ~/Dropbox/Projects/dotfiles/antigen/antigen.zsh
export PATH="/usr/local/opt/python/libexec/bin:$HOME/Library/Haskell/bin:$HOME/bin:/opt/apache-maven-3.5.2/bin:$PATH"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell
antigen theme candy

# Tell Antigen that you're done.
antigen apply
