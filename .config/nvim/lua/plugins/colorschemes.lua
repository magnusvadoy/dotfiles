local function setup()
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_foreground = "material"
  vim.g.gruvbox_material_float_style = "dim"

  vim.g.gruvbox_material_diagnostic_text_highlight = 0
  vim.g.gruvbox_material_diagnostic_line_highlight = 0
  vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
  vim.g.gruvbox_material_current_word = "high contrast background"

  -- Customize highlights
  -- vim.api.nvim_create_autocmd("ColorScheme", {
  --   group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
  --   pattern = "gruvbox-material",
  --   callback = function()
  --     local config = vim.fn["gruvbox_material#get_configuration"]()
  --     local palette =
  --       vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
  --     local set_hl = vim.fn["gruvbox_material#highlight"]
  --
  --     set_hl("CursorLineNr", palette.orange, palette.none, "bold")
  --   end,
  -- })

  vim.cmd("colorscheme gruvbox-material")
end

function Highlights() end

return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
      { "sainnhe/gruvbox-material", enabled = true, lazy = false, priority = 1000 },
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        setup()
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        setup()
      end,
    },
  },
}
