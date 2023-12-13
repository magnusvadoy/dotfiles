local w = require("wezterm")
local act = w.action
local c = {}

if w.config_builder then
  c = w.config_builder()
end

local function get_appearance()
  if w.gui then
    return w.gui.get_appearance()
  end
  return "Dark"
end

local function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "tokyonight"
  else
    return "tokyonight-day"
  end
end

-- var set by smart-splits
local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  Left = "h",
  Down = "j",
  Up = "k",
  Right = "l",
  -- reverse lookup
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = w.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function get_current_working_dir(tab)
  return string.gsub(tab.active_pane.current_working_dir, "(.*[/\\])(.*)", "%2")
end

-- set tab title to current working directory
w.on("format-tab-title", function(tab)
  local title = string.format(" %s %s ", "❯", get_current_working_dir(tab))
  return {
    { Text = title },
  }
end)

local color_scheme = scheme_for_appearance(get_appearance())
local colors = w.get_builtin_color_schemes()[color_scheme]

c.color_scheme = color_scheme
c.font = w.font_with_fallback({
  {
    family = "JetBrainsMono Nerd Font",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    weight = "Regular",
  },
  "Apple Color Emoji",
})
c.font_size = 15
c.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
c.window_background_opacity = 1.0
c.use_fancy_tab_bar = false
c.hide_tab_bar_if_only_one_tab = true
c.tab_bar_at_bottom = false
c.tab_max_width = 32
c.colors = {
  tab_bar = {
    background = colors.background,
  },
}

c.keys = {
  {
    key = "-",
    mods = "ALT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "=",
    mods = "ALT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "SHIFT|ALT",
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- move between split panes
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),

  -- resize panes
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
}

return c
