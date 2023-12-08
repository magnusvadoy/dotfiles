local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

return {
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.golangci_lint,
          -- null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser.with({
            extra_args = {
              -- "--base-formatter=gofumpt",
              -- goimports-reviser -rm-unused -company-prefixes=bitbucket.org/tv2norge -imports-order=std,project,company,general
              "-rm-unused",
              "-company-prefixes=bitbucket.org/tv2norge",
              "-imports-order=std,company,general",
            },
          }),
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.stylua,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })
    end,
  },
}
