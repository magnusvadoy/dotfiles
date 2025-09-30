return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim",
    "j-hui/fidget.nvim",
  },
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4",
        },
      },
      inline = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4",
        },
      },
      cmd = {
        adapter = {
          name = "copilot",
          model = "claude-sonnet-4",
        },
      },
    },
    memory = {
      opts = {
        chat = {
          enabled = true,
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
  keys = {
    { "<leader>a", mode = { "n", "v" }, desc = "ai" },
    { "<leader>ap", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion: Prompt" },
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion: Toggle" },
    { "<leader>ac", "<cmd>CodeCompanionChat Add<CR>", mode = { "v" }, desc = "CodeCompanion: Add context" },
  },
  init = function()
    require("plugins.codecompanion.fidget-spinner"):init()
  end,
}
