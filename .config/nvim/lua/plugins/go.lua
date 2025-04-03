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
            "-company-prefixes=bitbucket.org/tv2norge,golang.tv2.no",
            "-project-name=bitbucket.org/tv2norge",
            "-imports-order=std,project,company,general",
            "-rm-unused",
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
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    opts = {},
  },
}
