return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    {
      "<leader>fm",
      function()
        require("oil").toggle_float()
      end,
      desc = "Open Oil (Current Directory)",
    },
    {
      "<leader>fM",
      function()
        require("oil").toggle_float(vim.uv.cwd())
      end,
      desc = "Open Oil (cwd)",
    },
  },
}
