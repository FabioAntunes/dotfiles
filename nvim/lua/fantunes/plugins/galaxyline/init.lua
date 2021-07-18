vim.cmd([[packadd nvim-web-devicons]])
local getBase16Scheme = require("fantunes.plugins.base16.schemes").getBase16Scheme

local gl = require("galaxyline")
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
      local length = "short"
      if condition.hide_in_width() then
        length = "long"
      end

      local alias = {
        n = { long = "NORMAL", short = "N" },
        i = { long = "INSERT", short = "I" },
        c = { long = "COMMAND", short = "C" },
        v = { long = "VISUAL", short = "V" },
        V = { long = "V-LINE", short = "VL" },
        VB = { long = "V-BLOCK", short = "VB" },
        r = { long = "REPLACE", short = "R" },
      }
      local modeColor = getModeColor()
      highlight({
        name = "GalaxyViMode",
        fgColor = getBase16Scheme().base07,
        bgColor = modeColor,
        gui = "bold",
      })

      return "  " .. alias[mode][length] .. " "
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
    condition = condition.buffer_not_empty,
    highlight = {
      require("galaxyline.provider_fileinfo").get_file_icon_color,
      getBase16Color("base00"),
    },
  },
}

local shortenPath = function(s)
  local splitPath = {}
  local result = {}
  for match in (s .. "/"):gmatch("(.-)" .. "/") do
    table.insert(splitPath, match)
  end

  local filename = table.remove(splitPath)
  local parentDir = table.remove(splitPath)
  for _, folder in ipairs(splitPath) do
    table.insert(result, string.sub(folder, 1, 1))
  end
  table.insert(result, parentDir)
  table.insert(result, filename)
  return table.concat(result, "/")
end

local function file_with_icons(short)
  local function buffer_is_readonly()
    if vim.bo.filetype == "help" then
      return false
    end
    return vim.bo.readonly
  end

  local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  if short or not condition.hide_in_width() then
    file = vim.fn.expand("%:t")
  end

  if string.len(file) > 25 then
    file = shortenPath(file)
  end

  if vim.fn.empty(file) == 1 then
    return ""
  end

  local modified_icon = "ﰂ"
  local readonly_icon = ""

  if buffer_is_readonly() then
    file = file .. " " .. readonly_icon
  end

  if vim.bo.modifiable and vim.bo.modified then
    file = file .. " " .. modified_icon
  end

  return " " .. file .. " "
end

gls.left[3] = {
  FileName = {
    provider = function()
      local fgColor = getBase16Scheme().base07
      if vim.bo.modified then
        fgColor = getBase16Scheme().base08
      end
      highlight({
        name = "GalaxyFileName",
        fgColor = fgColor,
        bgColor = getBase16Scheme().base00,
        gui = "bold",
      })
      return file_with_icons()
    end,
    condition = condition.buffer_not_empty,
    highlight = "GalaxyFileName",
  },
}

gls.left[4] = {
  FileSeparator = {
    provider = function()
      return "  "
    end,
    condition = function()
      return condition.check_git_workspace() and condition.hide_in_width()
    end,
    highlight = { getBase16Color("base00"), getBase16Color("base01") },
  },
}

gls.left[5] = {
  GitBranch = {
    provider = function()
      local vcs = require("galaxyline.provider_vcs")
      local branch_name = vcs.get_git_branch()
      if branch_name and string.len(branch_name) > 28 then
        return string.sub(branch_name, 1, 25) .. "..."
      end
      return branch_name
    end,
    icon = "  ",
    condition = function()
      return condition.check_git_workspace() and condition.hide_in_width()
    end,
    separator = "  ",
    separator_highlight = { "NONE", getBase16Color("base01") },
    highlight = { getBase16Color("base07"), getBase16Color("base01"), "bold" },
  },
}

gls.left[6] = {
  DiffAdd = {
    provider = "DiffAdd",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { getBase16Color("base0B"), getBase16Color("base01") },
  },
}
gls.left[7] = {
  DiffModified = {
    provider = "DiffModified",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { getBase16Color("base0A"), getBase16Color("base01") },
  },
}
gls.left[8] = {
  DiffRemove = {
    provider = "DiffRemove",
    condition = condition.hide_in_width,
    icon = " ",
    highlight = { getBase16Color("base08"), getBase16Color("base01") },
  },
}

gls.left[9] = {
  LeftEnd = {
    provider = function()
      return "  "
    end,
    condition = condition.hide_in_width,
    highlight = { getBase16Color("base01"), getBase16Color("base00") },
  },
}

gls.left[10] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    condition = condition.hide_in_width,
    highlight = { getBase16Color("base08"), getBase16Color("base00") },
  },
}
gls.left[11] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    condition = condition.hide_in_width,
    highlight = { getBase16Color("base0A"), getBase16Color("base00") },
  },
}

gls.left[12] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    condition = condition.hide_in_width,
    highlight = { getBase16Color("base0C"), getBase16Color("base00") },
  },
}

gls.left[13] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    condition = condition.hide_in_width,
    highlight = { getBase16Color("base0D"), getBase16Color("base00") },
  },
}

gls.right[1] = {
  FileEncode = {
    provider = "FileEncode",
    condition = condition.hide_in_width,
    separator = " ",
    separator_highlight = {
      getBase16Color("base00"),
      getBase16Color("base01"),
    },
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

gls.right[2] = {
  FileFormatSeparator = {
    provider = function()
      return " "
    end,
    condition = condition.hide_in_width,
  },
}

gls.right[4] = {
  LineInfo = {
    provider = "LineColumn",
    icon = " ",
    highlight = { getBase16Color("base07"), getBase16Color("base0C"), "bold" },
  },
}
gls.right[5] = {
  PerCent = {
    provider = "LinePercent",
    separator = "|",
    separator_highlight = {
      getBase16Color("base00"),
      getBase16Color("base0C"),
    },
    highlight = { getBase16Color("base07"), getBase16Color("base0C"), "bold" },
  },
}

gls.right[6] = {
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
    highlight = { getBase16Color("base0D"), getBase16Color("base00"), "bold" },
  },
}

gls.short_line_left[2] = {
  SFileName = {
    provider = function()
      local short_list = require("galaxyline").short_line_list
      for _, v in ipairs(short_list) do
        if v == vim.bo.filetype then
          return ""
        end
      end
      local fgColor = getBase16Scheme().base07
      if vim.bo.modified then
        fgColor = getBase16Scheme().base08
      end
      highlight({
        name = "ShortGalaxyFileName",
        fgColor = fgColor,
        bgColor = getBase16Scheme().base00,
        gui = "bold",
      })
      return file_with_icons(true)
    end,
    condition = condition.buffer_not_empty,
    highlight = "ShortGalaxyFileName",
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = "BufferIcon",
    highlight = { getBase16Color("base07"), getBase16Color("base00"), "bold" },
  },
}
