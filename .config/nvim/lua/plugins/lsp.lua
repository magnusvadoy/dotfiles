---
-- Diagnostics
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
  })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "»" })

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

---
-- LSP Keymaps
---
local augroup_keybindings = vim.api.nvim_create_augroup("UserCmds", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup_keybindings,
  desc = "LSP actions",
  callback = function(_, bufnr)
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    map({ "n", "v" }, "<leader>c", "", "code")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>cf", vim.lsp.buf.format, "Format code")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")

    map("n", "<leader>cl", vim.lsp.codelens.run, "Run Codelens")
    map("n", "<leader>cL", vim.lsp.codelens.refresh, "Refresh Codelens")

    local lsp_opts = { reuse_win = true }
    map("n", "gd", function()
      require("telescope.builtin").lsp_definitions(lsp_opts)
    end, "Goto Definition")
    map("n", "gr", function()
      require("telescope.builtin").lsp_references(lsp_opts)
    end, "Goto References")
    map("n", "gi", function()
      require("telescope.builtin").lsp_implementations(lsp_opts)
    end, "Goto Implementation")
    map("n", "go", function()
      require("telescope.builtin").lsp_type_definitions(lsp_opts)
    end, "Goto Type Definition")
    map("n", "K", vim.lsp.buf.hover, "View information")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
  end,
})

local function check_codelens_support(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
end

-- Refresh codelens on certain events
-- vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach", "BufEnter" }, {
--   desc = "LSP codelens",
--   callback = function(_, bufnr)
--     if check_codelens_support() then
--       vim.lsp.codelens.refresh({ bufnr = bufnr })
--     end
--   end,
-- })

local mason_conf = {
  lsp_servers = {
    "gopls",
    "pyright",
    "lua_ls",
    "bufls",
    "yamlls",
    "jsonls",
    "bashls",
    "dockerls",
    "markdown_oxide",
  },
  tools = {
    -- Formatter
    "goimports-reviser",
    "stylua",
    "yamlfmt",
    "shfmt",
    "prettierd",

    -- Linter
    "golangci-lint",
    "markdownlint-cli2",
    "buf",
    "ruff",

    -- DAP
    "delve",
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "b0o/SchemaStore.nvim" },
      { "folke/neodev.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local schemastore = require("schemastore")
      local yaml_companion = require("yaml-companion").setup()
      require("neodev").setup()

      local shared_capabilities =
        require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local shared_opts = {
        capabilities = shared_capabilities,
        handlers = {
          -- ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" }),
        },
      }

      mason.setup({})

      -- ensure tools (except LSPs) are installed
      local mr = require("mason-registry")
      local function install_ensured()
        for _, tool in ipairs(mason_conf.tools) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(install_ensured)
      else
        install_ensured()
      end

      mason_lspconfig.setup({
        ensure_installed = mason_conf.lsp_servers,
        -- See :help mason-lspconfig.setup_handlers()
        handlers = {
          function(server)
            -- See :help lspconfig-setup
            lspconfig[server].setup(shared_opts)
          end,
          ["jsonls"] = function()
            lspconfig.jsonls.setup({
              settings = {
                json = {
                  schemas = schemastore.json.schemas(),
                  validate = { enable = true },
                },
              },
            })
          end,
          ["yamlls"] = function()
            lspconfig.yamlls.setup(yaml_companion)
          end,
          ["markdown_oxide"] = function()
            lspconfig.markdown_oxide.setup({
              capabilities = {
                workspace = {
                  didChangeWatchedFiles = {
                    dynamicRegistration = true,
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
