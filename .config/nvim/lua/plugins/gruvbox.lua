return {
  "sainnhe/gruvbox-material",
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_foreground = "material"
    vim.g.gruvbox_material_float_style = "dim"

    vim.g.gruvbox_material_diagnostic_text_highlight = 0
    vim.g.gruvbox_material_diagnostic_line_highlight = 0
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.g.gruvbox_material_current_word = "high contrast background"
  end,
}
