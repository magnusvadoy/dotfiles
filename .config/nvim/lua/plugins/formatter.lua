local slow_format_filetypes = {}
local use_lsp_fallback = true

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        go = { "goimports" },
        lua = { "stylua" },
        proto = { "buf" },
        yaml = { "yamlfmt" },
        sh = { "shfmt" },
        markdown = { "markdownlint-cli2" },
        python = { "ruff_format" },
        json = { "prettierd" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
      },
      log_level = vim.log.levels.ERROR,
      formatters = {
        goimports = {
          command = "goimports-reviser",
          args = {
            "--company-prefixes=bitbucket.org/tv2norge,golang.tv2.no",
            "-imports-order=std,project,company,general",
            "-format",
            "$FILENAME",
          },
          stdin = false,
        },
      },
      format_on_save = function(bufnr)
        -- Disable with a global variable
        if vim.g.disable_autoformat then
          return
        end

        -- Automatically run slow formatters async
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end

        return { timeout_ms = 200, lsp_fallback = use_lsp_fallback }, function(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end
      end,
      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_fallback = use_lsp_fallback }
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
        local status = vim.g.disable_autoformat and "Disabled" or "Enabled"
        vim.notify(status .. " autoformatting", vim.log.levels.INFO)
      end, { desc = "Toggling autoformat" })

      vim.keymap.set("n", "<leader>F", "<cmd>ToggleAutoformat<cr>", { desc = "Toggle autoformatting" })
    end,
  },
}
