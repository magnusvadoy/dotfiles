#!/usr/bin/env bash
# Tests for the Claude agent tracking scripts, run against an isolated tmux server.

set -uo pipefail

dir=$(cd "$(dirname "$0")" && pwd)
server=claude-agents-test-$$
fails=0

tmux -L "$server" -f /dev/null new-session -d -s proj -x 200 -y 50
trap 'tmux -L "$server" kill-server 2>/dev/null' EXIT
tmux -L "$server" source-file "$dir/../tmux.conf" 2>/dev/null # plugins may fail; options still load
tmux -L "$server" split-window -t proj
socket=$(tmux -L "$server" display -p '#{socket_path}')
read -r p1 p2 < <(tmux -L "$server" list-panes -t proj -F '#{pane_id}' | xargs)

export TMUX="$socket,0,0"

# Never send real notifications: a fake Hammerspoon CLI records the Lua it is asked to run,
# and the Ghostty fallback writes to a file instead of the terminal.
notifications=$(mktemp)
ghostty=$(mktemp)
fake_hs=$(mktemp)
trap 'tmux -L "$server" kill-server 2>/dev/null; rm -f "$notifications" "$ghostty" "$fake_hs"' EXIT
printf '#!/usr/bin/env bash\nprintf "%%s\\n" "${@: -1}" >>%q\n' "$notifications" >"$fake_hs"
chmod +x "$fake_hs"
export CLAUDE_HS=$fake_hs CLAUDE_NOTIFY_TTY=$ghostty
notified() { grep -c '^claude.notify(' "$notifications"; }

assert_eq() {
	if [[ $2 == "$3" ]]; then
		echo "ok   $1"
	else
		echo "FAIL $1: expected '$3', got '$2'"
		fails=$((fails + 1))
	fi
}

opt() { tmux display -p -t "$1" "#{$2}"; }
hook() { TMUX_PANE=$1 "$dir/claude-state.sh" "$2" <<<"${3:-{\}}"; }

hook "$p1" working '{"prompt":"fix the\nlogin bug"}'
assert_eq "prompt sets working" "$(opt "$p1" @claude_state)" working
assert_eq "prompt is stored on one line" "$(opt "$p1" @claude_prompt)" "fix the login bug"

since=$(opt "$p1" @claude_since)
sleep 1
hook "$p1" working '{"tool_name":"Bash"}'
assert_eq "repeated state keeps its timestamp" "$(opt "$p1" @claude_since)" "$since"
assert_eq "tool use keeps the prompt" "$(opt "$p1" @claude_prompt)" "fix the login bug"

hook "$p2" waiting '{"message":"Claude needs your permission to use Bash"}'
assert_eq "notification sets waiting" "$(opt "$p2" @claude_state)" waiting
assert_eq "notification stores message" "$(opt "$p2" @claude_note)" "Claude needs your permission to use Bash"
assert_eq "waiting sends one notification" "$(notified)" 1
assert_eq "notification has title, project, target and message" \
	"$(grep -c '"◆ Claude needs you", ".* (proj:0)", "Claude needs your permission to use Bash"' "$notifications")" 1
assert_eq "notification click targets the pane" "$(grep -c "\"$socket\", \"$p2\")$" "$notifications")" 1
hook "$p2" waiting '{"message":"still waiting"}'
assert_eq "staying in waiting does not notify again" "$(notified)" 1

assert_eq "window markers" "$(tmux display -p -t proj "#{P:#{E:@claude_icon}}")" " ● ◆"
assert_eq "summary counts" "$("$dir/claude-summary.sh" | sed 's/#\[[^]]*\]//g')" "◆ 1 ● 1 "

list=$("$dir/claude-agents.sh" --list | sed $'s/\033\\[[0-9;]*m//g')
assert_eq "picker lists waiting first" "$(head -1 <<<"$list" | cut -f1)" "$p2"
assert_eq "picker shows the prompt" "$(grep -c 'fix the login bug' <<<"$list")" 1

hook "$p2" done
assert_eq "stop sets done and clears note" "$(opt "$p2" @claude_state)/$(opt "$p2" @claude_note)" "done/"
assert_eq "finishing sends a notification" "$(notified)" 2
assert_eq "finished notification falls back to Done" "$(grep -c '"✓ Claude finished", ".* (proj:0)", "Done"' "$notifications")" 1
assert_eq "working never notifies" "$(grep -c 'fix the login bug' "$notifications")" 0

hook "$p1" working '{"prompt":"say \"hi\" with a \\ backslash"}'
hook "$p1" done
assert_eq "quotes and backslashes are escaped for Lua" \
	"$(grep -cF '"say \"hi\" with a \\ backslash"' "$notifications")" 1

CLAUDE_HS=/nonexistent hook "$p2" waiting '{"message":"Needs input"}'
assert_eq "falls back to Ghostty without Hammerspoon" \
	"$(grep -c $'777;notify;◆ Claude needs you · .* (proj:0);Needs input\a' "$ghostty")" 1
assert_eq "Ghostty is not used when Hammerspoon works" "$(grep -c 'finished' "$ghostty")" 0

hook "$p1" clear
assert_eq "session end clears state" "$(opt "$p1" @claude_state)$(opt "$p1" @claude_prompt)" ""

assert_eq "hook outside tmux is a no-op" "$(TMUX_PANE='' "$dir/claude-state.sh" working <<<'{}'; echo $?)" 0

((fails == 0)) && echo "all tests passed"
exit $((fails > 0))
