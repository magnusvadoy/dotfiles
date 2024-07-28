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
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- use spaces instead of tabs

-- Line Wraps
vim.opt.wrap = false
vim.opt.smoothscroll = true -- scroll by screen line rather than by text line when 'wrap' is set

-- Keep 8 lines of context
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Grepping
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"

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

-- Disable swap and enable undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Lower than default timeout (1000) to quickly trigger which-key
vim.opt.timeoutlen = 300

-- Maximum number of items in a popup
vim.opt.pumheight = 10

-- Splitting windows
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current

-- Spelling
vim.opt.spell = false
vim.opt.spelllang = "en"

-- global status line
vim.opt.laststatus = 3
