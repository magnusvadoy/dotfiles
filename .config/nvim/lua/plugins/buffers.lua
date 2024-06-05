return {
	{
		"moll/vim-bbye",
		cmd = "Bdelete",
		keys = {
			{ "<leader>q", "<Cmd>Bdelete<CR>", desc = "Close buffer" },
			{ "<leader>Q", "<Cmd>bufdo Bdelete<CR>", desc = "Close all buffers" },
		},
	},
}
