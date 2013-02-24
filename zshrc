## Oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="myusuf3"

# DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"

## Show archey at launch
~/bin/archey

## download all images from 4chan thread
4chandl() {
	wget -O - $1 |
	grep -Eo 'images.4chan.org/[^"]+' |
	uniq |
	xargs wget
}

## z is the new j

. /Users/Magnus/Github/z/z.sh

## Aliases
alias c="clear"
alias o="open"
alias oo="open ."
alias m="mvim ."
alias t="vim ~/Dropbox/Notater/todo.txt"
alias runserver='python manage.py runserver'
alias vim="/usr/local/Cellar/macvim/7.3-66/MacVim.app/Contents/MacOS/Vim"
alias syncdb='python manage.py syncdb'
alias servethis="python -m SimpleHTTPServer"
alias imdb="/Users/Magnus/Github/TerminalIMdB/terminalMDB.py"

# Quick way to rebuild the Launch Services database and get rid
# of duplicates in the Open With submenu.
alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'

## Useful git aliases
alias gb='git branch -a -v'
alias gs='git status'
alias gd='git diff | opendiff'
alias gca='git commit -av'
alias gcia='git commit -v -a -i'
alias grm='git ls-files --deleted | xargs git rm'
alias gcm='git checkout master'
alias gpr='git pull --rebase'
alias gspr='git stash; gpr; git stash apply'
alias pull='git pull --rebase'
alias push='git push'
alias gre='git rebase master'
alias gitl='git log --pretty=format:"%h %Cblue %an %Cred %s"'
alias gsa="git submodule add"
alias gsi="git submodule init"

## Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

plugins=(git brew gem cloudapp)
source $ZSH/oh-my-zsh.sh


#fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
export PATH=/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/Users/Magnus/bin:/usr/local/sbin
