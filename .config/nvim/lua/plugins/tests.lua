return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-go",
		},
		config = function()
			-- get neotest namespace (api call creates or returns namespace)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			local neotest = require("neotest")

			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)

			---@diagnostic disable-next-line: missing-fields
			neotest.setup({
				-- your neotest config here
				adapters = {
					require("neotest-go"),
				},
			})

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { desc = "Test: " .. desc })
			end

			map(
				"n",
				"<leader>to",
				"<cmd>lua require('neotest').output.open({ enter = true, short = false })<cr>",
				"Output"
			)
			map("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", "Toggle summary")
			map(
				"n",
				"<leader>tn",
				"<cmd>lua require('neotest').jump.next({status=\"failed\"})<cr>",
				"Jump to next failed test"
			)
			map(
				"n",
				"<leader>tp",
				"<cmd>lua require('neotest').jump.prev({status=\"failed\"})<cr>",
				"Jump to previous failed test"
			)
			map("n", "<leader>tr", "<cmd>lua require('neotest').run.run(vim.fn.expand(\"%\"))<cr>", "Run file")
			map("n", "<leader>tR", "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>", "Run project")
			map(
				"n",
				"<leader>td",
				"<cmd>lua require('neotest').run.run({strategy = \"dap\"})<cr>",
				"Debug current file"
			)
			map("n", "<leader>tw", "<cmd>lua require('neotest').watch.watch()<cr>", "Watch current test")
		end,
	},
}
