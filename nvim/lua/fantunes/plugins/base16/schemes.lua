local base16 = require("base16-colorscheme")

local M = {}

function M.getBase16Scheme()
  local colorschemeName = vim.g.colors_name:gsub("base16%-", "")
  return base16.colorschemes[colorschemeName]
end

function M.load(colorscheme)
  vim.cmd("colorscheme " .. colorscheme)
  local cmd = vim.api.nvim_command
  local colorBg = M.getBase16Scheme().base00
  local colorError = M.getBase16Scheme().base08
  local colorWarning = M.getBase16Scheme().base0A
  local colorHint = M.getBase16Scheme().base0C
  local colorInfo = M.getBase16Scheme().base0D

  local signs = {
    Error = { text = " ", color = colorError },
    Warning = { text = " ", color = colorWarning },
    Hint = { text = " ", color = colorHint },
    Information = { text = " ", color = colorInfo },
  }

  for type, icon in pairs(signs) do
    local hl = "LspDiagnosticsSign" .. type
    vim.fn.sign_define(hl, { text = icon.text, texthl = hl, numhl = "" })

    cmd("hi " .. hl .. " guibg=" .. colorBg .. " guifg=" .. icon.color)
  end
end

return M
