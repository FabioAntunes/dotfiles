let g:neoformat_enabled_json = ['jq', 'prettier']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
