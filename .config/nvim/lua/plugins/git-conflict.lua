return {
  {
    "akinsho/git-conflict.nvim",
    enabled = false, -- disabled for now as it conflict's with avante
    version = "*",
    event = { "BufReadPre" },
    opts = {
      default_mappings = false,
      default_commands = true, -- disable commands created by this plugin
      disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = "copen", -- command or function to open the conflicts list
      highlights = { -- They must have background color, otherwise the default color will be used
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
  },
}
