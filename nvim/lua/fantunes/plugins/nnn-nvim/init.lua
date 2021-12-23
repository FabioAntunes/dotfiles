vim.cmd([[packadd nvim-web-devicons]])
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map("t", "<C-t>", ":NnnExplorer<CR>", mapOpts)
map("n", "<C-t>", ":NnnExplorer<CR>", mapOpts)

require("nnn").setup({
  replace_netrw = "explorer",
  auto_close = true,
  windownav = {
    left = "<C-h>",
    right = "<C-l>",
  },
})
