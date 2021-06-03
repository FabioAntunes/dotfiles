"
" ale
"

let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\   'go': ['gofmt', 'goimports'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['golangci-lint'],
\}
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 0 " don't lint when we open a file
let g:ale_sign_error = '✖' " looks nicer than the default >>
let g:ale_sign_warning = '⚑'

nmap <silent> [a <Plug>(ale_previous_wrap)
nmap <silent> ]a <Plug>(ale_next_wrap)
noremap <Leader>al :call ALEListToggle()<CR>

function! ALEListToggle()
  if get(getloclist(0, {'winid':0}), 'winid', 0)
    lclose
  else
    lopen
  endif
endfunction
