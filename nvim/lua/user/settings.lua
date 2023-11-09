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

-- disable netrw since we will be using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't show mode
vim.opt.showmode = false

-- Enable 24-bit colours
vim.opt.termguicolors = true

-- Highlight where the cursor is
vim.opt.cursorline = true
