local branch_stat = {
	"branch",
	icon = "󰘬",
	on_click = function()
		require("telescope.builtin").git_branches()
	end,
}

local diagnostics_stat = {
	"diagnostics",
	on_click = function()
		require("telescope.builtin").diagnostics()
	end,
}

local diff_stat = {
	"diff",
	on_click = function()
		require("gitsigns").diffthis()
	end,
}

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPost",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "chrisgrieser/nvim-dr-lsp" },
		},
		config = function()
			local drLsp = require("dr-lsp")

			require("lualine").setup({
				options = {
					theme = "catppuccin",
					globalstatus = true,
				},
				sections = {
					lualine_a = { { "mode", icons_enabled = true } },
					lualine_b = { branch_stat, diff_stat, diagnostics_stat },
					lualine_c = { { "filename", path = 1 }, { "searchcount", icon = "󰍉" } },
					lualine_x = {},
					lualine_y = { drLsp.lspCount, drLsp.lspProgress, "filetype" },
					lualine_z = { "location", "progress" },
				},
				-- not in use since globalstatus is enabled
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
