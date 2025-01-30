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
        markdown = {}, -- TODO: Fix linting rules for markdown
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        preview = {
          layout = "vertical",
          vertical = "down:50%",
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>,", false },
    },
  },
  {
    "snacks.nvim",
    keys = {
      { "<leader>.", false },
      { "<leader>S", false },
      { "<leader>n", false },
      {
        "<leader>N",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
    },
  },
}
