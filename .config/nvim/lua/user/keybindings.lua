-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Editing: save
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>W", "<Cmd>wall<CR>", { desc = "Save all buffers" })

-- Select whole file
vim.keymap.set("n", "<leader>S", ":keepjumps normal! ggVG<CR>", { desc = "Select all" })

-- Replace the current word
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename word" })

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
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank to clipboard" })    -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste from clipboard" }) -- paste

-- Toggle Quickfix
vim.keymap.set("n", "<C-q>", function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd("cclose")
    else
      vim.cmd("copen")
    end
  end
end, { desc = "Toggle Quickfix" })

-- Navigate quick fix list
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<Cmd>cprev<CR>zz", { desc = "Previous quickfix" })
