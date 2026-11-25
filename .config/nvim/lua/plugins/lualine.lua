return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- show the full file path in the statusline (LazyVim truncates to 3 parts by default)
    -- index 4 is LazyVim's pretty_path component in lualine_c
    opts.sections.lualine_c[4] = { LazyVim.lualine.pretty_path({ length = 0 }) }
  end,
}
