local events = { "BufReadPost", "BufNewFile", "BufWritePre" }

return {
  {
    "mfussenegger/nvim-lint",
    event = events,
    opts = {
      events = events,
      linters_by_ft = {
        go = { "golangcilint" },
        fish = { "fish" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
      vim.api.nvim_create_autocmd(opts.events, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.api.nvim_create_user_command("ToggleLinting", function()
        vim.notify("Toggling linting", vim.log.levels.INFO)
        local ft = vim.filetype.match({ buf = 0 })
        if not ft then
          return
        end
        lint.linters_by_ft[ft] = {}
        vim.diagnostic.hide()
      end, { desc = "Disable linting for current filetype" })

      vim.keymap.set("n", "<leader>TL", "<cmd>ToggleLinting<cr>", { desc = "Toggle linting" })
    end,
  },
}
