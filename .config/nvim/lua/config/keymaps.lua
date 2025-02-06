-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remove default keymaps that are never used
vim.keymap.del("n", "<leader>`")
vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
