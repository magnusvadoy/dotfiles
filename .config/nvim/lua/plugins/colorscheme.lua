return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
      {
        "folke/tokyonight.nvim",
        opts = {
          style = "night",   -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
          light_style = "day", -- The theme is used when the background is set to light
          transparent = false, -- Enable this to disable setting the background color
          terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
          styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = false },
            keywords = { italic = false },
            functions = {},
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark", -- style for floating windows
          },
          on_highlights = function(hl, c)
            local prompt = "#2d3149"
            hl.TelescopeNormal = {
              bg = c.bg_dark,
              fg = c.fg_dark,
            }
            hl.TelescopeBorder = {
              bg = c.bg_dark,
              fg = c.bg_dark,
            }
            hl.TelescopePromptNormal = {
              bg = prompt,
            }
            hl.TelescopePromptBorder = {
              bg = prompt,
              fg = prompt,
            }
            hl.TelescopePromptTitle = {
              bg = prompt,
              fg = prompt,
            }
            hl.TelescopePreviewTitle = {
              bg = c.bg_dark,
              fg = c.bg_dark,
            }
            hl.TelescopeResultsTitle = {
              bg = c.bg_dark,
              fg = c.bg_dark,
            }

            hl.BufferLineFill = {
              bg = c.bg_dark,
            }
            hl.BufferLineSeparator = {
              fg = c.bg_dark,
            }
            hl.BufferLineSeparatorSelected = {
              fg = c.bg_dark,
            }
          end,
        },
      },
      {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          background = { -- :h background
            light = "latte",
            dark = "mocha",
          },
          transparent_background = false, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = false,       -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
            enabled = false,         -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15,       -- percentage of the shade to apply to the inactive window
          },
          no_italic = true,          -- Force no italic
          no_bold = false,           -- Force no bold
          no_underline = false,      -- Force no underline
          styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = {},           -- Change the style of comments
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
          },
          color_overrides = {},
          custom_highlights = {},
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            treesitter_context = true,
            notify = false,
            dap = true,
            dap_ui = true,
            mini = {
              enabled = true,
              indentscope_color = "",
            },
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
          },
        },
      },
    },
    lazy = false,
    priority = 1000,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme catppuccin")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme catppuccin")
      end,
    },
  },
}
