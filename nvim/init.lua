-- Based on : https://github.com/VonHeikemen/nvim-starter/tree/04-lsp-installer
-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse mode
vim.opt.mouse = "a"

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Line Wraps
vim.opt.wrap = false

-- Keep 8 lines of context
vim.opt.scrolloff = 8

-- Display signs
vim.opt.signcolumn = "yes"

-- Space as leader key
vim.g.mapleader = " "

-- disable netrw since we will be using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colours
vim.opt.termguicolors = true

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Select whole file
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

-- Move blocks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor in place while jumping
vim.keymap.set("n", "<C-d", "<C-d>zz")
vim.keymap.set("n", "<C-u", "<C-u>zz")

-- Keep cursor in place while cycling search term
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Basic clipboard interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y') -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p') -- paste

-- Leader + w to save
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>")

-- Replace the current word
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command("ReloadConfig", "source $MYVIMRC", {})

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help", "man" },
	group = group,
	command = "nnoremap <buffer> q <cmd>quit<cr>",
})

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
lazy.opts = {}

lazy.setup({
	-- Theming & UI
	{ "folke/tokyonight.nvim" },
	{ "f-person/auto-dark-mode.nvim" },
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	{ "akinsho/bufferline.nvim", opts = {} },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = true },
		},
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Git integration
	{ "lewis6991/gitsigns.nvim" },

	-- Coding
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring", -- useful for embedded languages
		},
		keys = {
			{ "<c-space>", desc = "Increment selection" },
			{ "<bs>", desc = "Decrement selection", mode = "x" },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{ "echasnovski/mini.surround", version = false, opts = {} },
	{ "echasnovski/mini.comment", version = false, opts = {} },
	{ "stevearc/conform.nvim", dependencies = { "mason.nvim" }, lazy = true, cmd = "ConformInfo" },

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	-- Autocomplete & snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "onsails/lspkind.nvim" },
		},
	},

	-- Utilities
	{ "moll/vim-bbye" },
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
	},
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme
---
require("auto-dark-mode").setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option("background", "dark")
		vim.cmd("colorscheme tokyonight")
	end,
	set_light_mode = function()
		vim.api.nvim_set_option("background", "light")
		vim.cmd("colorscheme tokyonight-day")
	end,
})

-- vim-bbye
---
vim.keymap.set("n", "<leader>bc", "<cmd>Bdelete<cr>")

---
-- lualine.nvim (statusline)
---
vim.opt.showmode = false

-- See :help lualine.txt
require("lualine").setup({
	options = {
		theme = "tokyonight",
		icons_enabled = true,
		disabled_filetypes = {
			statusline = { "NvimTree" },
		},
	},
})

---
-- conform.nvim
---
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		jsx = { "prettierd", "prettier" },
		css = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		markdown = { "prettierd", "prettier" },
		html = { "prettierd", "prettier" },
	},
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

---
-- Gitsigns
---
-- See :help gitsigns-usage
require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "➤" },
		topdelete = { text = "➤" },
		changedelete = { text = "▎" },
	},
	current_line_blame = true,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 500,
		ignore_whitespace = false,
	},
})

---
-- Telescope
---
-- See :help telescope.builtin
vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader><space>", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>")

require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
})

require("telescope").load_extension("fzf")

---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>")

---
-- Treesitter
---
-- See :help nvim-treesitter-modules
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = {
		"go",
		"lua",
		"typescript",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"tsx",
		"svelte",
		"html",
		"css",
		"scss",
		"c_sharp",
		"bash",
		"yaml",
		"toml",
		"markdown",
		"regex",
		"diff",
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
	-- :help nvim-treesitter-textobjects-modules
	textobjects = {
		move = {
			enable = true,
			goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
			goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
			goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
			goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
		},
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
	context_commentstring = {
		enable = true,
	},
})

---
-- Luasnip (snippet engine)
---
-- See :help luasnip-loaders
require("luasnip.loaders.from_vscode").lazy_load()

---
-- nvim-cmp (autocomplete)
---

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local select_opts = { behavior = cmp.SelectBehavior.Select }

-- See :help cmp-config
cmp.setup({
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	completion = { completeopt = "menu,menuone,noinsert" },
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nvim_lsp_signature_help" },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				local menu_icon = {
					buffer = "[Buf]",
					nvim_lsp = "[Lsp]",
					nvim_lua = "[Lua]",
					luasnip = "[Snip]",
					path = "[Path]",
				}
				vim_item.menu = menu_icon[entry.source.name]
				return vim_item
			end,
		}),
	},
	-- See :help cmp-mapping
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item(select_opts),
		["<Down>"] = cmp.mapping.select_next_item(select_opts),

		["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
		["<C-n>"] = cmp.mapping.select_next_item(select_opts),

		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- that way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

-- autopairs integration
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

---
-- LSP config
---
-- See :help lspconfig-global-defaults
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
		border = "rounded",
		source = "always",
	},
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

---
-- LSP Keybindings
---
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	desc = "LSP actions",
	callback = function()
		local bufmap = function(mode, lhs, rhs)
			local opts = { buffer = true }
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- You can search each function in the help page.
		-- For example :help vim.lsp.buf.hover()

		-- bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
		bufmap("n", "gd", "<cmd>Telescope lsp_definitions<cr>")
		bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
		bufmap("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
		bufmap("n", "go", "<cmd>Telescope lsp_type_definitions<cr>")
		bufmap("n", "gr", "<cmd>Telescope lsp_references<cr>")
		bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
		bufmap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
		bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
		bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")
		bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
		bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
	end,
})

---
-- LSP servers
---
-- See :help mason-settings
require("mason").setup({
	ui = { border = "rounded" },
})

-- See :help mason-lspconfig-settings
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"eslint",
		"html",
		"cssls",
		"gopls",
		"csharp_ls",
		"lua_ls",
	},
	-- See :help mason-lspconfig.setup_handlers()
	handlers = {
		function(server)
			-- See :help lspconfig-setup
			lspconfig[server].setup({})
		end,
		["tsserver"] = function()
			lspconfig.tsserver.setup({
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
				},
			})
		end,
		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
		end,
	},
})
