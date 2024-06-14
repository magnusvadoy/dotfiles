return {
	{
		"goolord/alpha-nvim",
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

			dashboard.section.header.val = vim.split(logo, "\n")
			dashboard.section.buttons.val = {
				dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert<CR>"),
				dashboard.button("SPC f f", " " .. " Find file"),
				dashboard.button("SPC f r", " " .. " Recent files"),
				dashboard.button("SPC f g", " " .. " Find text"),
				dashboard.button("SPC s l", " " .. " Open last session"),
				dashboard.button("q", " " .. " Quit", ":qa<CR>"),
			}

			return dashboard
		end,
		config = function(_, dashboard)
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)
		end,
	},
}
