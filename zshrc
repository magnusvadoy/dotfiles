ZSH=$HOME/.oh-my-zsh
ZSH_THEME="prose"

#DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git brew pip sprunge zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### Aliases --------------------------------------
alias c="clear"
alias t='python ~/Dropbox/scripts/t/t.py --task-dir ~/Dropbox/scripts/t/todo --list tasks'
alias m="mvim ."
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias ping="ping -c 5"

# Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

### Environment ------------------------------------
export LANG=nb_NO.UTF-8
export LC_CTYPE=nb_NO.UTF-8
export EDITOR="vim"
export PATH="/Users/Magnus/.rvm/gems/ruby-1.9.2-p320/bin:/Users/Magnus/.rvm/gems/ruby-1.9.2-p320@global/bin:/Users/Magnus/.rvm/bin:/usr/local/bin:/usr/local/sbin:/Users/Magnus/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
