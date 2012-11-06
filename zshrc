#ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="wedisagree"
#ZSH_THEME="sorin"
ZSH_THEME="wezm"

DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true" 

. /Users/Magnus/bin/z.sh

plugins=(git brew zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

### Aliases --------------------------------------
alias c="clear"
alias m="mvim ."
alias vim="~/Applications/MacVim.app/Contents/MacOS/Vim"
alias servethis="python -m SimpleHTTPServer"
alias deployblog="rsync -avz _site/ magnus@m8ck.us.to:www/m8ck.us.to"
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
#I don't like this feature. I think no one does. It corrects you, when you are trying to create new files, for example.
unsetopt correctall
export EDITOR="vim"
export PATH="/usr/local/bin:/usr/local/sbin:/Users/Magnus/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/MacOS/bin:$PATH"
