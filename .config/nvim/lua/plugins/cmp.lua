---@diagnostic disable: missing-fields
return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    version = false,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-buffer" },
      { "andersevenrud/cmp-tmux" },
      { "lukas-reineke/cmp-rg" },

      -- Snippets
      { "saadparwaiz1/cmp_luasnip" },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
      },

      -- Copilot suggestions
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup({})
        end,
        dependencies = {
          "zbirenbaum/copilot.lua",
        },
      },

      -- For icons
      { "onsails/lspkind.nvim" },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip_present, luasnip = pcall(require, "luasnip")
      local lspkind_present, lspkind = pcall(require, "lspkind")

      if not luasnip_present or not lspkind_present then
        return false
      end

      if not cmp then
        return false
      end

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
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "copilot" },
          { name = "luasnip" },
          { name = "path" },
          { name = "calc" },
          { name = "rg", keyword_length = 3 },
          { name = "tmux", keyword_length = 3 },
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "default",
            symbol_map = { Copilot = "" },
            maxwidth = {
              abbr = 40,
              menu = 30,
            },
          }),
        },
        preselect = cmp.PreselectMode.None,
        -- See :help cmp-mapping
        mapping = {
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),

          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
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
          { name = "cmdline" },
          { name = "path" },
        }),
      })

      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
