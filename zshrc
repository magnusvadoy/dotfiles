## Oh-my-zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="prose"

# DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"

. /Users/Magnus/Github/z/z.sh

# Shortcuts
alias c="clear"
alias o="open"
alias oo="open ."
alias m="mvim ."
# alias vim="/usr/local/Cellar/macvim/7.3-66/MacVim.app/Contents/MacOS/Vim"

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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
#fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
export PATH=/bin:/usr/sbin:/sbin:/usr/bin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/Users/Magnus/bin:/usr/local/sbin
