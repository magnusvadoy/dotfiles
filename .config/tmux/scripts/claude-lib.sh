# Shared helpers for the Claude agent tracking scripts. Source, don't execute.

# ~/code/foo/.claude/worktrees/bar -> foo/bar, anything else -> its basename.
project() {
	local path=$1
	if [[ $path == */.claude/worktrees/* ]]; then
		local repo=${path%%/.claude/worktrees/*}
		local wt=${path#*/.claude/worktrees/}
		printf '%s/%s' "${repo##*/}" "${wt%%/*}"
	else
		printf '%s' "${path##*/}"
	fi
}
