return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
      formatters = {
        goimports = {
          command = "goimports-reviser",
          args = {
            "--company-prefixes=bitbucket.org/tv2norge,golang.tv2.no",
            "-imports-order=std,project,company,general",
            "-format",
            "$FILENAME",
          },
          stdin = false,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "goimports-reviser" } },
  },
}
