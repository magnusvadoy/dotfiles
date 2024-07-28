local function get_lsp_clients()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.lsp.get_clients({ bufnr = bufnr })
end

local filetype = {
  "filetype",
  on_click = function()
    require("telescope.builtin").filetypes()
  end,
}

local branch = {
  "branch",
  icon = "󰘬",
  on_click = function()
    require("telescope.builtin").git_branches()
  end,
}

local diagnostics = {
  "diagnostics",
  on_click = function()
    require("telescope.builtin").diagnostics()
  end,
}

local diff = {
  "diff",
  on_click = function()
    require("gitsigns").diffthis()
  end,
}

local schema = {
  function()
    local buffer_schema = require("yaml-companion").get_buf_schema(0)
    if buffer_schema.result[1].name == "none" then
      return ""
    end
    return "󰈙 " .. buffer_schema.result[1].name
  end,
}

local indent = {
  function()
    local indent_type = vim.api.nvim_get_option_value("expandtab", { scope = "local" }) and "Spaces" or "Tabs"
    local indent_size = vim.api.nvim_get_option_value("tabstop", { scope = "local" })
    return ("%s: %s"):format(indent_type, indent_size)
  end,
}

local word_count = {
  function()
    local wc = vim.fn.wordcount()
    if wc == nil then
      return ""
    end
    if wc["visual_words"] then -- text is selected in visual mode
      return wc["visual_words"] .. " Words/" .. wc["visual_chars"] .. " Chars (Vis)"
    else -- all of the document
      return wc["words"] .. " Words"
    end
  end,
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
}

local copilot = {
  function()
    local clients = get_lsp_clients()
    local running = false
    for _, client in ipairs(clients) do
      if client.name == "copilot" then
        running = true
        break
      end
    end

    if running then
      return " "
    end

    return ""
  end,
}

local lsp = {
  function()
    local clients = get_lsp_clients()
    local names = {}
    for _, client in ipairs(clients) do
      if client.name == "copilot" then
        goto continue
      end
      table.insert(names, client.name)
      ::continue::
    end

    if #names == 0 then
      return ""
    end

    return (" %s"):format(table.concat(names, "|"))
  end,
  on_click = function()
    vim.cmd("LspInfo")
  end,
}

local formatters = {
  function()
    local formatters = {}
    for _, formatter in pairs(require("conform").list_formatters()) do
      if formatter.available then
        table.insert(formatters, formatter.name)
      end
    end

    if #formatters == 0 then
      return ""
    end

    return (" %s"):format(table.concat(formatters, " "))
  end,
  on_click = function()
    vim.cmd("ConformInfo")
  end,
}

local linters = {
  function()
    local linters = require("lint")._resolve_linter_by_ft(vim.bo.filetype)

    if #linters == 0 then
      return ""
    end

    return (" %s"):format(table.concat(linters, " "))
  end,
}

local file_format = {
  function()
    local fmt = vim.bo.fileformat
    if fmt == "unix" then
      return "LF"
    elseif fmt == "mac" then
      return "CR"
    else
      return "CRLF"
    end
  end,
}

local file_encoding = {
  function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    return ("%s"):format(enc:upper())
  end,
}

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
          component_separators = "",
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            branch,
            diff,
            diagnostics,
          },
          lualine_c = {
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
            file_format,
            file_encoding,
            indent,
            word_count,
          },
          lualine_y = {
            copilot,
            lsp,
            schema,
            filetype,
          },
          lualine_z = {
            "progress",
          },
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
