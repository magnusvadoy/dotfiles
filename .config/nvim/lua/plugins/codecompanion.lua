return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>a", mode = { "n", "v" }, desc = "ai" },
    { "<leader>ap", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion: Prompt" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion: Toggle" },
    { "ga", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "CodeCompanion: Add context" },
  },
}
