---@diagnostic disable: missing-fields
-- Based on : https://github.com/VonHeikemen/nvim-starter/tree/04-lsp-installer

require("user.settings")
require("user.mappings")
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
lazy.opts = {}

lazy.setup({
  -- Colorscheme & icons
  { "nvim-tree/nvim-web-devicons" },

  -- Editor
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        offsets = {
          {
            filetype = "NvimTree",
            text = "Explorer",
            text_align = "center",
            seperator = true,
          },
        },
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
    },
  },
  { "stevearc/dressing.nvim",     opts = {} },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "nvim-telescope/telescope.nvim",            branch = "0.1.x" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/code", "~/Downloads", "/" },
    },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim" },
  { "rhysd/git-messenger.vim" },
  { "rhysd/committia.vim" },

  -- Coding
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring", -- useful for embedded languages
      "windwp/nvim-ts-autotag",                   -- autoclose and autorename html tags
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",
      },
    },
  },
  { "echasnovski/mini.comment",     opts = {} },
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
  { "ThePrimeagen/refactoring.nvim" },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  { "nvimtools/none-ls.nvim" },
  { "folke/todo-comments.nvim", opts = {} },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
    cmd = "Copilot",
  },

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
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
          })
        end,
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach", opts = {} },
      "folke/neodev.nvim",
    },
  },

  -- Debug
  { "mfussenegger/nvim-dap" },
  { "rcarriga/nvim-dap-ui" },
  { "jay-babu/mason-nvim-dap.nvim" },
  { "leoluz/nvim-dap-go" },

  -- Utilities
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
  {
    "kwkarlwang/bufresize.nvim",
    opts = {},
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {},
  },
  { import = "plugins" },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

---
-- null-ls (formatters & linters)
---

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    -- null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
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

---
-- Telescope
---
-- See :help telescope.builtin

local telescope = require("telescope")
local utils = require("telescope.utils")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fuzzy search in current buffer" })
vim.keymap.set("n", "<leader>ff", function()
  local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
  if ret == 0 then
    builtin.git_files()
  else
    builtin.find_files()
  end
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Recently opened files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffer" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find Todo" })

vim.keymap.set("n", "<leader>ga", builtin.git_status, { desc = "Status" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Branches" })
vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Commits" })

telescope.setup({
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
    },
  },
})

telescope.load_extension("fzf")

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
  ["gz"] = { name = "Surrounding", _ = "which_key_ignore" },
})

---
-- smart-splits
---

-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

-- moving between splits
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

---
-- nvim-tree (File explorer)
---
-- See :help nvim-tree-setup
require("nvim-tree").setup({
  view = { adaptive_size = true },
  update_focused_file = {
    enable = true,
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
  auto_install = false,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {
    "go",
    "gomod",
    "gowork",
    "gosum",
    "python",
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
    "bash",
    "yaml",
    "toml",
    "markdown",
    "regex",
    "diff",
    "jsonnet",
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  -- nvim-ts-context-commentstring
  context_commentstring = { enable = true },
  -- nvim-ts-autotag
  autotag = { enable = true },
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
})

---
-- autocomplete & snippets (nvim-cmp & luasnip)
---

require("luasnip.loaders.from_vscode").lazy_load()

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local select_opts = { behavior = cmp.SelectBehavior.Select }

-- See :help cmp-config
cmp.setup({
  experimental = {
    ghost_text = true,
  },
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
    { name = "copilot" },
  },
  -- window = {
  --   completion = cmp.config.window.bordered(),
  --   documentation = cmp.config.window.bordered(),
  -- },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol",    -- show only symbol annotations
      maxwidth = 50,      -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      before = function(entry, vim_item)
        local menu = {
          nvim_lsp = "Lsp",
          nvim_lua = "Lua",
          luasnip = "Snippet",
          buffer = "Buffer",
          path = "Path",
          copilot = "Copilot",
        }
        vim_item.menu = menu[entry.source.name]
        return vim_item
      end,
    }),
  },
  -- See :help cmp-mapping
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
    ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    ["<C-space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),

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
cmp.setup.cmdline({ "/", "?" }, {
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
    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
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
    "gopls",
    "lua_ls",
    "tsserver",
    "html",
    "cssls",
    "jsonnet_ls",
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
  ensure_installed = { "delve" },
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
