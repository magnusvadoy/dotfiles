-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = group,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  group = group,
  command = "nnoremap <buffer> q <cmd>quit<cr>",
})

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
