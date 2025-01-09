-- ========================================================================== --
-- ==                               AUTOCOMMANDS                           == --
-- ========================================================================== --

local autocmd = vim.api.nvim_create_autocmd

-- Use 'q' to quit from common plugins
autocmd("FileType", {
  pattern = {
    "help",
    "man",
    "lspinfo",
    "qf",
    "help",
    "notify",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Highlight on yank
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- Open quickfix window automatically
autocmd("QuickFixCmdPost", {
  pattern = "*",
  callback = function()
    vim.cmd("copen")
  end,
})
