#!/usr/bin/env zsh
# Tests for the Git helpers in ../git.zsh, run against a throwaway repository.

emulate -L zsh

source "${0:A:h}/../git.zsh"

fails=0
repo=$(mktemp -d)
trap 'rm -rf "$repo"' EXIT
cd "$repo"

export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
export GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.com
export GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.com

assert_eq() {
  if [[ $2 == "$3" ]]; then
    print -r -- "ok   $1"
  else
    print -r -- "FAIL $1: expected '$3', got '$2'"
    (( fails++ ))
  fi
}

commit() { print -r -- "$2" >"$1" && git add "$1" && git commit -qm "$1"; }
branches() { git for-each-ref refs/heads/ --format='%(refname:short)' | sort | xargs; }

git init -q -b main
commit base base
git branch develop

git checkout -qb merged && commit merged merged
git checkout -q main && git merge -q --no-ff --no-edit merged

git checkout -qb squashed && commit s1 one && commit s2 two
git checkout -q main && git merge -q --squash squashed >/dev/null && git commit -qm 'squash'

git checkout -qb unmerged && commit wip wip
git checkout -q main
git checkout -qb current

assert_eq "default branch is detected" "$(__git.default_branch)" main

gbda >/dev/null
assert_eq "gbda deletes merged and squash-merged branches only" \
  "$(branches)" "current develop main unmerged"

git checkout -q main
assert_eq "gcom checks out the default branch" "$(git checkout -q current && gcom -q && git branch --show-current)" main

commit dirty dirty
print change >>dirty
gwip >/dev/null
assert_eq "gwip commits everything as a WIP commit" "$(git log -1 --format=%s)/$(git status --porcelain)" "--wip--/"
gunwip >/dev/null
assert_eq "gunwip undoes the WIP commit" "$(git log -1 --format=%s)/$(git status --porcelain)" "dirty/ M dirty"

(( fails == 0 )) && print "all tests passed"
exit $(( fails > 0 ))
