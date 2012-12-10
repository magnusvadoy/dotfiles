### Oh-my-zsh settings 	--------------------------
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="dstufft"

# CASE_SENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# COMPLETION_WAITING_DOTS="true"

### download all images from 4chan thread--------
4chandl() {
	wget -O - $1 |
	grep -Eo 'images.4chan.org/[^"]+' |
	uniq |
	xargs wget
}

### z is the new j -------------------------------

. /Users/Magnus/bin/z.sh

function precmd () {
	z --add "$(pwd -P)"
}

### Aliases --------------------------------------
alias c="clear"
alias l="ls -l"
#alias m="mvim ."
#alias vim="~/Applications/MacVim.app/Contents/MacOS/Vim"
alias servethis="python -m SimpleHTTPServer"
alias deployblog="rsync -avz _site/ root@m8ck.us.to:/var/www/m8ck.us.to"
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
alias gsa="git submodule add"
alias gsi="git submodule init"

# Show/hide hidden files in finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

plugins=(git brew)
source $ZSH/oh-my-zsh.sh

fpath=(/usr/local/share/zsh-completions $fpath) # zsh completion
export EDITOR="vim"
#export EDITOR="mate -w"
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/Users/Magnus/bin
