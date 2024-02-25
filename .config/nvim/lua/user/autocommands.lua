-- ========================================================================== --
-- ==                               AUTOCOMMANDS                           == --
-- ========================================================================== --

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Only show cursorline in active windows
vim.api.nvim_create_autocmd("WinEnter", {
	group = group,
	callback = function()
		vim.opt_local.cursorline = true
	end,
})
vim.api.nvim_create_autocmd("WinLeave", {
	group = group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "TelescopePrompt" },
	group = group,
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
