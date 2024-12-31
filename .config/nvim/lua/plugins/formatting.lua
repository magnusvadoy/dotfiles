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
        if vim.bo[bufnr].filetype == "yaml" then
          vim.g.disable_format_on_save = true
        end

        -- Disable with a global variable
        if vim.g.disable_format_on_save then
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

      -- 2 spaces instead of tab
      conform.formatters.shfmt = {
        prepend_args = { "-i", "2" },
      }

      conform.formatters.stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      }

      vim.g.disable_format_on_save = false

      vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
        vim.g.disable_format_on_save = vim.g.disable_format_on_save == false and true or false
        local status = vim.g.disable_format_on_save and "Disabled" or "Enabled"
        vim.notify(status .. " format on save", vim.log.levels.INFO)
      end, { desc = "Toggle format on save" })

      vim.keymap.set("n", "<leader>F", "<cmd>ToggleFormatOnSave<cr>", { desc = "Toggle format on save" })
    end,
  },
}
