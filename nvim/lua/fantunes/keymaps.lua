vim.keymap.set("n", "\\", ":noh<CR>", { desc = "Clear highlights" })

vim.keymap.set(
  "n",
  "<leader>nf",
  ":Neotree reveal<cr>",
  { desc = "Open Neotree with the current file focused" }
)

vim.keymap.set("n", "<leader>sc", ":setlocal spell!<CR>", { desc = "Toggle spellcheck" })
vim.keymap.set("n", "<Leader>v", ":vsplit<CR>", { desc = "Split buffer vertically" })
vim.keymap.set("n", "<Leader>w", ":%s/\\s\\+$//<cr>:let @/=''<CR>", { desc = "Clean up trailing whitespace" })
vim.keymap.set("", "H", "^", { desc = "Move to the beginning of the file" })
vim.keymap.set("", "L", "$", { desc = "Move to the end of the file" })

-- Move between buffers faster!!!!
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the buffer on the left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the buffer on the bottom" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the buffer on the top" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the buffer on the right" })

-- http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
-- better jk normally but don't remap when it's called with a count
-- useful for visual line breaks, done by vim
vim.keymap.set("", "j", "(v:count == 0 ? 'gj' : 'j')", { silent = true, expr = true })
vim.keymap.set("", "k", "(v:count == 0 ? 'gk' : 'k')", { silent = true, expr = true })

-- Keep search matches in the middle of the window.
vim.keymap.set("n", "n", "nzz", {})
vim.keymap.set("n", "N", "Nzz", {})

-- make copy/paste from system clip easier
vim.keymap.set("v", "<Leader>8", '"*y', { desc = "Copy selected text to the clipboard" })
vim.keymap.set("v", "<Leader>9", '"*p', { desc = "Paste text from the clipboard" })
vim.keymap.set("n", "<Leader>8", '"*p', { desc = "Paste text from the clipboard" })

-- move blocks and visual blocks up and down
vim.keymap.set("n", "∆", ":m .+1<CR>==", {})
vim.keymap.set("n", "˚", ":m .-2<CR>==", {})
vim.keymap.set("i", "∆", "<ESC>:m .+1<CR>==gi", {})
vim.keymap.set("i", "˚", "<ESC>:m .-2<CR>==gi", {})
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", {})
