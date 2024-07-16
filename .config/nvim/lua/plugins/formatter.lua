return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        go = { "goimportsreviser" },
        lua = { "stylua" },
        proto = { "buf" },
        yaml = { "yamlfmt" },
        sh = { "shfmt" },
        python = { "isort", "ruff_format" },
        markdown = { "markdownlint" },
        json = { "prettierd" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
      },
      log_level = vim.log.levels.ERROR,
      formatters = {
        goimportsreviser = {
          command = "goimports-reviser",
          args = {
            "-project-name=bitbucket.org/tv2norge",
            "-imports-order=std,project,company,general",
            "-format",
            "$FILENAME",
          },
          stdin = false,
        },
      },
      format_on_save = function(bufnr)
        -- Disable with a global variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return { async = false, timeout_ms = 500, lsp_fallback = true }
      end,
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)

      conform.formatters.shfmt = {
        prepend_args = { "-i", "2" }, -- 2 spaces instead of tab
      }

      conform.formatters.stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" }, -- 2 spaces instead of tab
      }

      vim.g.disable_autoformat = false

      vim.api.nvim_create_user_command("ToggleAutoformat", function()
        vim.g.disable_autoformat = vim.g.disable_autoformat == false and true or false
      end, { desc = "Toggling autoformat" })

      vim.keymap.set("n", "<leader>F", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle format on save" })
    end,
  },
}
