local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "catppuccin-mocha"
	else
		return "catppuccin-latte"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 15
config.default_cursor_style = "BlinkingBlock"
config.window_padding = {
	left = "0cell",
	right = "0cell",
	top = "0cell",
	bottom = "0cell",
}
config.hide_tab_bar_if_only_one_tab = true

return config
