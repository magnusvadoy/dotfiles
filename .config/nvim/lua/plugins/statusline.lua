local branch_stat = {
  "branch",
  icon = "󰘬",
  on_click = function()
    require("telescope.builtin").git_branches()
  end,
}

local diagnostics_stat = {
  "diagnostics",
  on_click = function()
    require("telescope.builtin").diagnostics()
  end,
}

local diff_stat = {
  "diff",
  on_click = function()
    require("gitsigns").diffthis()
  end,
}

local function get_schema()
  local schema = require("yaml-companion").get_buf_schema(0)
  if schema.result[1].name == "none" then
    return ""
  end
  return "󰈙 " .. schema.result[1].name
end

local function indent()
  local indent_type = vim.api.nvim_get_option_value("expandtab", { scope = "local" }) and "󱁐" or "󰌒"
  local indent_size = vim.api.nvim_get_option_value("tabstop", { scope = "local" })
  return ("%s %s"):format(indent_type, indent_size)
end

local function word_count()
  local wc = vim.fn.wordcount()
  if wc == nil then
    return ""
  end
  if wc["visual_words"] then -- text is selected in visual mode
    return wc["visual_words"] .. " Words/" .. wc["visual_chars"] .. " Chars (Vis)"
  else -- all of the document
    return wc["words"] .. " Words"
  end
end

local get_lsp_clients = function()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.lsp.get_clients({ bufnr = bufnr })
end

local function list_lsp_clients()
  local clients = get_lsp_clients()
  local list = {}
  for _, client in ipairs(clients) do
    table.insert(list, client.name)
  end
  return table.concat(list, "|")
end

local function is_macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  end
  return "Rec to " .. reg
end

return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    event = "BufReadPost",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            branch_stat,
            diff_stat,
            diagnostics_stat,
          },
          lualine_c = {
            {
              list_lsp_clients,
            },
            { "filename", path = 1 },
          },
          lualine_x = {
            {
              is_macro_recording,
              color = { fg = "red" },
              cond = function()
                return is_macro_recording() ~= ""
              end,
            },
            indent,
            get_schema,
            "filetype",
          },
          lualine_y = {
            {
              word_count,
              cond = function()
                local ft = vim.bo.filetype
                local count = {
                  latex = true,
                  tex = true,
                  text = true,
                  markdown = true,
                  vimwiki = true,
                }
                return count[ft] ~= nil
              end,
            },
            "progress",
          },
          lualine_z = { "location" },
        },
        -- not in use since globalstatus is enabled
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
