vim.cmd([[packadd nvim-web-devicons]])
local scheme = require("fantunes.plugins.base16.schemes").getBase16Scheme()

require("nvim-web-devicons").setup({
  override = {
    netrw = {
      icon = "פּ",
      color = scheme.base07,
      name = "Netrw",
    },
    fish = {
      icon = "",
      color = scheme.base0C,
      name = "Fish",
    },
    terraform = {
      icon = "",
      color = scheme.base0E,
      name = "Terraform",
    },
    tf = {
      icon = "",
      color = scheme.base0E,
      name = "Terraform",
    },
    hcl = {
      icon = "",
      color = scheme.base0E,
      name = "HCL",
    },
  },
})

local components = {
  active = { {}, {} },
  inactive = { {}, {} },
}

local get_insert_component = function(setup_components)
  return function(index, componentsTable)
    for _, component in pairs(componentsTable) do
      table.insert(setup_components[index], component)
    end
  end
end

local insert = get_insert_component(components.active)
local insert_ina = get_insert_component(components.inactive)

-- vi_mode provider --
local vi_sep = {
  {
    str = " ",
    hl = function()
      return {
        bg = require("feline.providers.vi_mode").get_mode_color(),
      }
    end,
  },
}
local vi_hl = function()
  return {
    name = require("feline.providers.vi_mode").get_mode_highlight_name(),
    bg = require("feline.providers.vi_mode").get_mode_color(),
    fg = scheme.base07,
    style = "bold",
  }
end

insert(1, {
  {
    provider = "vi_mode",

    hl = vi_hl,
    left_sep = vi_sep,
    right_sep = vi_sep,
    icon = "",
    priority = 3,
    short_provider = {
      name = "short_vi_mode",
      hl = vi_hl,
    },
  },
})

-- file_info provider --
local file_info_provider = {
  {
    provider = {
      name = "file_info",
      opts = {
        type = "unique",
        file_modified_icon = "﬒",
        file_readonly_icon = " ",
      },
    },
    hl = function()
      local fg = scheme.base07
      if vim.bo.modified then
        fg = scheme.base08
      end
      return {
        fg = fg,
        bg = scheme.base00,
        style = "bold",
      }
    end,
    priority = 2,
    left_sep = " ",
    right_sep = " ",
    enabled = function()
      if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
        return true
      end
      return false
    end,
  },
}
insert(1, file_info_provider)

-- git provider --
local git_condition = function()
  return require("feline.providers.git").git_info_exists()
end

local git_sep = {
  str = " ",
  hl = {
    bg = scheme.base01,
  },
}

insert(1, {
  {
    provider = "",
    hl = {
      fg = scheme.base00,
      bg = scheme.base01,
    },
    enabled = git_condition,
    truncate_hide = true,
    priority = -1,
  },
  {
    provider = "git_branch",
    icon = "  ",
    hl = {
      fg = scheme.base07,
      bg = scheme.base01,
      style = "bold",
    },
    right_sep = git_sep,
    enabled = git_condition,
    truncate_hide = true,
    priority = 1,
  },
  {
    provider = "git_diff_added",
    icon = " ",
    hl = {
      fg = scheme.base0B,
      bg = scheme.base01,
    },
    right_sep = git_sep,
    enabled = git_condition,
    truncate_hide = true,
    priority = 0,
  },
  {
    provider = "git_diff_changed",
    icon = " ",
    hl = {
      fg = scheme.base0A,
      bg = scheme.base01,
    },
    right_sep = git_sep,
    enabled = git_condition,
    truncate_hide = true,
    priority = 0,
  },
  {
    provider = "git_diff_removed",
    icon = " ",
    hl = {
      fg = scheme.base08,
      bg = scheme.base01,
    },
    right_sep = git_sep,
    enabled = git_condition,
    truncate_hide = 0,
  },
  {
    provider = " ",
    hl = {
      bg = scheme.base00,
      fg = scheme.base01,
    },
    enabled = git_condition,
    truncate_hide = true,
    priority = -1,
  },
})

-- lsp --
insert(1, {
  {
    provider = "diagnostic_errors",
    icon = "  ",
    hl = {
      fg = scheme.base08,
      bg = scheme.base00,
      style = "bold",
    },
    truncate_hide = true,
    priority = -1,
  },
  {
    provider = "diagnostic_warnings",
    icon = "  ",
    hl = {
      fg = scheme.base0A,
      bg = scheme.base00,
      style = "bold",
    },
    truncate_hide = true,
    priority = -1,
  },
  {
    provider = "diagnostic_hints",
    icon = "  ",
    hl = {
      fg = scheme.base0C,
      bg = scheme.base00,
      style = "bold",
    },
    truncate_hide = true,
    priority = -1,
  },
  {
    provider = "diagnostic_info",
    icon = "  ",
    hl = {
      fg = scheme.base0D,
      bg = scheme.base00,
      style = "bold",
    },
    truncate_hide = true,
    priority = -1,
  },
})

-- file type --
insert(2, {
  {
    provider = "file_encoding",
    hl = {
      fg = scheme.base0A,
      bg = scheme.base01,
      style = "bold",
    },
    left_sep = {
      str = "  ",
      hl = {
        fg = scheme.base00,
        bg = scheme.base01,
      },
    },
    right_sep = {
      str = " ",
      hl = {
        bg = scheme.base01,
      },
    },
    truncate_hide = true,
    priority = -1,
  },
})

-- position --
insert(2, {
  {
    provider = "position",
    hl = {
      fg = scheme.base07,
      bg = scheme.base0C,
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        bg = scheme.base0C,
      },
    },
    right_sep = {
      str = "vertical_bar_thin",
      hl = {
        fg = scheme.base00,
        bg = scheme.base0C,
      },
    },
    truncate_hide = true,
    priority = 1,
  },
  {
    provider = "line_percentage",
    hl = {
      fg = scheme.base07,
      bg = scheme.base0C,
      style = "bold",
    },
    left_sep = {
      str = " ",
      hl = {
        bg = scheme.base0C,
      },
    },
    right_sep = {
      str = " ",
      hl = {
        bg = scheme.base0C,
      },
    },
  },
})

-- Inactive line --
insert_ina(1, file_info_provider)
insert_ina(2, {
  {
    provider = "file_type",
    truncate_hide = true,
    hl = {
      fg = scheme.base0C,
      bg = scheme.base00,
      style = "bold",
    },
  },
})

require("feline").setup({
  components = components,
  vi_mode_colors = {
    ["NORMAL"] = scheme.base0D,
    ["INSERT"] = scheme.base0B,
    ["VISUAL"] = scheme.base0C,
    ["BLOCK"] = scheme.base0C,
    ["REPLACE"] = scheme.base09,
    ["V-REPLACE"] = scheme.base09,
    ["COMMAND"] = scheme.base0A,
  },
  theme = {
    fg = scheme.base07,
    bg = scheme.base00,
    black = scheme.base01,
    cyan = scheme.base0C,
    green = scheme.base0B,
    magenta = scheme.base0E,
    orange = scheme.base09,
    red = scheme.base08,
    white = scheme.base07,
    yellow = scheme.base0A,
  },
  custom_providers = {
    short_vi_mode = function()
      local vi_mode = require("feline.providers.vi_mode").get_vim_mode()
      return string.upper(string.sub(vi_mode, 1, 1))
    end,
  },
})
