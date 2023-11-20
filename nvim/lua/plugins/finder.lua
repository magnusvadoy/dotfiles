return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "folke/todo-comments.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local utils = require("telescope.utils")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "Fuzzy search in current buffer" })
      vim.keymap.set("n", "<leader>ff", function()
        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
        if ret == 0 then
          builtin.git_files()
        else
          builtin.find_files()
        end
      end, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Recently opened files" })
      vim.keymap.set("n", "<leader><space>", function()
        builtin.buffers(require("telescope.themes").get_dropdown({
          previewer = false,
          ignore_current_buffer = true,
          sort_mru = true,
        }))
      end, { desc = "Find Buffer" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
      vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find Todo" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })

      vim.keymap.set("n", "<leader>ga", builtin.git_status, { desc = "Status" })
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Branches" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })

      telescope.setup({})
      telescope.load_extension("fzf")
    end,
  },
}
