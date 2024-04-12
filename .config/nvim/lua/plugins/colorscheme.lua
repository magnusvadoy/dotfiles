return {
	{
		"f-person/auto-dark-mode.nvim",
		dependencies = {
			{
				"catppuccin/nvim",
				name = "catppuccin",
				priority = 1000,
				opts = {
					flavour = "mocha", -- latte, frappe, macchiato, mocha
					background = { -- :h background
						light = "latte",
						dark = "mocha",
					},
					transparent_background = false, -- disables setting the background color.
					show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
					term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
					dim_inactive = {
						enabled = false, -- dims the background color of inactive window
						shade = "dark",
						percentage = 0.15, -- percentage of the shade to apply to the inactive window
					},
					no_italic = true, -- Force no italic
					no_bold = false, -- Force no bold
					no_underline = false, -- Force no underline
					color_overrides = {},
					custom_highlights = {},
					integrations = {
						cmp = true,
						gitsigns = true,
						nvimtree = true,
						treesitter = true,
						notify = false,
						dap = true,
						dap_ui = true,
						mini = {
							enabled = true,
							indentscope_color = "",
						},
					},
				},
			},
		},
		opts = {
			update_interval = 1000,
			set_dark_mode = function()
				vim.cmd("colorscheme catppuccin")
				vim.api.nvim_set_option("background", "dark")
			end,
			set_light_mode = function()
				vim.cmd("colorscheme catppuccin")
				vim.api.nvim_set_option("background", "light")
			end,
		},
	},
}
