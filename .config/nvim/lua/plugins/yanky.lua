return {
  "gbprod/yanky.nvim",
  recommended = true,
  desc = "Better Yank/Paste",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    highlight = { timer = 150 },
  },
  keys = {
    {
      "<leader>p",
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      mode = { "n", "x" },
      desc = "Open yank history",
    },
    -- stylua: ignore
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
    { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
    { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
    { "<c-p>", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
    { "<c-n>", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
  },
}
