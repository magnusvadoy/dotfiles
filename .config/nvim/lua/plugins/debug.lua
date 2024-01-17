-- Debug adapter protocol

-- Wrapper function to set keymaps with default opts
local map = function(mode, lhs, rhs, desc)
	local opts = { noremap = true, silent = true, desc = desc }
	vim.keymap.set(mode, lhs, rhs, opts)
end

return {
	"mfussenegger/nvim-dap", -- debug adapter protocol
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter" },
		{ "rcarriga/nvim-dap-ui" },
		{ "theHamsta/nvim-dap-virtual-text" },
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
		{ "ofirgall/goto-breakpoints.nvim" },
		{ "leoluz/nvim-dap-go" }, -- Go support
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local breakpoint = require("goto-breakpoints")
		require("nvim-dap-virtual-text").setup({})

		-------------------------------------------------------------------------------------------
		-- DAP UI
		-------------------------------------------------------------------------------------------
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		-- dap.listeners.before.event_terminated["dapui_config"] = function()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited["dapui_config"] = function()
		-- 	dapui.close()
		-- end

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

		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "RunOrTest",
				metals = {
					runType = "runOrTestFile",
					--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
				},
			},
			{
				type = "scala",
				request = "launch",
				name = "Test Target",
				metals = {
					runType = "testTarget",
				},
			},
		}

		require("dap-go").setup()

		-------------------------------------------------------------------------------------------
		-- Set up signs and colors
		-------------------------------------------------------------------------------------------
		local sign = vim.fn.sign_define

		sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
		sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		-------------------------------------------------------------------------------------------
		-- Set up keymaps
		-------------------------------------------------------------------------------------------
		map("n", "<leader>du", function()
			dapui.toggle()
		end, "Toggle UI")
		map("n", "<leader>dc", function()
			if vim.fn.filereadable(".vscode/launch.json") then
			  require("dap.ext.vscode").load_launchjs()
			end
			dap.continue()
		end, "Start/Continue debugging")
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
		map("n", "<leader>dr", function()
			dap.repl.open()
		end, "Open REPL")
		map("n", "<leader>dl", function()
			dap.run_last()
		end, "Run last session")
		map("n", "<leader>dR", function()
			dap.restart()
		end, "Restart session")
		map("n", "<leader>dq", function()
			dap.terminate()
		end, "Terminate session")

		-- Go to breakpoints
		map("n", "]b", breakpoint.next, "Go to next breakpoint")
		map("n", "[b", breakpoint.prev, "Go to previous breakpoint")
	end,
}
