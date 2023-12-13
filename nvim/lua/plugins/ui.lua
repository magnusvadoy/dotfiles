return {
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "[b",         "<Cmd>BufferLineCyclePrev<CR>",   desc = "Prev buffer" },
      { "]b",         "<Cmd>BufferLineCycleNext<CR>",   desc = "Next buffer" },
      { "<leader>bp", "<Cmd>BufferLinePick<CR>",        desc = "Buffer pick" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>",   desc = "Pick close" },
      { "<leader>bD", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close others" },
      { "<leader>bL", "<Cmd>BufferLineCloseLeft<CR>",   desc = "Close to the left" },
      { "<leader>bR", "<Cmd>BufferLineCloseRight<CR>",  desc = "Close to the right" },
    },
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            text_align = "center",
            seperator = true,
          },
        },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        border = "solid",
      },
    },
  },
}
