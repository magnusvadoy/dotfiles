local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

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
	group = group,
	desc = "LSP actions",
	callback = function(_, bufnr)
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
		end

		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>cf", vim.lsp.buf.format, "Format code")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
		map("v", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
		map("n", "<leader>cl", vim.lsp.codelens.run, "Run codelens")
		map("n", "<leader>cL", vim.lsp.codelens.refresh, "Refresh codelens")
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("n", "gr", vim.lsp.buf.references, "Goto References")
		map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
		map("n", "go", vim.lsp.buf.type_definition, "Goto Type Definition")
		map("n", "gl", vim.diagnostic.open_float, "Show Line Diagnostics")
		map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "b0o/SchemaStore.nvim" },
			{ "folke/neodev.nvim", opts = {} },
			{ "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local schemastore = require("schemastore")

			local lsp_defaults = lspconfig.util.default_config
			lsp_defaults.capabilities =
				vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

			mason.setup({})
			mason_lspconfig.setup({
				ensure_installed = {
					"gopls",
					"lua_ls",
					"yamlls",
					"jsonls",
					"jsonnet_ls",
					"bufls",
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
					["gopls"] = function()
						lspconfig.gopls.setup({
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
									},
									codelenses = {
										generate = true,
										regenerate_cgo = true,
										tidy = true,
										upgrade_dependency = true,
										vendor = true,
										test = true,
									},
									staticcheck = true,
								},
							},
						})
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
									schemas = schemastore.yaml.schemas(),
								},
							},
						})
					end,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.goimports_reviser.with({
						extra_args = {
							"-project-name=bitbucket.org/tv2norge",
							"-imports-order=std,project,company,general",
						},
					}),
					null_ls.builtins.formatting.buf,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.stylua,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							pattern = { "*.go", "*.lua" }, -- file types to auto format
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
