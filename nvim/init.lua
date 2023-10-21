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
vim.opt.wrap = true

-- Keep 8 lines of context
vim.opt.scrolloff = 8

-- Display signs
vim.opt.signcolumn = "yes"

-- Space as leader key
vim.g.mapleader = " "

-- disable netrw since we will be using nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't show mode in
vim.opt.showmode = false

-- Enable 24-bit colours
vim.opt.termguicolors = true

-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Select whole file
vim.keymap.set("n", "<leader>sa", ":keepjumps normal! ggVG<cr>", { desc = "Select All" })

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
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Yank" }) -- copy
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste" }) -- paste

-- Leader + w to save
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write file" })

-- Replace the current word
vim.keymap.set("n", "<leader>rw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename Word" })

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
	{ "catppuccin/nvim" },
	{ "f-person/auto-dark-mode.nvim" },
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy" },
	{ "akinsho/bufferline.nvim", event = "VeryLazy", opts = {} },
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		main = "ibl",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = false },
		},
	},
	{ "nvim-tree/nvim-web-devicons", event = "VeryLazy" },
	{ "echasnovski/mini.indentscope", opts = {} },

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Fuzzy finder
	{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Git integration
	{ "lewis6991/gitsigns.nvim" },
	{ "tpope/vim-fugitive" },

	-- Coding
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring", -- useful for embedded languages
			"windwp/nvim-ts-autotag", -- autoclose and autorename html tags
		},
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{ "echasnovski/mini.surround", event = "VeryLazy", opts = {} },
	{ "echasnovski/mini.comment", event = "VeryLazy", opts = {} },
	{ "stevearc/conform.nvim", dependencies = { "mason.nvim" }, lazy = true, cmd = "ConformInfo" },
	{ "ThePrimeagen/refactoring.nvim" },

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
		},
	},

	-- LSP
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "folke/neodev.nvim" },

	-- Debug
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "jay-babu/mason-nvim-dap.nvim" },
	{ "leoluz/nvim-dap-go" },

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
	{ "akinsho/toggleterm.nvim" },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- Colorscheme & statusline (lualine)
---

local function configure_lualine()
	require("lualine").setup({
		options = {
			theme = "tokyonight",
			icons_enabled = true,
			component_separators = "|",
			section_separators = "",
			disabled_filetypes = {
				statusline = { "NvimTree" },
			},
		},
	})
end

require("auto-dark-mode").setup({
	update_interval = 1000,
	set_dark_mode = function()
		vim.api.nvim_set_option("background", "dark")
		require("catppuccin").setup({
			flavour = "mocha",
		})
		vim.cmd("colorscheme catppuccin")
		configure_lualine()
	end,
	set_light_mode = function()
		vim.api.nvim_set_option("background", "light")
		require("catppuccin").setup({
			flavour = "latte",
		})
		vim.cmd("colorscheme catppuccin")
		require("lualine").setup({
			options = {
				icons_enabled = true,
				disabled_filetypes = {
					statusline = { "NvimTree" },
				},
			},
		})
		configure_lualine()
	end,
})

---
-- Icons
---

local icons = {
	Text = "󰉿",
	Method = "m",
	Function = "󰊕",
	Constructor = "",
	Field = "",
	Variable = "󰆧",
	Class = "󰌗",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰇽",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰊄",
	Codeium = "󰚩",
	Copilot = "",
}

---
-- vim-bbye
---

vim.keymap.set("n", "<leader>bc", "<cmd>Bdelete<cr>", { desc = "Close" })
vim.keymap.set("n", "<leader>n", "<cmd>bn<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bp<cr>", { desc = "Previous buffer" })

---
-- formatter (conform.nvim)
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
-- refactoring
---

require("refactoring").setup()

vim.keymap.set("x", "<leader>re", ":Refactor extract")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file")
vim.keymap.set("x", "<leader>rv", ":Refactor extract_var")
vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")
vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("refactoring").select_refactor()
end)
---
-- Gitsigns
---
-- See :help gitsigns-usage

local gitsigns = require("gitsigns")

gitsigns.setup({
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

vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { desc = "Next hunk" })
vim.keymap.set("n", "<leader>gp", gitsigns.prev_hunk, { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
vim.keymap.set("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff" })
vim.keymap.set("n", "<leader>gtd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

---
-- Telescope
---
-- See :help telescope.builtin

local utils = require("telescope.utils")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Recently opened files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find buffer" })
vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzy search in current buffer" })
vim.keymap.set("n", "<leader>cd", builtin.diagnostics, { desc = "Code Diagnostics" })

-- Use git_files if in git repo, otherwise fall back to find_files
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

vim.keymap.set("n", "<leader>ff", project_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })

vim.keymap.set("n", "<leader>ga", builtin.git_status, { desc = "Status" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })

require("telescope").setup({})
require("telescope").load_extension("fzf")

---
-- which-key
---
require("which-key").register({
	["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
	["<leader>r"] = { name = "Refactor", _ = "which_key_ignore" },
	["<leader>b"] = { name = "Buffer", _ = "which_key_ignore" },
	["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
	["<leader>s"] = { name = "Select", _ = "which_key_ignore" },
	["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
	["<leader>d"] = { name = "Debug", _ = "which_key_ignore" },
})

---
-- toggleterm
---

require("toggleterm").setup({
	open_mapping = "<C-g>",
	direction = "float",
	shade_terminals = true,
})

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

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File explorer" })

---
-- annotations (neogen)
---

require("neogen").setup({ snippet_engine = "luasnip" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>cn",
	":lua require('neogen').generate()<CR>",
	{ noremap = false, silent = true, desc = "Code Annotations" }
)

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
	-- nvim-ts-context-commentstring
	context_commentstring = {
		enable = true,
	},
	-- nvim-ts-autotag
	autotag = {
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
local luasnip = require("luasnip")
-- local lspkind = require("lspkind")
local select_opts = { behavior = cmp.SelectBehavior.Select }

-- See :help cmp-config
cmp.setup({
	experimental = {
		ghost_text = true,
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
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = icons[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]
			return vim_item
		end,
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
	callback = function(_, bufnr)
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
		end

		nmap("<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
		nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

		nmap("gd", vim.lsp.buf.definition, "Goto Definition")
		nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
		nmap("gr", builtin.lsp_references, "Goto References")
		nmap("gI", builtin.lsp_implementations, "Goto Implementation")
		nmap("go", vim.lsp.buf.type_definition, "Type Definition")
		nmap("<leader>cs", builtin.lsp_document_symbols, "Code Symbols")

		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

		nmap("gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
		nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
		nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

		-- Lesser used LSP functionality
		-- nmap("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		-- nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		-- nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		-- nmap("<leader>wl", function()
		-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		-- end, "[W]orkspace [L]ist Folders")
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
		"tsserver",
		"eslint",
		"html",
		"cssls",
		"gopls",
		"csharp_ls",
		"lua_ls",
		"svelte",
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

---
-- DAP
---

local dap = require("dap")

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dapui.setup()

-- servers
require("mason-nvim-dap").setup({
	ensure_installed = { "delve", "js-debug-adapter" },
	automatic_installation = false,
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "error", linehl = "", numhl = "" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

-- bindings
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Breakpoint Condition" })

-- Go
require("dap-go").setup()
