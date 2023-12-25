---@diagnostic disable: unused-local
return {
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "[b",         "<Cmd>BufferLineCyclePrev<CR>",   desc = "Prev buffer" },
      { "]b",         "<Cmd>BufferLineCycleNext<CR>",   desc = "Next buffer" },
      { "<leader>bp", "<Cmd>BufferLinePick<CR>",        desc = "Pick buffer" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>",   desc = "Close buffer" },
      { "<leader>bD", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
      { "<leader>bL", "<Cmd>BufferLineCloseLeft<CR>",   desc = "Close buffers to the left" },
      { "<leader>bR", "<Cmd>BufferLineCloseRight<CR>",  desc = "Close buffers to the right" },
    },
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        options = {
          separator_style = "slant",
          style_preset = bufferline.style_preset.no_italic,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            ---@diagnostic disable-next-line: undefined-field
            local icon = level:match("error") and " " or " "
            return icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              text_align = "center",
              seperator = true,
            },
          },
        },
      })
    end,
  },
}
