"
" Plugins Keymaps
"

" ale
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

"coc.nvim
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


" autoclose tag with omnifunc
iabbrev </ </<C-X><C-O>

" splitjoin
nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>s :SplitjoinSplit<cr>

" FZF.vim
nnoremap <Leader>p :Files<cr>
nnoremap <Leader>f :Ag<cr>
nnoremap <Leader>b :Buffers<cr>

nmap <Leader>r <plug>(fzf-maps-n)
imap <c-r> <plug>(fzf-maps-i)
xmap <c-r> <plug>(fzf-maps-x)
omap <c-r> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Pear tree add spaces
imap <Space> <Plug>(PearTreeSpace)

" using fzf to search for a file and generate a relative path
" relative to the current buffer
function! s:make_path(path)
  let l:currentFile = expand('%:p:h')
  let l:filePath = fnamemodify(join(a:path), ":p")

  " my implementation to generate relative paths, a golang binary
  " check if it exists, if not we default to perl
  if executable("rel-path")
    let l:relPath = system("rel-path " . l:filePath . " " . l:currentFile)
  else
    let l:relPath = system("perl -e 'use File::Spec; print File::Spec->abs2rel(@ARGV) . \"\n\"' " . l:filePath . " " . l:currentFile)
    if l:relPath !~ '^\.\.\/'
      let l:relPath = \"./" . l:relPath
    endif
  endif

  " strip extensions from the file, if it's tsx? jsx?
  " or strip the entire name if it's an "index.jsx?" or "index.tsx?"
  return substitute(l:relPath, '\(\(\/index\)\?\(\.tsx\?\|\.jsx\?\)\)\?\n\+$', '', '')
endfunction

inoremap <expr> <c-o><c-p> fzf#complete(fzf#wrap({
  \ 'source':  'ag -g ""',
  \ 'reducer': function('<sid>make_path')}))
