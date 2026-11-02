#!/usr/bin/env bash
# Status bar segment: count Claude agents per state across all tmux sessions.

tmux list-panes -a -F '#{@claude_state}' 2>/dev/null | awk '
	{ n[$1]++ }
	END {
		if (n["waiting"]) printf "#[fg=#ea6962,bold]◆ %d #[default]", n["waiting"]
		if (n["working"]) printf "#[fg=#d8a657]● %d #[default]", n["working"]
		if (n["done"])    printf "#[fg=#a9b665]✓ %d #[default]", n["done"]
	}'
