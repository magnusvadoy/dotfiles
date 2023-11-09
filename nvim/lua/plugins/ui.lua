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
      { "<leader>b[", "<Cmd>BufferLineMovePrev<CR>",    desc = "Move prev" },
      { "<leader>b]", "<Cmd>BufferLineMoveNext<CR>",    desc = "Move next" },
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
    "nvim-lualine/lualine.nvim",
    event = "BufReadPost",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "filename", "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "fugitive",
        "nvim-tree",
        "nvim-dap-ui",
      },
    },
  },
  { "stevearc/dressing.nvim", opts = {} },
}
