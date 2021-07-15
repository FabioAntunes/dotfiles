require("fantunes.plugins.telescope.keymaps")
require("fantunes.plugins.nvim-tree.keymaps")

local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

-- clear highlights by hitting /
map("n", "\\", ":noh<CR>", mapOpts)

-- new file in current directory
map("n", "<leader>nf", ":e <C-R>=expand('%:p:h') . '/' <CR>", mapOpts)

-- toggle spellcheck
map("n", "<leader>sc", ":setlocal spell!<CR>", mapOpts)

-- shortcut split vertically
map("n", "<Leader>v", ":vsplit<CR>", mapOpts)

-- clean up any trailing whitespace
map("n", "<Leader>w", ":%s/\\s\\+$//<cr>:let @/=''<CR>", mapOpts)

-- Move to the beginning/end of the line with H and L
map("", "H", "^", mapOpts)
map("", "L", "$", mapOpts)

-- Move between buffers faster!!!!
map("n", "<C-h>", "<C-w>h", mapOpts)
map("n", "<C-j>", "<C-w>j", mapOpts)
map("n", "<C-k>", "<C-w>k", mapOpts)
map("n", "<C-l>", "<C-w>l", mapOpts)

-- Keep search matches in the middle of the window.
map("n", "<C-l>", "<C-w>l", mapOpts)

-- http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
-- better jk normally but don't remap when it's called with a count
-- useful for visual line breaks, done by vim
map("", "j", "(v:count == 0 ? 'gj' : 'j')", { noremap = true, silent = true, expr = true })
map("", "k", "(v:count == 0 ? 'gk' : 'k')", { noremap = true, silent = true, expr = true })

-- Keep search matches in the middle of the window.
map("n", "n", "nzz", mapOpts)
map("n", "N", "Nzz", mapOpts)

-- make copy/paste from system clip easier
map("v", "<Leader>8 ", '"*y', mapOpts)
map("v", "<Leader>9 ", '"*p', mapOpts)
map("n", "<Leader>8 ", '"*p', mapOpts)

-- move blocks and visual blocks up and down
map("n", "∆", ":m .+1<CR>==", mapOpts)
map("n", "˚", ":m .-2<CR>==", mapOpts)
map("i", "∆", "<ESC>:m .+1<CR>==gi", mapOpts)
map("i", "˚", "<ESC>:m .-2<CR>==gi", mapOpts)
map("v", "∆", ":m '>+1<CR>gv=gv", mapOpts)
map("v", "˚", ":m '<-2<CR>gv=gv", mapOpts)
