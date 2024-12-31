return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      -- notification = {
      --   wo = { wrap = true }, -- Wrap notifications
      -- },
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification history" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename file" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev reference", mode = { "n", "t" } },
  },
}
