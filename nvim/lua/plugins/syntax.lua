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
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      -- nvim-ts-context-commentstring
      context_commentstring = { enable = true },
      -- nvim-ts-autotag
      autotag = { enable = true },
      -- :help nvim-treesitter-textobjects-modules
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
  },
}
