local base16 = require("base16-colorscheme")

local M = {}

function M.getBase16SchemeName()
  return vim.g.colors_name:gsub("base16%-", "")
end

function M.getBase16Scheme()
  local colorschemeName = M.getBase16SchemeName()
  return base16.colorschemes[colorschemeName]
end

function M.load()
  if vim.fn.filereadable(vim.fn.expand("~/.vimrc_background")) then
    vim.cmd("source $HOME/.vimrc_background")
  end
  local colorschemeName = M.getBase16SchemeName()
  vim.cmd("colorscheme base16-" .. colorschemeName)
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
