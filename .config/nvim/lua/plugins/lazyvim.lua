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
    },
    opts = {
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "ripgrep",
        },
        providers = {
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            score_offset = -5,
          },
        },
      },
    },
  },
}
