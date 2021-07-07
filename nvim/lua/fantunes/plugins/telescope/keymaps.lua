local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map('n', '<leader>p', '<CMD>Telescope find_files<CR>', mapOpts)
map('n', '<leader>f', '<CMD>Telescope live_grep<CR>', mapOpts)
map('n', '<leader>b','<CMD>Telescope buffers<CR>', mapOpts)
map('n', '<leader>dot', ':lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)