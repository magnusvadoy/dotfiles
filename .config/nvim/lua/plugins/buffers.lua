---@diagnostic disable: unused-local
return {
  {
    "akinsho/bufferline.nvim",
    event = "BufReadPre",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>bp", "<Cmd>BufferLinePick<CR>",        desc = "Pick buffer" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>",   desc = "Pick close buffer" },
      { "<leader>bd", "<Cmd>bdelete<CR>",               desc = "Close buffer" },
      { "<leader>bD", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
      { "<leader>bL", "<Cmd>BufferLineCloseLeft<CR>",   desc = "Close buffers to the left" },
      { "<leader>bR", "<Cmd>BufferLineCloseRight<CR>",  desc = "Close buffers to the right" },
    },
    config = function()
      local bufferline = require("bufferline")
      bufferline.setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          -- style_preset = bufferline.style_preset.no_italic,
          diagnostics = "nvim_lsp",
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            ---@diagnostic disable-next-line: undefined-field
            local icon = level:match("error") and " " or " "
            return icon .. count
          end,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              seperator = true,
            },
          },
        },
      })
    end,
  },
}
