local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto commands
augroup("fantunes", { clear = true })
autocmd("VimResized", {
  group = "fantunes",
  pattern = "*",
  command = "wincmd =",
  desc = "Automatically rebalance windows on Vim resize",
})

autocmd("FileType", {
  group = "fantunes",
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("r")
    vim.opt_local.formatoptions:remove("o")
  end,
  desc = "Don't add comment prefix when hitting enter or o/O on a comment line",
})

autocmd("BufReadPost", {
  group = "fantunes",
  pattern = "*",
  callback = function()
    -- Reset cursor position on files, if it's remembered, but not for gitcommit file types
    if vim.bo.filetype ~= "gitcommit" and vim.fn.line("'\"'") > 1 and vim.fn.line("'\"'") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
  desc = "Reset cursor position on files",
})

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = "fantunes",
  pattern = "*",
  callback = function()
    if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
  desc = "Set relative number when not in insert mode and number is on",
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = "fantunes",
  pattern = "*",
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
  desc = "Unset relative number when number is on",
})
