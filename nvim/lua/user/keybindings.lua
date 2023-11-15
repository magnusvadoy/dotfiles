-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Editing: save
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save file" })

-- Select whole file
vim.keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<CR>", { desc = "Select All" })

-- Replace the current word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename Word" })

-- Move blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor in place while jumping
vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- Keep cursor in place while cycling search term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank" })  -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste" }) -- paste

-- Buffers
vim.keymap.set("n", "<leader>bc", "<Cmd>bdelete<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>j", "<Cmd>bn<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>k", "<Cmd>bp<CR>", { desc = "Previous buffer" })

-- Split windows
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split below" })
vim.keymap.set("n", "<leader>=", "<C-W>v", { desc = "Split right" })

-- Press esc in normal mode to cancel search highlighting
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search" })
