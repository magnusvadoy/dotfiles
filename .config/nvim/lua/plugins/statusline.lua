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

local function get_schema()
	local schema = require("yaml-companion").get_buf_schema(0)
	if schema.result[1].name == "none" then
		return ""
	end
	return "󰈙 " .. schema.result[1].name
end

return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPost",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("lualine").setup({
				options = {
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { branch_stat, diff_stat, diagnostics_stat },
					lualine_c = {
						{ "filename", path = 1 },
						{ "searchcount", icon = "󰍉" },
					},
					lualine_x = {},
					lualine_y = { get_schema, "filetype" },
					lualine_z = { "progress", "location" },
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
