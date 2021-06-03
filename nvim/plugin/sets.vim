"
" Colours and aspect
"

set termguicolors

" visual guideline for 120 characters
set colorcolumn=120

" enable mouse and scroll
set mouse=a

" enable relative numbers
set relativenumber
" set the current line its number, instead of 0
set number
" reduce cpu use and improve scroll speed
" by disabling any line highlight
set nocursorcolumn
set nocursorline

" always show signcolumns
set signcolumn=yes

" show tabs and trailing spaces
set list listchars=tab:»·,trail:·


" convert tabs to 2 spaces, indent 2 spaces as well
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent

" when searching with lower case only, ignore case
set ignorecase smartcase

" set spell check to english uk
set spelllang=en_gb
syntax spell toplevel

" No backup and swap files
set nobackup
set nowritebackup
set noswapfile

" highlight matches on search
set incsearch
set hlsearch

" Undo changes, even when file was closed
if !&diff
  if has('nvim')
    set undodir=~/.local/share/nvim/undodir
  else
    set undodir=~/.vim/undodir
  endif
  set undofile
endif

" make backspace behave normal
set backspace=indent,eol,start

" keep cursor centered on the screen, 8 lines above and below when possible
set scrolloff=8

" command line completions
set wildmenu
set wildmode=full

" placement of the new pane
set splitbelow
set splitright

if !has('nvim')
  " Stop Vim dying if there's massively long lines.
  set synmaxcol=128
  " go only back 256 lines when recreating syntax highlight
  " highlighting may be incorrect sometimes, but results are faster
  syntax sync minlines=256

  set lazyredraw

  " faster redraw
  set ttyfast

  " disable fold, I don't use and is very slow
  set foldmethod=manual
end
