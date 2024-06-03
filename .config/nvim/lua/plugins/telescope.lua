-- Single <CR> to open one or multiple files
local select_one_or_multi = function(prompt_bufnr)
	local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
	local multi = picker:get_multi_selection()
	if not vim.tbl_isempty(multi) then
		require("telescope.actions").close(prompt_bufnr)
		for _, j in pairs(multi) do
			if j.path ~= nil then
				vim.cmd(string.format("%s %s", "edit", j.path))
			end
		end
	else
		require("telescope.actions").select_default(prompt_bufnr)
	end
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local utils = require("telescope.utils")
			local builtin = require("telescope.builtin")
			local themes = require("telescope.themes")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				defaults = themes.get_ivy({
					file_ignore_patterns = {
						"%.DS_Store",
						"%.git/",
						"dist/",
						"node_modules/",
					},
					mappings = {
						i = {
							["<CR>"] = select_one_or_multi,
						},
					},
				}),
				pickers = {
					oldfiles = {
						cwd_only = true,
					},
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
					},
					live_grep = {
						only_sort_text = true, -- grep for content and not file name/path
					},
					git_files = {
						show_untracked = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					live_grep_args = {
						mappings = {
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
							},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("live_grep_args")

			local map = function(mode, keys, func, desc)
				vim.keymap.set(mode, keys, func, { desc = desc })
			end

			map("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find()
			end, "Search in buffer")
			map("n", "<leader>ff", function()
				local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
				if ret == 0 then
					builtin.git_files()
				else
					builtin.find_files()
				end
			end, "Find file")
			map("n", "<leader><space>", builtin.buffers, "Find buffer")
			map("n", "<leader>fr", builtin.oldfiles, "Find recent file")
			map("n", "<leader>fR", builtin.resume, "Resume search")
			map("n", "<leader>fd", builtin.diagnostics, "Find diagnostic")
			map("n", "<leader>fh", builtin.help_tags, "Find help")
			map("n", "<leader>fw", builtin.grep_string, "Find current word")
			map("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, "Find text")
		end,
	},
}
