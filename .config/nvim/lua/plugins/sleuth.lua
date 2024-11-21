return {
  -- Automatically adjust 'shiftwidth' and 'expandtab' heuristically based on the current file.
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
}
