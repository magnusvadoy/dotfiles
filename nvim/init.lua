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
  -- Editor
  { "nvim-telescope/telescope.nvim",            branch = "0.1.x" },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "folke/todo-comments.nvim",                 opts = {} },
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
  { import = "plugins" },
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

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
  ["<leader><leader>"] = { name = "Swap Buffer", _ = "which_key_ignore" },
  ["gz"] = { name = "Surrounding", _ = "which_key_ignore" },
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
    nmap("gr", vim.lsp.buf.references, "Goto References")
    nmap("gi", vim.lsp.buf.implementation, "Goto Implementation")
    nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
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
    "bufls",
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
