local v = vim.version()
local version = " version " .. v.major .. "." .. v.minor .. "." .. v.patch
local date = os.date("Today is %a %d %b")

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = {
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      }

      dashboard.section.header.val = logo
      dashboard.section.buttons.val = {
        dashboard.button("n", " " .. " New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", " " .. " Find File", "<cmd>Telescope find_files<CR>"), -- TODO: Share this functionality with Telescope
        dashboard.button("r", " " .. " Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("g", " " .. " Find Text", "<cmd>Telescope live_grep_args<CR>"),
        dashboard.button("s", " " .. " Restore Session", "<cmd>SessionManager load_current_dir_session<CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)
    end,
  },
}
