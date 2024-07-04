alias g='git'

alias gst='git status'

alias gl='git pull'
alias gp='git push'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -va'
alias gca!='git commit -va --amend'
alias gcm='git commit -m'
alias gcam='git commit -am'

alias gco='git checkout'
alias gcb='git checkout -b'

alias gb='git branch'
alias gba='git branch -av'
alias gbd='git branch -d'
alias gbD='git branch -D'

alias gcp='git cherry-pick'

alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

alias grs='git restore'
alias grst='git restore --staged'

alias gsta='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gsts='git stash show --text'

# these alias commit and uncomit wip branches
alias gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "wip"'
alias gunwip='git log -n 1 | grep -q -c wip; and git reset HEAD~1'
