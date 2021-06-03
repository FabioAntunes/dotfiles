"
" FZF.vim
"

" FZF.vim
let g:fzf_prefer_tmux = 1

nnoremap <Leader>p :Files<cr>
nnoremap <Leader>f :Ag<cr>
nnoremap <Leader>b :Buffers<cr>
nnoremap <Leader>m :Maps<cr>

imap <c-r> <plug>(fzf-maps-i)
xmap <c-r> <plug>(fzf-maps-x)
omap <c-r> <plug>(fzf-maps-o)


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
