return {
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    ft = { "yaml" },
    config = function()
      require("telescope").load_extension("yaml_schema")
      vim.keymap.set("n", "<leader>fs", "<cmd>Telescope yaml_schema<cr>", { desc = "Schema" })
    end,
  },
}
