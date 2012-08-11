ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="prose"
ZSH_THEME="steeef"

#DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git brew zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### Aliases --------------------------------------
alias ls="gls --color"
alias c="clear"
alias t='python ~/Dropbox/scripts/t/t.py --task-dir ~/Dropbox/scripts/t/todo --list tasks'
alias m="mvim ."
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias ping="ping -c 5"
alias weechat="weechat-curses"
alias serve_this="python -m SimpleHTTPServer"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias o="open"
alias oo="open ."

# Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

### Environment ------------------------------------
# export LANG=nb_NO.UTF-8
# export LC_CTYPE=nb_NO.UTF-8
export EDITOR="vim"
export PATH="/usr/local/bin:/usr/local/sbin:/Users/Magnus/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
