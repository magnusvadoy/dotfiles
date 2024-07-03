return {
  {
    "moll/vim-bbye",
    cmd = "Bdelete",
    keys = {
      { "<leader>q", "<Cmd>Bdelete<CR>", desc = "Close current buffer" },
      { "<leader>Q", "<Cmd>bufdo Bdelete<CR>", desc = "Close all buffers" },
    },
  },
}
