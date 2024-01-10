return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = { { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle Explorer" } },
		opts = {
			view = { adaptive_size = true },
			update_focused_file = {
				enable = true,
			},
		},
	},
}
