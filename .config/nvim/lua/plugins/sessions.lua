return {
	{
		"Shatur/neovim-session-manager",
		config = function()
			local path = require("plenary.path")
			local config = require("session_manager.config")

			require("session_manager").setup({
				sessions_dir = path:new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
				autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
				autosave_last_session = true, -- Automatically save last session on exit and on session switch.
				autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
				autosave_ignore_dirs = {
					"~/",
					"~/code",
					"~/Downloads",
					"/",
				}, -- A list of directories where the session will not be autosaved.
				autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
					"gitcommit",
					"gitrebase",
				},
				autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
				autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
				max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
			})

			vim.keymap.set(
				"n",
				"<leader>sl",
				"<cmd>SessionManager load_current_dir_session<CR>",
				{ desc = "Load last session for current dir" }
			)
			vim.keymap.set(
				"n",
				"<leader>sL",
				"<cmd>SessionManager load_session<CR>",
				{ desc = "Select and load session" }
			)
			vim.keymap.set(
				"n",
				"<leader>sd",
				"<cmd>SessionManager delete_session<CR>",
				{ desc = "Select and delete session" }
			)
			vim.keymap.set(
				"n",
				"<leader>sD",
				"<cmd>SessionManager delete_current_dir_session<CR>",
				{ desc = "Delete the session for current dir" }
			)
		end,
	},
}
