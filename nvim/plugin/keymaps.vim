"
" Keymaps
"

" clear highlights by hitting /
nnoremap \ :noh<CR>

" new file in current directory
nnoremap <Leader>nf :e <C-R>=expand("%:p:h") . "/" <CR>

" toggle spellcheck
nnoremap <Leader>sc :setlocal spell!<CR>

" when pasting, set paste mode first, then paste, then set paste mode off
inoremap <C-v> <F10><C-r>+<F10>

" shortcut split vertically
nnoremap <Leader>v :vsplit<CR>

" clean up any trailing whitespace
nnoremap <Leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" stolen from https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Move to the beginning/end of the line with H and L
noremap H ^
noremap L $

" http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
" better jk normally but don't remap when it's called with a count
" useful for visual line breaks, done by vim
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" make copy/paste from system clip easier
vnoremap <Leader>8 "*y
vnoremap <Leader>9 "*p
nnoremap <Leader>8 "*p

" move blocks and visual blocks up and down
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv
