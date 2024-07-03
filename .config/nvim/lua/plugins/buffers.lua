return {
  {
    "moll/vim-bbye",
    cmd = "Bdelete",
    keys = {
      { "<leader>bq", "<Cmd>Bdelete<CR>", desc = "Close current buffer" },
      { "<leader>bQ", "<Cmd>bufdo Bdelete<CR>", desc = "Close all buffers" },
    },
  },
}
