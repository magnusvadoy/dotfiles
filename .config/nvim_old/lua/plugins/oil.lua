return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
  },
  keys = {
    { "<leader>-", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
  config = function(_, opts)
    require("oil").setup(opts)
  end,
}
