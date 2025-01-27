-- NOTE: Overrides default LazyVim plugin configuration
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = false, -- disable inlay_hints as they are annoying
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material", -- change default colorscheme
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
        markdown = {}, -- TODO: Fix linting rules
      },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = false, -- disable ghost_text as it is annoying
        },
      },
    },
  },
}
