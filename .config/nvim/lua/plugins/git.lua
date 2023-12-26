return {
  { "tpope/vim-fugitive", event = { "InsertEnter", "CmdlineEnter" } },
  { "rhysd/committia.vim" },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▏" },
        change = { text = "▏" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▏" },
        untracked = { text = "▏" },
      },
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 500,
        ignore_whitespace = false,
      },
      preview_config = {
        border = "solid",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Git: " .. desc })
        end

        -- Navigation
        map("n", "[g", gs.prev_hunk, "Prev git hunk")
        map("n", "]g", gs.next_hunk, "Next git hunk")

        -- Actions
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Unstage hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = true })
        end, "Show blame")
        map("n", "<leader>gd", gs.diffthis, "View diff")

        -- Text object
        map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>", "Select git hunk")
      end,
    },
  },
}
