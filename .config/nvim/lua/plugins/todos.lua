return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("todo-comments").setup({})
      vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>", { desc = "Todos" })
    end,
  },
}
