return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "folke/todo-comments.nvim",                 dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local utils = require("telescope.utils")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
      end

      map("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, "Fuzzy search in current buffer")
      map("n", "<leader>ff", function()
        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
        if ret == 0 then
          builtin.git_files({ show_untracked = true })
        else
          builtin.find_files()
        end
      end, "Find Files")
      map("n", "<leader>?", builtin.oldfiles, "Recently opened files")
      map("n", "<leader><space>", function()
        builtin.buffers(require("telescope.themes").get_dropdown({
          previewer = false,
          ignore_current_buffer = true,
          sort_mru = true,
        }))
      end, "Find Buffer")
      map("n", "<leader>fw", builtin.grep_string, "Find Current Word")
      map("n", "<leader>fg", builtin.live_grep, "Find Grep")
      map("n", "<leader>fr", builtin.resume, "Find Resume")
      map("n", "<leader>fd", builtin.diagnostics, "Find Diagnostics")
      map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", "Find Todo")
      map("n", "<leader>fh", builtin.help_tags, "Find Help")
      map("n", "<leader>fs", builtin.lsp_document_symbols, "Find Symbols (document)")
      map("n", "<leader>fS", builtin.lsp_workspace_symbols, "Find Symbols (workspace)")
      map("n", "<leader>ga", builtin.git_status, "Status")
      map("n", "<leader>gb", builtin.git_branches, "Branches")
      map("n", "<leader>gc", builtin.git_commits, "Commits")

      telescope.setup({
        defaults = themes.get_ivy({
          file_ignore_patterns = {
            "%.DS_Store",
            "%.git/",
            "dist/",
            "node_modules/",
          },

        }),
      })

      telescope.load_extension("fzf")
      telescope.load_extension("todo-comments")
    end,
  },
}
