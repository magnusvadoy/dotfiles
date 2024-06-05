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
				["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
				["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
				["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
				["<leader>d"] = { name = "Debug", _ = "which_key_ignore" },
				["<leader>t"] = { name = "Test", _ = "which_key_ignore" },
				["<leader>s"] = { name = "Session", _ = "which_key_ignore" },
			})
		end,
	},
}
