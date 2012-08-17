ZSH=$HOME/.oh-my-zsh
ZSH_THEME="steeef"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git brew zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### Aliases --------------------------------------
alias ls="gls --color"
alias c="clear"
alias t='python ~/Dropbox/scripts/t/t.py --task-dir ~/Dropbox/scripts/t/todo --list tasks'
alias m="mvim ."
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias serve_this="python -m SimpleHTTPServer"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias o="open"
alias oo="open ."

# git + hub
alias git="hub"

# Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

### Environment ------------------------------------
fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
export PATH="/usr/local/bin:/usr/local/sbin:/Users/Magnus/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
