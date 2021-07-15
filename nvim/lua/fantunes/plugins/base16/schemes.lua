local base16 = require("base16-colorscheme")

local M = {}

function M.getBase16Scheme()
	local colorschemeName = vim.g.colors_name:gsub("base16%-", "")
	return base16.colorschemes[colorschemeName]
end

function M.load()
	local cmd = vim.api.nvim_command
	local colorBg = M.getBase16Scheme().base00
	local colorError = M.getBase16Scheme().base08
	local colorWarning = M.getBase16Scheme().base0A
	cmd("hi ALEError guibg=" .. colorBg .. " gui=underline")
	cmd("hi ALEErrorSign guibg=" .. colorBg .. " guifg=" .. colorError)
	cmd("hi ALEWarning guibg=" .. colorBg .. " gui=underline")
	cmd("hi ALEWarningSign guibg=" .. colorBg .. " guifg=" .. colorWarning)
end

return M
