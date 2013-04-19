## Oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="crunch"
#ZSH_THEME="myusuf3"

# DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"

## Show archey at launch
~/bin/archey

## z is the new j
. /Users/Magnus/Github/z/z.sh

###### Aliases ######
# Shortcuts
alias c="clear"
alias o="open"
alias oo="open ."
alias m="mvim ."
alias vim="/usr/local/Cellar/macvim/7.3-66/MacVim.app/Contents/MacOS/Vim"

# Python
alias runserver='python manage.py runserver'
alias servethis="python -m SimpleHTTPServer"

# Terminal access to IMDb
alias imdb="/Users/Magnus/Github/TerminalIMdB/terminalMDB.py"

#copy output of last command to clipboard
alias cl="fc -e -|pbcopy"

# top
alias cpu='top -o cpu'
alias mem='top -o rsize' # memory

# copy the working directory path
alias cpwd='pwd|tr -d "\n"|pbcopy'

# DNS (with update thanks to @blanco)
alias flush="sudo killall -HUP mDNSResponder"

# ls better
alias la="ls -aF"
alias ld="ls -ld"
alias ll="ls -l"
alias lt='ls -At1 && echo "------Oldest--"'
alias ltr='ls -Art1 && echo "------Newest--"'

# mute the system volume
alias stfu="osascript -e 'set volume output muted true'"

# Get your current public IP
alias ip="curl icanhazip.com"

# list TODO/FIX lines from the current project
alias todos="ack -n --nogroup '(TODO|FIX(ME)?):'"

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

plugins=(git brew)
source $ZSH/oh-my-zsh.sh

#fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
export PATH=/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/Users/Magnus/bin:/usr/local/sbin
