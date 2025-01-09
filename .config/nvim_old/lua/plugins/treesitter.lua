return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",

        config = function()
          local get_option = vim.filetype.get_option
          vim.filetype.get_option = function(filetype, option)
            return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
              or get_option(filetype, option)
          end

          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        opts = {},
      },
    },
    opts = {
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
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
