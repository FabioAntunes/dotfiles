"
" ale
"

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['golangci-lint'],
\}
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_fix_on_save = 0
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0 " don't lint when we open a file
let g:ale_sign_error = '✖'
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
