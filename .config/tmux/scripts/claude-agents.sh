#!/usr/bin/env bash
# List every Claude Code agent across all tmux sessions in fzf and jump to the chosen pane.
#
# Usage: claude-agents.sh          interactive picker (run inside a tmux popup)
#        claude-agents.sh --list   print the agent table (pane id, then columns)

set -uo pipefail

# shellcheck source=claude-lib.sh
source "$(dirname "$0")/claude-lib.sh"

# Panes whose state was never recorded (e.g. started before the hooks existed) are still
# detected by their process: Claude shows up as "claude" or as its bare version number.
is_claude_cmd() {
	[[ $1 == claude || $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

age() {
	local s=$1
	if ((s < 60)); then
		printf '%ds' "$s"
	elif ((s < 3600)); then
		printf '%dm' $((s / 60))
	elif ((s < 86400)); then
		printf '%dh' $((s / 3600))
	else
		printf '%dd' $((s / 86400))
	fi
}

list() {
	local now
	now=$(date +%s)
	local sep=$'\x1f'
	tmux list-panes -a -F "#{pane_id}${sep}#{@claude_state}${sep}#{@claude_since}${sep}#{session_name}:#{window_index}.#{pane_index}${sep}#{pane_current_command}${sep}#{pane_current_path}${sep}#{@claude_prompt}${sep}#{@claude_note}" |
		while IFS=$sep read -r id state since target cmd path prompt note; do
			if [[ -z $state ]]; then
				is_claude_cmd "$cmd" || continue
				state=unknown
			fi
			local rank icon color when=""
			case $state in
			waiting) rank=1 icon='◆' color=31 ;;
			done) rank=2 icon='✓' color=32 ;;
			working) rank=3 icon='●' color=33 ;;
			idle) rank=4 icon='○' color=90 ;;
			*) rank=5 icon='?' color=90 ;;
			esac
			[[ -n $since ]] && when=$(age $((now - since)))
			local text=${note:-$prompt}
			printf '%s\t%s\t\033[%sm%s %-8s\033[0m %4s  %-22s  \033[36m%-32.32s\033[0m  %s\n' \
				"$rank" "$id" "$color" "$icon" "$state" "$when" "$target" "$(project "$path")" "$text"
		done |
		sort -t$'\t' -k1,1n -k2,2 | cut -f2-
}

if [[ ${1:-} == --list ]]; then
	list
	exit 0
fi

self=$(command -v "$0" || printf '%s' "$0")
choice=$(list | fzf --ansi --no-sort --reverse --delimiter '\t' --with-nth 2 \
	--border-label ' claude agents ' --prompt '🤖  ' \
	--header '  enter jump  ^r reload  ^x kill pane' \
	--bind "ctrl-r:reload($self --list)" \
	--bind "ctrl-x:execute-silent(tmux kill-pane -t {1})+reload($self --list)" \
	--preview 'tmux capture-pane -ep -t {1}' \
	--preview-window 'down:60%:follow') || exit 0

pane=${choice%%$'\t'*}
tmux switch-client -t "$pane" \; select-window -t "$pane" \; select-pane -t "$pane"
