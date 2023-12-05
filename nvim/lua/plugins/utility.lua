return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
    config = function()
      require("which-key").register({
        ["<leader>f"] = { name = "find", _ = "which_key_ignore" },
        ["<leader>b"] = { name = "buffer", _ = "which_key_ignore" },
        ["<leader>c"] = { name = "code", _ = "which_key_ignore" },
        ["<leader>s"] = { name = "select", _ = "which_key_ignore" },
        ["<leader>g"] = { name = "git", _ = "which_key_ignore" },
        ["<leader>d"] = { name = "debug", _ = "which_key_ignore" },
        ["gz"] = { name = "surrounding", _ = "which_key_ignore" },
      })
    end,
  },
}
