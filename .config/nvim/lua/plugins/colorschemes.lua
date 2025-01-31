local function setup()
  vim.g.gruvbox_material_background = "soft"
  vim.g.gruvbox_material_foreground = "material"

  -- Customize highlights
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
    pattern = "gruvbox-material",
    callback = function()
      local config = vim.fn["gruvbox_material#get_configuration"]()
      local palette =
        vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
      local set_hl = vim.fn["gruvbox_material#highlight"]

      set_hl("CursorLineNr", palette.orange, palette.none)
    end,
  })

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
  -- {
  --   "f4z3r/gruvbox-material.nvim",
  --   config = function()
  --     local contrast = "soft"
  --     local colors = require("gruvbox-material.colors").get(vim.o.background, contrast)
  --
  --     require("gruvbox-material").setup({
  --       contrast = contrast,
  --       customize = function(g, o)
  --         if g == "CursorLineNr" then
  --           o.link = nil -- wipe a potential link, which would take precedence over other
  --           -- attributes
  --           o.fg = colors.orange -- or use any color in "#rrggbb" hex format
  --           o.bold = true
  --         end
  --         return o
  --       end,
  --     })
  --   end,
  -- },
}
