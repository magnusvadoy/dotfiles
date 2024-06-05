return {
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "go", "gomod" },
		opts = {
			commands = {
				go = "go",
				gomodifytags = "gomodifytags",
				gotests = "gotests",
				impl = "impl",
				iferr = "iferr",
			},
		},
		config = function(_, opts)
			require("gopher").setup(opts)
			require("gopher.dap").setup()
		end,
	},
}
