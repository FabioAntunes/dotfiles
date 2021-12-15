vim.cmd(
  [[
      augroup base16
        autocmd!
        autocmd ColorScheme * lua require('fantunes.plugins.base16.schemes').load()
      augroup END
    ]],
  false
)
