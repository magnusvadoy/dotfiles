return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
      { "sainnhe/gruvbox-material", event = "VeryLazy" },
      {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        opts = {
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          background = { -- :h background
            light = "latte",
            dark = "mocha",
          },
          transparent_background = false, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
          },
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          color_overrides = {},
          custom_highlights = {},
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            dap = true,
            dap_ui = true,
            mason = true,
            markdown = true,
            neogit = true,
            neotest = true,
            telescope = {
              enabled = true,
            },
            native_lsp = {
              enabled = true,
              virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
              },
              underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
              },
              inlay_hints = {
                background = true,
              },
            },
          },
        },
      },
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme gruvbox-material")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme gruvbox-material")
      end,
    },
  },
}
