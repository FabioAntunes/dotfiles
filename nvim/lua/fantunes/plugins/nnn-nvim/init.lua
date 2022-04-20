vim.cmd([[packadd nvim-web-devicons]])
local map = vim.api.nvim_set_keymap
local mapOpts = { noremap = true }

map("n", "<leader>nn", ":NnnExplorer<CR>", mapOpts)

require("nnn").setup({
  explorer = {
    cmd = "nnn -H",
  },
  replace_netrw = "explorer",
  auto_close = true,
  windownav = {
    left = "<C-h>",
    right = "<C-l>",
  },
})
