"
"coc.nvim
"

set cmdheight=2 " Better display for messages
set updatetime=300
set shortmess+=c " don't give ins-completion-menu messages.
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ ]

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> <Leader>td <Plug>(coc-definition)
nmap <silent> <Leader>tr <Plug>(coc-references)
nmap <silent> <Leader>tn <Plug>(coc-rename)
nnoremap <silent> <Leader>cl  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <Leader>cd :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
