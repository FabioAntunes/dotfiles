local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map("n", "<leader>tk", "<CMD>Telescope keymaps <CR>", mapOpts)
map("n", "<leader>td", "<CMD>Telescope diagnostics <CR>", mapOpts)
map("n", "<leader>p", "<CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("n", "<leader>p", "<CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("t", "<leader>p", "q <CR><CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("n", "<leader>f", "<CMD>Telescope live_grep hidden=true<CR>", mapOpts)
map("n", "<leader>wf", "<CMD>Telescope grep_string hidden=true<CR>", mapOpts)
map("t", "<leader>f", "q <CR><CMD>Telescope live_grep hidden=true<CR>", mapOpts)
map("n", "<leader>b", "<CMD>Telescope buffers<CR>", mapOpts)
map("t", "<leader>b", "q <CR><CMD>Telescope buffers<CR>", mapOpts)
map("n", "<leader>dot", '<CMD>lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)
map("t", "<leader>dot", 'q <CR><CMD>lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)
map("i", "<C-o><C-p>", '<CMD>lua require("fantunes.plugins.telescope").find_relative_path()<CR>', mapOpts)
