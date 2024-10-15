return {
  "sindrets/diffview.nvim",
  config = function()
    require("diffview").setup({})
  end,
  cmd = { "DiffviewOpen" },
  keys = {
    { "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "View diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", mode = "n", desc = "File history" },
    { "<leader>gh", ":DiffviewFileHistory<CR>", mode = "x", desc = "Range file history" },
  },
}
