-- Hammerspoon config. Loaded from here via:
--   defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

-- Start at login, since the notifications below depend on it running.
hs.autoLaunch(true)

-- Lets shell scripts call into this config with the bundled `hs` CLI.
require("hs.ipc")

-- Claude Code agent notifications, sent by ~/.config/tmux/scripts/claude-state.sh.
-- Clicking a notification jumps to the agent's tmux pane and brings Ghostty forward.
claude = {}

-- Shown on the right side of each notification, taken from the Claude desktop app when
-- installed. macOS no longer lets apps replace their own icon (setIdImage) in notifications.
claude.icon = hs.image.imageFromAppBundle("com.anthropic.claudefordesktop")

function claude.notify(title, subtitle, message, tmux, socket, pane)
	local notification = hs.notify.new(function()
		hs.task
			.new(tmux, nil, {
				"-S", socket,
				"switch-client", "-t", pane, ";",
				"select-window", "-t", pane, ";",
				"select-pane", "-t", pane,
			})
			:start()
		hs.application.launchOrFocusByBundleID("com.mitchellh.ghostty")
	end, {
		title = title,
		subTitle = subtitle,
		informativeText = message,
		soundName = hs.notify.defaultNotificationSound,
		withdrawAfter = 0,
		contentImage = claude.icon,
	})
	notification:send()
end
