return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context",    opts = { max_lines = 3, min_window_height = 30 } },
      { "windwp/nvim-ts-autotag" },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("ts_context_commentstring").setup({})
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
    },
    opts = {
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "python",
        "lua",
        "luadoc",
        "luap",
        "typescript",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "tsx",
        "svelte",
        "html",
        "css",
        "bash",
        "yaml",
        "xml",
        "toml",
        "markdown",
        "markdown_inline",
        "regex",
        "diff",
        "jsonnet",
        "proto",
        "scala",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },

      -- nvim-ts-autotag
      autotag = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["ac"] = { query = "@class.outer", desc = "Around class" },
            ["ic"] = { query = "@class.inner", desc = "Inner class" },
            ["af"] = { query = "@function.outer", desc = "Around function" },
            ["if"] = { query = "@function.inner", desc = "Inner function" },
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "Next class" },
            ["]f"] = { query = "@function.outer", desc = "Next function" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "Prev class" },
            ["[f"] = { query = "@function.outer", desc = "Prev function" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cp"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
          },
          swap_previous = {
            ["<leader>cP"] = { query = "@parameter.inner", desc = "Swap with prev parameter" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
