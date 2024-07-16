return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    opts = {},
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=split<CR>", desc = "Open Neogit" },
    },
  },
}
