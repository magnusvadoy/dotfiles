-- NOTE: Overrides default LazyVim plugin configuration
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false, -- disable inlay_hints as they are annoying
      },
      codelens = {
        enabled = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    dependencies = {
      "sainnhe/gruvbox-material",
    },
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    "akinsho/bufferline.nvim", -- disable bufferline
    enabled = false,
  },
  {
    "folke/trouble.nvim",
    opts = {
      focus = true, -- automatically focus the trouble window
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {}, -- TODO: Fix linting rules for markdown
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = { current_line_blame = true },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layout = {
          preset = "vertical",
        },
        formatters = {
          file = {
            truncate = 100,
          },
        },
      },
    },
    keys = {
      -- disable some default bindings
      { "<leader>.", false },
      { "<leader>S", false },
      { "<leader>,", false },
      {
        "<leader><space>",
        function()
          Snacks.picker.buffers({ current = false })
        end,
        desc = "Buffers",
      },
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "mikavilpas/blink-ripgrep.nvim",
      "copilotlsp-nvim/copilot-lsp",
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if vim.b[vim.api.nvim_get_current_buf()].nes_state then
              cmp.hide()
              return (
                require("copilot-lsp.nes").apply_pending_nes()
                and require("copilot-lsp.nes").walk_cursor_end_edit()
              )
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              prefix_min_len = 5,
              context_size = 5,
            },
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                -- example: append a description to easily distinguish rg results
                item.labelDetails = {
                  description = "(rg)",
                }
              end
              return items
            end,
          },
        },
      },
    },
  },
}
