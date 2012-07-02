ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

## Useful aliases
alias t="/Users/Magnus/Dropbox/todo/todo.sh"
alias spotify="osascript ~/bin/spotifycontrol.applescript"
alias vps="ssh magnus@m8ck.us.to"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
alias c="clear"

## Faster and easier navigation
alias l="ls -Gl"
alias ls="ls -G"
alias la="ls -Gla"
alias lsd='ls -l | grep "^d"'
alias lsda='ls -Gla | grep "^d"'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew)

source $ZSH/oh-my-zsh.sh

# Terminal 256 colors                                                                           
export TERM="xterm-256color"  
# Make vim the default editor
export EDITOR="vim"
# Dont clear the screen after quitting a manual page
export MANPAGER="less -X"
# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=/Users/Magnus/.rvm/gems/ruby-1.9.3-p194/bin:/Users/Magnus/.rvm/gems/ruby-1.9.3-p194@global/bin:/Users/Magnus/.rvm/rubies/ruby-1.9.3-p194/bin:/Users/Magnus/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/git/bin:/Users/Magnus/.rvm/gems/ruby-1.9.3-p194/bin:/Users/Magnus/.rvm/gems/ruby-1.9.3-p194@global/bin:/Users/Magnus/.rvm/rubies/ruby-1.9.3-p194/bin:/Users/Magnus/.rvm/bin