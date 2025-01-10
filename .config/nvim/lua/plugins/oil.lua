return {
  "stevearc/oil.nvim",
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  opts = {
    default_file_explorer = false,
    delete_to_trash = true,
  },
  keys = {
    { "<leader>-", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
  config = function(_, opts)
    require("oil").setup(opts)
  end,
}
