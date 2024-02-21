return {
  {
    "echasnovski/mini.pairs",
    version = false,
    opts = {},
    event = "VeryLazy",
  },
  {
    "echasnovski/mini.comment",
    version = false,
    opts = {},
    event = "BufReadPost",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
