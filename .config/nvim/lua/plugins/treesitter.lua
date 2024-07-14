return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
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
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ib"] = "@block.inner",
            ["ab"] = "@block.outer",
          },
        },
        move = {
          enable = true,
          goto_next_start = {
            ["]c"] = { query = "@class.outer", desc = "LSP: Next class" },
            ["]f"] = { query = "@function.outer", desc = "LSP: Next function" },
          },
          goto_previous_start = {
            ["[c"] = { query = "@class.outer", desc = "LSP: Prev class" },
            ["[f"] = { query = "@function.outer", desc = "LSP: Prev function" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cp"] = { query = "@parameter.inner", desc = "LSP: Swap with next parameter" },
          },
          swap_previous = {
            ["<leader>cP"] = { query = "@parameter.inner", desc = "LSP: Swap with prev parameter" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
