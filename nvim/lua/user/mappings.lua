-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Select whole file
vim.keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select All" })

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

-- Ctrl + s to save
vim.keymap.set("n", "<C-s>", "<cmd>write<cr>", { desc = "Write file" })

-- Replace the current word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename Word" })

-- Buffers
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>j", "<cmd>bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>k", "<cmd>bp<cr>", { desc = "Previous buffer" })
