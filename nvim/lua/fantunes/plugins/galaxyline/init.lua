vim.cmd([[packadd nvim-web-devicons]])
local base16 = require("base16-colorscheme")
local getBase16Scheme = require("fantunes.plugins.base16.schemes").getBase16Scheme

local fn = vim.fn
local gl = require("galaxyline")
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")
local gls = gl.section
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer" }

local getMode = function()
	local mode = vim.fn.mode()

	if mode:byte() == 22 then
		mode = "VB"
	end

	return mode
end

local getBase16Color = function(colorName)
	return function()
		return getBase16Scheme()[colorName]
	end
end

local getModeColor = function()
	local mode = getMode()
	local scheme = getBase16Scheme()
	local modeColor = {
		n = scheme.base0D,
		i = scheme.base0B,
		v = scheme.base0C,
		VB = scheme.base0C,
		V = scheme.base0C,
		c = scheme.base0A,
		r = scheme.base09,
	}
	return modeColor[mode]
end

local myIcons = require("galaxyline.provider_fileinfo").define_file_icon() -- get file icon color
myIcons["netrw"] = { getBase16Scheme().base07, "פּ" }
myIcons["fish"] = { getBase16Scheme().base0C, "" }
myIcons[".fish"] = { getBase16Scheme().base0C, "" }

local highlight = function(args)
	local cmd = "hi " .. args.name

	if args.fgColor then
		cmd = cmd .. " guifg=" .. args.fgColor
	end

	if args.bgColor then
		cmd = cmd .. " guibg=" .. args.bgColor
	end

	if args.gui then
		cmd = cmd .. " gui=" .. args.gui
	end

	vim.api.nvim_command(cmd)
end

gls.left[1] = {
	ViMode = {
		provider = function()
			local mode = getMode()
			local alias = {
				n = "NORMAL",
				i = "INSERT",
				c = "COMMAND",
				v = "VISUAL",
				V = "VISUAL LINE",
				VB = "V-BLOCK",
				r = "REPLACE",
			}
			local modeColor = getModeColor()
			highlight({ name = "GalaxyViMode", fgColor = getBase16Scheme().base07, bgColor = modeColor, gui = "bold" })

			return "  " .. alias[mode] .. " "
		end,
		-- separator = "  ",
		separator = "  ",
		-- separator_highlight = "GalaxyViModeSeparator",
		separator_highlight = { "NONE", getBase16Color("base00") },
		highlight = "GalaxyViMode",
	},
}

gls.left[2] = {
	FileIcon = {
		provider = "FileIcon",
		condition = buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, getBase16Color("base00") },
	},
}

gls.left[3] = {
	FileName = {
		provider = function()
			local provider = require("galaxyline.provider_fileinfo")
			local fgColor = getBase16Scheme().base07
			if vim.bo.modified then
				fgColor = getBase16Scheme().base08
			end
			highlight({ name = "GalaxyFileName", fgColor = fgColor, bgColor = getBase16Scheme().base00, gui = "bold" })
			return provider.get_current_file_name("ﰂ")
		end,
		condition = condition.buffer_not_empty,
		-- separator = "  ",
		separator = " ",
		separator_highlight = { getBase16Color("base00"), getBase16Color("base01") },
		-- separator_highlight = { "NONE", getBase16Color("base01") },
		highlight = "GalaxyFileName",
	},
}

gls.left[4] = {
	GitBranch = {
		provider = function()
			local vcs = require("galaxyline.provider_vcs")
			local branch_name = vcs.get_git_branch()
			if string.len(branch_name) > 28 then
				return string.sub(branch_name, 1, 25) .. "..."
			end
			return branch_name .. " "
		end,
		icon = "  ",
		condition = condition.check_git_workspace,
		--separator = "   ",
		--separator_highlight = function() return { getBase16Scheme().base03, getBase16Color("base01") } end,
		separator = "  ",
		separator_highlight = { "NONE", getBase16Color("base01") },
		highlight = { getBase16Color("base07"), getBase16Color("base01"), "bold" },
	},
}

gls.left[5] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = checkwidth,
		icon = " ",
		highlight = { getBase16Color("base0B"), getBase16Color("base01") },
	},
}
gls.left[6] = {
	DiffModified = {
		provider = "DiffModified",
		condition = checkwidth,
		icon = " ",
		highlight = { getBase16Color("base0A"), getBase16Color("base01") },
	},
}
gls.left[7] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = checkwidth,
		icon = " ",
		highlight = { getBase16Color("base08"), getBase16Color("base01") },
	},
}

gls.left[8] = {
	LeftEnd = {
		provider = function()
			return " "
		end,
		highlight = { getBase16Color("base01"), getBase16Color("base00") },
	},
}

-- gls.left[2] = {
--   LineInfo = {
--     provider = 'LineColumn',
--     separator = ' ',
--     separator_highlight = {'NONE',colors.bg},
--     highlight = {colors.fg,colors.bg},
--   },
-- }

-- gls.left[4] = {
--   PerCent = {
--     provider = 'LinePercent',
--     separator = ' ',
--     separator_highlight = {'NONE',colors.bg},
--     highlight = {colors.fg,colors.bg,'bold'},
--   }
-- }

gls.left[9] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { getBase16Color("base08"), getBase16Color("base00") },
	},
}
gls.left[10] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { getBase16Color("base0A"), getBase16Color("base00") },
	},
}

gls.left[11] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { getBase16Color("base0C"), getBase16Color("base00") },
	},
}

gls.left[12] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  ",
		highlight = { getBase16Color("base0D"), getBase16Color("base00") },
	},
}

gls.right[1] = {
	FileEncode = {
		provider = "FileEncode",
		condition = condition.hide_in_width,
		separator = " ",
		separator_highlight = { getBase16Color("base00"), getBase16Color("base01") },
		highlight = { getBase16Color("base0A"), getBase16Color("base01"), "bold" },
	},
}

gls.right[2] = {
	FileFormat = {
		provider = "FileFormat",
		condition = condition.hide_in_width,
		separator = " ",
		separator_highlight = { "NONE", getBase16Color("base01") },
		highlight = { getBase16Color("base0A"), getBase16Color("base01"), "bold" },
	},
}

gls.right[3] = {
	LineInfo = {
		provider = "LineColumn",
		separator = "  ",
		separator_highlight = { "NONE", getBase16Color("base01") },
		highlight = { getBase16Color("base07"), getBase16Color("base0C"), "bold" },
	},
}
gls.right[4] = {
	PerCent = {
		provider = "LinePercent",
		separator = "|",
		separator_highlight = { getBase16Color("base00"), getBase16Color("base0C") },
		highlight = { getBase16Color("base07"), getBase16Color("base0C"), "bold" },
	},
}

gls.right[5] = {
	EndRight = {
		provider = function()
			return " ▊"
		end,
		highlight = { getBase16Color("base0C"), getBase16Color("base0C") },
	},
}

gls.short_line_left[1] = {
	BufferType = {
		provider = "FileTypeName",
		separator = " ",
		separator_highlight = { "NONE", getBase16Color("base00") },
		highlight = { colors.blue, colors.bg, "bold" },
	},
}

gls.short_line_left[2] = {
	SFileName = {
		provider = "SFileName",
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, "bold" },
	},
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		highlight = { colors.fg, colors.bg },
	},
}
