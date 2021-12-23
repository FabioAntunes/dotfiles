local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map("n", "<leader>p", "<CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("t", "<leader>p", "<CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("n", "<leader>f", "<CMD>Telescope live_grep hidden=true<CR>", mapOpts)
map("t", "<leader>f", "<CMD>Telescope live_grep hidden=true<CR>", mapOpts)
map("n", "<leader>b", "<CMD>Telescope buffers<CR>", mapOpts)
map("t", "<leader>b", "<CMD>Telescope buffers<CR>", mapOpts)
map("n", "<leader>dot", '<CMD>lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)
map("t", "<leader>dot", '<CMD>lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)
map("i", "<C-o><C-p>", '<CMD>lua require("fantunes.plugins.telescope").find_relative_path()<CR>', mapOpts)
