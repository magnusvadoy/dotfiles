return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",     build = "make" },
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "folke/todo-comments.nvim",                     dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      local telescope = require("telescope")
      local utils = require("telescope.utils")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      local lga_actions = require("telescope-live-grep-args.actions")

      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { desc = "Telescope: " .. desc })
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
      end, "Find file")
      map("n", "<leader>?", builtin.oldfiles, "Recently opened files")
      map("n", "<leader><space>", function()
        builtin.buffers({
          ignore_current_buffer = true,
          sort_mru = true,
        })
      end, "Find buffer")
      map("n", "<leader>fc", builtin.command_history, "Find command history")
      map("n", "<leader>fw", builtin.grep_string, "Find current word")
      map("n", "<leader>fg", telescope.extensions.live_grep_args.live_grep_args, "Find grep")
      map("n", "<leader>fr", builtin.resume, "Find resume")
      map("n", "<leader>fd", builtin.diagnostics, "Find diagnostics")
      map("n", "<leader>fh", builtin.help_tags, "Find help")
      map("n", "<leader>fs", builtin.spell_suggest, "Find spelling")
      map("n", "<leader>ga", builtin.git_status, "Status")
      map("n", "<leader>gb", builtin.git_branches, "Branches")
      map("n", "<leader>gc", builtin.git_commits, "Commits")
      map("n", "<leader>ft", "<CMD>TodoTelescope<CR>", "Find todo")
      map("n", "<leader>e", "<CMD>Telescope file_browser<CR>", "File Explorer")

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
          file_browser = {
            hijack_netrw = true,
            initial_mode = "normal",
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
      telescope.load_extension("file_browser")
      telescope.load_extension("todo-comments")
    end,
  },
}
