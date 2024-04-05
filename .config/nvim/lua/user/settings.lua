-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse mode
vim.opt.mouse = "a"

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Line Wraps
vim.opt.wrap = true

-- Keep 8 lines of context
vim.opt.scrolloff = 8

-- Display signs
vim.opt.signcolumn = "yes"

-- Space as leader key
vim.g.mapleader = " "

-- Statusline
vim.opt.showmode = false -- Hide the default mode text (e.g. -- INSERT -- below the statusline)

-- Enable 24-bit colours
vim.opt.termguicolors = true

-- Highlight where the cursor is
vim.opt.cursorline = true

-- Persistent undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
