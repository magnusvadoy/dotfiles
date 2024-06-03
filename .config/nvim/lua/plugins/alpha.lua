return {
	{
		"goolord/alpha-nvim",
		config = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.buttons.val = {
				dashboard.button("e", "  New File", "<cmd>ene <CR>"),
				dashboard.button("SPC f f", "󰈞  Find File"),
				dashboard.button("SPC f r", "  Recent File"),
				dashboard.button("SPC f g", "󰈬  Find Word"),
				dashboard.button("SPC s l", "  Open Last Session"),
			}

			require("alpha").setup(dashboard.config)
		end,
	},
}
