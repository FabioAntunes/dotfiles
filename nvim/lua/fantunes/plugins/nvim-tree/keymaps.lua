local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map('n', '<C-g>', '<CMD>NvimTreeToggle<CR>', mapOpts)
