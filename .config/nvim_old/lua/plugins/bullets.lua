local enabled_file_types = {
  "markdown",
  "text",
  "gitcommit",
  "scratch",
}

return {
  "dkarter/bullets.vim",
  config = function()
    vim.g.bullets_enabled_file_types = enabled_file_types
    vim.g.bullets_set_mappings = 0
    vim.g.bullets_custom_mappings = {
      { "imap", "<cr>", "<Plug>(bullets-newline)" },
      { "inoremap", "<C-cr>", "<cr>" },

      { "nmap", "o", "<Plug>(bullets-newline)" },

      { "nmap", "gN", "<Plug>(bullets-renumber)" },
      { "vmap", "gN", "<Plug>(bullets-renumber)" },
      { "imap", "<C-t>", "<Plug>(bullets-demote)" },
      { "imap", "<C-d>", "<Plug>(bullets-promote)" },
    }
  end,
  ft = enabled_file_types,
}
