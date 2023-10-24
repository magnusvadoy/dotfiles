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

local color_scheme = scheme_for_appearance(get_appearance())
local colors = wezterm.get_builtin_color_schemes()[color_scheme]

config.color_scheme = color_scheme
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 15
config.default_cursor_style = "BlinkingBlock"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 2,
}
config.window_background_opacity = 1.0
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.colors = {
  tab_bar = {
    background = colors.background,
  },
}

return config
