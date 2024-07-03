return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-go",
    },
    keys = {
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, short = false })
        end,
        desc = "Toggle output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle output panel",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle summary",
      },
      {
        "]T",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Next failed test",
      },
      {
        "[T",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Previous failed test",
      },
      {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        desc = "Run test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run file",
      },
      {
        "<leader>tp",
        function()
          require("neotest").run.run(vim.fn.expand("%:p:h"))
        end,
        desc = "Run project",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.watch()
        end,
        desc = "Watch test",
      },
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      local neotest = require("neotest")

      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      ---@diagnostic disable-next-line: missing-fields
      neotest.setup({
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
}
