-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Editing: save
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<CMD>w<CR>", { desc = "Save file" })

-- Rename current word
vim.keymap.set("n", "<leader>R", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })

-- Buffers
vim.keymap.set("n", "<leader>bd", "<CMD>bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", "<leader>bD", "<CMD>%bd|e#|bd#<CR>", { desc = "Delete other buffers" })

-- Keeps cursor in place while jumping
vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- Keep cursor in place while cycling search term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Copy to system clipboard
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to clipboard" })

-- Navigate quick fix list
vim.keymap.set("n", "]q", "<CMD>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<CMD>cprev<CR>zz", { desc = "Previous quickfix" })

-- Switch tabs
vim.keymap.set("n", "]t", "<CMD>tabn<CR>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<CMD>tabp<CR>", { desc = "Previous tab" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
