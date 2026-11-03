#!/usr/bin/env bash
# Claude Code hook: record the agent state of the current tmux pane in pane options,
# which the status bar and the agent picker (claude-agents.sh) read. Also sends a macOS
# notification when an agent starts waiting or finishes in a pane you are not looking at.
#
# Usage: claude-state.sh <idle|working|waiting|done|clear>   (hook JSON on stdin)
#
# Notifications go through Hammerspoon so a click jumps to the pane, falling back to Ghostty.
# CLAUDE_HS overrides the Hammerspoon CLI path; CLAUDE_NOTIFY_TTY overrides where Ghostty
# notifications are written (default: the tmux client's tty).

set -uo pipefail

[[ -n "${TMUX_PANE:-}" ]] || exit 0

# shellcheck source=claude-lib.sh
source "$(dirname "$0")/claude-lib.sh"

state=${1:-}
input=$(cat)

if [[ $state == clear ]]; then
	for opt in @claude_state @claude_since @claude_prompt @claude_note; do
		tmux set -pu -t "$TMUX_PANE" "$opt" 2>/dev/null
	done
	exit 0
fi

# Collapse whitespace and truncate so values stay on one line in the picker.
oneline() {
	tr '\n\t\r' '   ' | tr -s ' ' | sed 's/^ //; s/ $//' | cut -c1-200
}

# True when the pane is on screen in a tmux client whose terminal window has focus.
pane_in_view() {
	local session visible
	IFS=$'\t' read -r session visible < <(tmux display -p -t "$TMUX_PANE" \
		$'#{session_name}\t#{&&:#{pane_active},#{window_active}}' 2>/dev/null)
	[[ $visible == 1 ]] || return 1
	tmux list-clients -F $'#{client_session}\t#{client_flags}' 2>/dev/null |
		awk -F'\t' -v s="$session" '$1 == s && $2 ~ /focused/ { found = 1 } END { exit !found }'
}

# Quote a value as a Lua string literal, dropping control characters.
lua_str() {
	local s
	s=$(LC_ALL=C tr -d '\000-\037' <<<"$1")
	s=${s//\\/\\\\}
	printf '"%s"' "${s//\"/\\\"}"
}

# Native macOS notification through Hammerspoon (~/.config/hammerspoon/init.lua), where
# clicking it jumps to this pane. Fails when Hammerspoon isn't running.
notify_hammerspoon() {
	local title=$1 subtitle=$2 message=$3 socket
	[[ -x $hs ]] || return 1
	socket=$(tmux display -p -t "$TMUX_PANE" '#{socket_path}' 2>/dev/null)
	# Hard limit on top of hs's own timeout, which doesn't cover every case (e.g. a reload),
	# so a stuck Hammerspoon can never stall the Claude hook.
	local limit=()
	command -v timeout >/dev/null && limit=(timeout 3)
	"${limit[@]}" "$hs" -q -t 2 -c "claude.notify($(lua_str "$title"), $(lua_str "$subtitle"), $(lua_str "$message"), \
$(lua_str "$(command -v tmux)"), $(lua_str "$socket"), $(lua_str "$TMUX_PANE"))" >/dev/null 2>&1
}

# Fallback: native notification through Ghostty (OSC 777), written straight to the terminal
# of the most recently active tmux client. Clicking it only brings Ghostty to the front.
notify_ghostty() {
	local title="$1 · $2" message=$3 tty
	tty=${CLAUDE_NOTIFY_TTY:-$(tmux list-clients -F $'#{client_activity}\t#{client_tty}' 2>/dev/null |
		sort -rn | head -1 | cut -f2)}
	[[ -n $tty ]] || return 0

	# The title is a ;-separated field and neither part may contain control characters.
	title=$(LC_ALL=C tr -d '\000-\037;' <<<"$title")
	message=$(LC_ALL=C tr -d '\000-\037' <<<"$message")
	printf '\e]777;notify;%s;%s\a' "$title" "$message" >>"$tty" 2>/dev/null
}

notify() {
	local title=$1 message=$2 target path subtitle
	IFS=$'\t' read -r target path < <(tmux display -p -t "$TMUX_PANE" \
		$'#{session_name}:#{window_index}\t#{pane_current_path}' 2>/dev/null)
	subtitle="$(project "$path") ($target)"
	notify_hammerspoon "$title" "$subtitle" "$message" || notify_ghostty "$title" "$subtitle" "$message"
}

hs=${CLAUDE_HS:-/Applications/Hammerspoon.app/Contents/Frameworks/hs/hs}

current=$(tmux display -p -t "$TMUX_PANE" '#{@claude_state}' 2>/dev/null)
if [[ $current != "$state" ]]; then
	tmux set -p -t "$TMUX_PANE" @claude_state "$state" \; \
		set -p -t "$TMUX_PANE" @claude_since "$(date +%s)" 2>/dev/null
fi

case $state in
working)
	prompt=$(jq -r '.prompt // empty' <<<"$input" 2>/dev/null | oneline)
	[[ -n $prompt ]] && tmux set -p -t "$TMUX_PANE" @claude_prompt "$prompt" 2>/dev/null
	tmux set -pu -t "$TMUX_PANE" @claude_note 2>/dev/null
	;;
waiting)
	note=$(jq -r '.message // ("Needs input: " + (.tool_name // "?"))' <<<"$input" 2>/dev/null | oneline)
	tmux set -p -t "$TMUX_PANE" @claude_note "$note" 2>/dev/null
	[[ $current != waiting ]] && ! pane_in_view && notify "◆ Claude needs you" "$note"
	;;
done)
	tmux set -pu -t "$TMUX_PANE" @claude_note 2>/dev/null
	if [[ $current != done ]] && ! pane_in_view; then
		prompt=$(tmux display -p -t "$TMUX_PANE" '#{@claude_prompt}' 2>/dev/null)
		notify "✓ Claude finished" "${prompt:-Done}"
	fi
	;;
*)
	tmux set -pu -t "$TMUX_PANE" @claude_note 2>/dev/null
	;;
esac

exit 0
