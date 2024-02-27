local wezterm = require("wezterm")
local config = {}

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
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

wezterm.on("update-right-status", function(window)
  if not window:get_dimensions().is_full_screen then
    window:set_right_status("")
    return
  end

  window:set_right_status(wezterm.format({
    { Text = wezterm.strftime("%d-%m-%Y %H:%M:%S") },
  }))
end)

config.color_scheme = scheme_for_appearance(get_appearance())
config.font = wezterm.font("JetBrainsMono Nerd Font", {
  weight = 500,
})
config.font_size = 16
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_background_opacity = 1.0
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.tab_max_width = 32

return config
