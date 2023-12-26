-- Debug adapter protocol

-- Wrapper function to set keymaps with default opts
local map = function(mode, lhs, rhs, desc)
  local opts = { noremap = true, silent = true, desc = desc }
  vim.keymap.set(mode, lhs, rhs, opts)
end

return {
  "mfussenegger/nvim-dap", -- debug adapter protocol
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {
      "rcarriga/nvim-dap-ui", -- UI for nvim-dap
      opts = {},
    },
    {
      "jay-babu/mason-nvim-dap.nvim", -- bridges mason.nvim and nvim-dap
      opts = {
        ensure_installed = { "delve" },
        automatic_installation = true,
      },
    },
    {
      "LiadOz/nvim-dap-repl-highlights", -- syntax highlights to nvim-dap REPL
      dependencies = "nvim-treesitter/nvim-treesitter",
      build = ":TSInstall dap_repl",
      opts = {},
    },
    { "leoluz/nvim-dap-go" }, -- Go support
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -------------------------------------------------------------------------------------------
    -- Configurations for each languages
    -------------------------------------------------------------------------------------------
    -- NOTE: For per-project config, create .vscode/launch.json that looks something like this:
    -- {
    --   // Use IntelliSense to learn about possible attributes.
    --   // Hover to view descriptions of existing attributes.
    --   // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    --   "version": "0.2.0",
    --   "configurations": [
    --     {
    --       "name": "NAME OF THE LAUNCH",
    --       "type": "python",
    --       "request": "launch",
    --       "program": "${file}",
    --       "console": "integratedTerminal",
    --       "args": ["TOKEN1", "TOKEN2", ...]
    --     }
    --   ]
    -- }

    require("dap-go").setup()

    -------------------------------------------------------------------------------------------
    -- Automatically open when a debug session is created
    -------------------------------------------------------------------------------------------
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -------------------------------------------------------------------------------------------
    -- Set up signs and colors
    -------------------------------------------------------------------------------------------
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "🔶", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = "📜", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "👀", texthl = "", linehl = "debugPC", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })

    -------------------------------------------------------------------------------------------
    -- Set up keymaps
    -------------------------------------------------------------------------------------------
    map("n", "<leader>du", function()
      dapui.toggle()
    end, "Toggle UI")
    map("n", "<leader>dk", function()
      require("dap.ui.widgets").hover()
    end, "Check variable value on hover")
    map("n", "<leader>dc", function()
      if vim.fn.filereadable(".vscode/launch.json") then
        require("dap.ext.vscode").load_launchjs()
      end
      dap.continue()
    end, "Start/Continue debugging")
    map("n", "<leader>dl", function()
      dap.run_last()
    end, "Run the last debug adapter entry")
    map("n", "<leader>db", function()
      dap.toggle_breakpoint()
    end, "Toggle breakpoint")
    map("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, "Toggle breakpoint with condition")
    map("n", "<leader>do", function()
      dap.step_over()
    end, "Step over")
    map("n", "<leader>dO", function()
      dap.step_out()
    end, "Step out")
    map("n", "<leader>di", function()
      dap.step_into()
    end, "Step into")
    map("n", "<leader>dt", function()
      dap.terminate()
    end, "Terminate debugging")
  end,
}
