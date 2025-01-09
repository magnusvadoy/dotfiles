return {
  "Wansmer/treesj",
  keys = { { "<leader>cj", "<cmd>TSJToggle<cr>", desc = "Join code" } },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = { use_default_keymaps = false, max_join_length = 150 },
}
