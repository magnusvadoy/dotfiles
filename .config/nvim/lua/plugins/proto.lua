return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "buf" } },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        proto = { "buf" },
      },
    },
  },
}
