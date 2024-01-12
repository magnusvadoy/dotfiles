return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "center", -- align columns left, center or right
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				["<leader>f"] = { name = "find", _ = "which_key_ignore" },
				["<leader>b"] = { name = "buffer", _ = "which_key_ignore" },
				["<leader>c"] = { name = "code", _ = "which_key_ignore" },
				["<leader>g"] = { name = "git", _ = "which_key_ignore" },
				["<leader>d"] = { name = "debug", _ = "which_key_ignore" },
			})
		end,
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = {
			input = {
				border = "solid",
			},
		},
	},
}
