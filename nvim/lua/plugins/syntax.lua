return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring", -- useful for embedded languages
      "windwp/nvim-ts-autotag",                   -- autoclose and autorename html tags
    },
    opts = {
      auto_install = false,
      sync_install = false,
      ignore_install = {},
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "python",
        "lua",
        "typescript",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "tsx",
        "svelte",
        "html",
        "css",
        "scss",
        "bash",
        "yaml",
        "toml",
        "markdown",
        "regex",
        "diff",
        "jsonnet",
        "proto",
        "scala",
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>", -- normal mode
          node_incremental = "<Tab>", -- visual mode
          scope_incremental = "<CR>", -- visual mode
          node_decremental = "<BS>", -- visual mode
        },
      },
      -- nvim-ts-context-commentstring
      context_commentstring = { enable = true },
      -- nvim-ts-autotag
      autotag = { enable = true },
      -- :help nvim-treesitter-textobjects-modules
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["ac"] = { query = "@class.outer", desc = "TS: all class" },
            ["ic"] = { query = "@class.inner", desc = "TS: inner class" },
            ["af"] = { query = "@function.outer", desc = "TS: all function" },
            ["if"] = { query = "@function.inner", desc = "TS: inner function" },
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "TS: Next class start" },
            ["]f"] = { query = "@function.outer", desc = "TS: Next function start" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "TS: Prev class start" },
            ["[f"] = { query = "@function.outer", desc = "TS: Prev function start" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}