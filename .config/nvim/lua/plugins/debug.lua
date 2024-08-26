return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
      -- stylua: ignore
      keys = {
        { "<leader>d", "", desc = "debug", mode = {"n", "v"} },
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Toggle Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate", mode = {"n", "v"} },
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    { "theHamsta/nvim-dap-virtual-text", opts = {} },
    { "ofirgall/goto-breakpoints.nvim" },
    { "leoluz/nvim-dap-go" },
  },
  config = function()
    require("dap-go").setup()

    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    local sign = vim.fn.sign_define
    sign(
      "DapStopped",
      { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
    )
    sign("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo" })
    sign("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo" })
    sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })
    sign("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
  end,
    -- stylua: ignore
  keys = {
    { "]b", function() require("goto-breakpoints").next() end, desc = "Next breakpoint" },
    { "[b", function() require("goto-breakpoints").prev() end, desc = "Previous breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function()
      if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs()
      end
      require("dap").continue()
    end, desc = "Continue/Start" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
  },
}
