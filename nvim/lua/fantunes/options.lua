--
-- Options
--

vim.opt.termguicolors = true

-- visual guideline for 120 characters
vim.opt.colorcolumn = "120"
-- enable relative numbers
vim.opt.relativenumber = true
-- set the current line its number, instead of 0
vim.opt.number = true
-- enable mouse and scroll
vim.opt.mouse = "a"

-- show signcolumns
vim.opt.signcolumn = "yes"

-- show tabs and trailing spaces
vim.opt.signcolumn = "yes"

-- indenting
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.softtabstop = 2
-- convert tabs to 2 spaces, indent 2 spaces as well
vim.opt.list = true
vim.opt.listchars = { trail = "·", tab = "»·" }

-- when searching with lower case only, ignore case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- No backup and swap files
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undodir")
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

-- make backspace behave normal
vim.opt.backspace = { "indent", "eol", "start" }

-- keep cursor centered on the screen, 8 lines above and below when possible
vim.opt.scrolloff = 8

-- placement of the new pane
vim.opt.splitbelow = true
vim.opt.splitright = true

-- disable native plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
