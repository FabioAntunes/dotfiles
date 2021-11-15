"
" Auto commands
"

augroup fantunes
  autocmd!

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =

  " set json syntax to rc files
  autocmd BufNewFile,BufRead .babelrc,.eslintrc,.stylelintrc setlocal filetype=json


  " Don't add the comment prefix when I hit enter or o/O on a comment line.
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o

  " reset cursor position on files, if it's remembered
  " but don't do it for gitcommit file types
  autocmd BufReadPost * if &filetype != "gitcommit" && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
