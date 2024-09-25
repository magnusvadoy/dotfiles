return {
  {
    "yetone/avante.nvim",
    enabled = false,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20240620",
        temperature = 0,
        max_tokens = 4096,
      },
      mappings = {
        diff = {
          ours = "co",
          theirs = "ct",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      hints = { enabled = false },
      windows = {
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        diff = {
          incoming = "DiffAdd",
          current = "DiffChange",
        },
      },
      diff = {
        debug = false,
        autojump = true,
        list_opener = "copen",
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end, desc = "Ask (Avante)", mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "Refresh (Avante)" },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "Edit (Avante)", mode = "v" },
    },
  },
}
