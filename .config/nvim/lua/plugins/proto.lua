return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "buf" } },
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
