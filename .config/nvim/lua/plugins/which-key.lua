return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = {
        rules = false,
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        {
          { "<leader>b", group = "buffers" },
          { "<leader>f", group = "find" },
          { "<leader>g", group = "git", mode = { "n", "v" } },
          { "<leader>s", group = "session" },
          { "<leader>t", group = "test" },
          {
            "<leader>b",
            group = "buffers",
            expand = function()
              return require("which-key.extras").expand.buf()
            end,
          },
        },
      })
    end,
  },
}
