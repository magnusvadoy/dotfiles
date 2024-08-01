return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = {
      { "sainnhe/gruvbox-material", enabled = true, lazy = false, priority = 1000 },
      {
        "catppuccin/nvim",
        name = "catppuccin",
        enabled = false,
        lazy = false,
        priority = 1000,
      },
    },
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd("colorscheme gruvbox-material")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd("colorscheme gruvbox-material")
      end,
    },
  },
}
