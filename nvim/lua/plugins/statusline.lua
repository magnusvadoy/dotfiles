local branch_stat = {
  "branch",
  icon = "󰘬",
  on_click = function()
    require("telescope.builtin").git_branches()
  end,
}

local diagnostics_stat = {
  "diagnostics",
  on_click = function()
    require("telescope.builtin").diagnostics()
  end,
}

local diff_stat = {
  "diff",
  on_click = function()
    require("gitsigns").diffthis()
  end,
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPost",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        theme = "tokyonight",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { branch_stat, diff_stat, diagnostics_stat },
        lualine_c = { { "filename" }, { "searchcount", icon = "󰍉" } },
        lualine_x = {},
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {
        "fugitive",
        "nvim-tree",
        "nvim-dap-ui",
      },
    },
  },
}
