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
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    map({ "n", "v" }, "<leader>c", "", "code")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>cf", vim.lsp.buf.format, "Format code")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")

    map("n", "<leader>cl", vim.lsp.codelens.run, "Run Codelens")
    map("n", "<leader>cL", vim.lsp.codelens.refresh, "Refresh Codelens")

    local lsp_opts = {}
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
    map("n", "gs", function()
      require("telescope.builtin").lsp_document_symbols()
    end, "Goto Symbol")
    map("n", "K", vim.lsp.buf.hover, "View information")
    map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
  end,
})

local mason_conf = {
  lsp_servers = {
    "gopls",
    "templ",
    "pyright",
    "lua_ls",
    "jsonls",
    "yamlls",
    "bashls",
    "dockerls",
    "markdown_oxide",
    "ts_ls",
    "tailwindcss",
    "html",
    "htmx",
  },
  tools = {
    -- Formatters
    "goimports-reviser",
    "stylua",
    "yamlfmt",
    "shfmt",
    "prettierd",

    -- Linters
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
      { "b0o/SchemaStore.nvim", version = false },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local schemastore = require("schemastore")
      local yaml_companion = require("yaml-companion").setup()

      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")

      local default_capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {}
      )

      local shared_opts = {
        capabilities = default_capabilities,
        handlers = {},
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
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  runtime = {
                    -- Tell the language server which version of Lua you're using
                    -- (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                  },
                  diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {
                      "vim",
                      "require",
                    },
                  },
                  workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                  },
                  -- Do not send telemetry data containing a randomized but unique identifier
                  telemetry = {
                    enable = false,
                  },
                },
              },
            })
          end,
          ["jsonls"] = function()
            lspconfig.jsonls.setup({
              settings = {
                json = {
                  schemas = schemastore.json.schemas(),
                  format = { enable = true },
                  validate = { enable = true },
                },
              },
            })
          end,
          ["yamlls"] = function()
            lspconfig.yamlls.setup(yaml_companion)
          end,
          ["tailwindcss"] = function()
            lspconfig.tailwindcss.setup({
              filetypes = { "templ", "javascript", "typescript", "react" },
              settings = {
                tailwindCSS = {
                  includeLanguages = {
                    templ = "html",
                  },
                },
              },
            })
          end,
          ["htmx"] = function()
            local merged_opts = vim.tbl_extend("force", shared_opts, {
              filetypes = { "templ", "html" },
            })
            lspconfig.htmx.setup(merged_opts)
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
