return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
      {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
          local todo_comments = require("todo-comments")
          todo_comments.setup({})

          vim.keymap.set("n", "]t", function()
            todo_comments.jump_next()
          end, { desc = "Next todo comment" })

          vim.keymap.set("n", "[t", function()
            todo_comments.jump_prev()
          end, { desc = "Previous todo comment" })
        end,
      },
      { "rmagatti/auto-session" },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local utils = require("telescope.utils")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local lga_actions = require("telescope-live-grep-args.actions")
      local session_lens = require("auto-session.session-lens")

      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { desc = desc })
      end

      map("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find()
      end, "Search current buffer")
      map("n", "<leader>ff", function()
        local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
        if ret == 0 then
          builtin.git_files({ show_untracked = true })
        else
          builtin.find_files()
        end
      end, "Files")
      map("n", "<leader>?", builtin.oldfiles, "Recently opened files")
      map("n", "<leader><space>", function()
        builtin.buffers({
          ignore_current_buffer = true,
          sort_mru = true,
        })
      end, "Buffers")
      map("n", "<leader>fw", builtin.grep_string, "Current word")
      map("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, "Grep")
      map("n", "<leader>fr", builtin.resume, "Resume search")
      map("n", "<leader>fd", builtin.diagnostics, "Diagnostics")
      map("n", "<leader>fh", builtin.help_tags, "Help")

      -- Session
      map("n", "<leader>fs", session_lens.search_session, "Sessions")

      -- Todo Comments
      map("n", "<leader>ft", "<CMD>TodoTelescope<CR>", "Todos")

      telescope.setup({
        defaults = themes.get_ivy({
          file_ignore_patterns = {
            "%.DS_Store",
            "%.git/",
            "dist/",
            "node_modules/",
          },
        }),
        extensions = {
          fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          live_grep_args = {
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
              },
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("todo-comments")
    end,
  },
}
