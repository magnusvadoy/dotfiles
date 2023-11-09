return {
  {
    "f-person/auto-dark-mode.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    lazy = false,
    priority = 1000,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd("colorscheme tokyonight-night")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd("colorscheme tokyonight-day")
      end,
    },
  },
}
