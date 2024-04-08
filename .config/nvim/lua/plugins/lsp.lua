local augroup_keybindings = vim.api.nvim_create_augroup("UserCmds", {})

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
	group = augroup_keybindings,
	desc = "LSP actions",
	callback = function(_, bufnr)
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
		end

		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>cf", vim.lsp.buf.format, "Format code")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
		map("v", "<leader>ca", vim.lsp.buf.code_action, "Code actions")

		map("n", "<leader>cl", vim.lsp.codelens.run, "Codelens: Run")
		map("n", "<leader>cL", vim.lsp.codelens.refresh, "Codelens: Refresh")

		map("n", "gd", function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end, "Goto Definition")
		map("n", "gr", function()
			require("telescope.builtin").lsp_references({ reuse_win = true })
		end, "Goto References")
		map("n", "gi", function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end, "Goto Implementation")
		map("n", "go", function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end, "Goto Type Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")

		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
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
}
