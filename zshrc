ZSH=$HOME/.oh-my-zsh
ZSH_THEME="steeef"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git brew zsh-syntax-highlighting-filetypes zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### Aliases --------------------------------------
alias ls="gls -p --color"
alias c="clear"
alias t='python ~/Dropbox/scripts/t/t.py --task-dir ~/Dropbox/scripts/t/todo --list tasks'
alias m="mvim ."
alias vim="~/Applications/MacVim.app/Contents/MacOS/Vim"
alias serve_this="python -m SimpleHTTPServer"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias o="open"
alias oo="open ."

# git + hub
alias git="hub"

# Useful git aliases
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

# Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

### Environment ------------------------------------
fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
export PATH="/usr/local/bin:/usr/local/sbin:/Users/Magnus/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
