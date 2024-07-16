return {
  {
    "moll/vim-bbye",
    cmd = "Bdelete",
    keys = {
      { "<leader>bd", "<Cmd>Bdelete<CR>", desc = "Delete buffer" },
      {
        "<leader>bD",
        function()
          vim.cmd("bufdo Bdelete")
          vim.cmd("Alpha")
        end,
        desc = "Delete all buffers",
      },
    },
  },
}
