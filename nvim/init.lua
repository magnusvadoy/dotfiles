---@diagnostic disable: undefined-field
-- Based on : https://github.com/VonHeikemen/nvim-starter/tree/04-lsp-installer

require("user.settings")
require("user.keybindings")
require("user.commands")

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print("Installing lazy.nvim....")
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require("lazy").setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
lazy.opts = {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
}

lazy.setup({
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim",    tag = "legacy",      event = "LspAttach", opts = {} },
      "folke/neodev.nvim",
      "b0o/SchemaStore.nvim",
    },
  },
  { import = "plugins" },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- LSP config
---

-- See :help lspconfig-global-defaults
require("neodev").setup()
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

---
-- Diagnostic customization
---
local sign = function(opts)
  -- See :help sign_define()
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
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
  float = {
    source = "always",
  },
})

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd("LspAttach", {
  ---@diagnostic disable-next-line: undefined-global
  group = group,
  desc = "LSP actions",
  callback = function(_, bufnr)
    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>cr", vim.lsp.buf.rename, "Rename")
    nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
    vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
    nmap("<leader>cf", vim.lsp.buf.format, "Format Code")

    nmap("gd", vim.lsp.buf.definition, "Goto Definition")
    nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
    nmap("gr", vim.lsp.buf.references, "Goto References")
    nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
    nmap("gt", vim.lsp.buf.type_definition, "Type Definition")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")

    nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic")
    nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic")
  end,
})

---
-- LSP servers
---
-- See :help mason-settings
require("mason").setup({})

-- See :help mason-lspconfig-settings
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",
    "lua_ls",
    "yamlls",
    "jsonls",
    "jsonnet_ls",
    "tsserver",
    "html",
    "cssls",
  },
  -- See :help mason-lspconfig.setup_handlers()
  handlers = {
    function(server)
      -- See :help lspconfig-setup
      lspconfig[server].setup({})
    end,
    ["jsonls"] = function()
      lspconfig.jsonls.setup({
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,
    ["yamlls"] = function()
      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })
    end,
  },
})
