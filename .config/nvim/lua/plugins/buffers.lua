return {
  {
    "moll/vim-bbye",
    cmd = "Bdelete",
    keys = {
      { "<leader>bc", "<Cmd>Bdelete<CR>", desc = "Close current buffer" },
      {
        "<leader>bq",
        function()
          vim.cmd("bufdo Bdelete")
          vim.cmd("Alpha")
        end,
        desc = "Close all buffers",
      },
    },
  },
}
