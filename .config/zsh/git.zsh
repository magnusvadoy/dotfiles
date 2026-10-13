__git.default_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  branch=$(command git config --get init.defaultBranch)
  if [[ -n $branch ]] && command git show-ref -q --verify "refs/heads/$branch"; then
    print -r -- "$branch"
  elif command git show-ref -q --verify refs/heads/main; then
    print main
  else
    print master
  fi
}
gcom() {
  local branch
  branch=$(__git.default_branch) || return
  git checkout "$branch" "$@"
}
gbage() {
  git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' "$@"
}
gwip() { git add -A && git commit -m '--wip--' --no-verify; }
gunwip() { [[ $(git log -1 --format=%B) == *--wip--* ]] && git reset HEAD~1; }
git-update-all() {
  local dir result=0
  for dir in */(N); do
    [[ -e "$dir/.git" ]] || continue
    printf '\nUpdating %s\n' "$dir"
    git -C "$dir" pull --ff-only || result=$?
  done
  return $result
}
