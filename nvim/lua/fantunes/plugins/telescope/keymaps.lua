local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map("n", "<leader>p", "<CMD>Telescope find_files hidden=true<CR>", mapOpts)
map("t", "<leader>p", "<C-\\><C-N><CMD>vnew | Telescope find_files hidden=true<CR>", mapOpts)
map("n", "<leader>f", "<CMD>Telescope live_grep hidden=true<CR>", mapOpts)
map("t", "<leader>f", "<C-\\><C-N><CMD>vnew | Telescope live_grep hidden=true<CR>", mapOpts)
map("n", "<leader>b", "<CMD>Telescope buffers<CR>", mapOpts)
map("t", "<leader>b", "<C-\\><C-N><CMD>vnew | Telescope buffers<CR>", mapOpts)
map("n", "<leader>dot", '<CMD>lua require("fantunes.plugins.telescope").search_dotfiles()<CR>', mapOpts)
map(
  "t",
  "<leader>dot",
  '<C-\\><C-N><CMD>vnew | lua require("fantunes.plugins.telescope").search_dotfiles()<CR>',
  mapOpts
)
map("i", "<C-o><C-p>", '<CMD>lua require("fantunes.plugins.telescope").find_relative_path()<CR>', mapOpts)
