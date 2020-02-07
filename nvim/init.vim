set nocompatible
set encoding=utf8

" https://github.com/vim/vim/issues/3117
if !has('patch-8.1.201')
  silent! python3 1
endif

if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Syntax
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'styled-components/vim-styled-components', {'for': ['javascript', 'javascript.jsx']}
Plug 'othree/html5.vim'
Plug 'JulesWang/css.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-git'
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'branch': 'master', 'for': 'go' }
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
Plug 'vim-pandoc/vim-pandoc' " pandoc and markdown
Plug 'vim-pandoc/vim-pandoc-syntax'

" linter, fixer and lsp
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" enhanced quickfix window
Plug 'romainl/vim-qf'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Split and join lines
Plug 'AndrewRadev/splitjoin.vim'
" highlights matching tags
Plug 'Valloric/MatchTagAlways'
" Insert or delete multi-character pairs
Plug 'jiangmiao/auto-pairs'
" Asks to create directories in Vim when needed
Plug 'jordwalke/VimAutoMakeDirectory'
" fuzzy searching using fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" searches for local vimrc files and loads them, useful for extra config for a specfic project
Plug 'embear/vim-localvimrc'
" searches for the current selection, rather than the current word
Plug 'thinca/vim-visualstar'
" toggles comments
Plug 'tpope/vim-commentary'
" Provides easier unix commands like :Delete :Rename etc
Plug 'tpope/vim-eunuch'
" Git
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
" enhanced repeat of the last command
Plug 'tpope/vim-repeat'
" easily surround sutff with tags, brackets, quotes, etc
Plug 'tpope/vim-surround'

" tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'

" themes and status bar
Plug 'FabioAntunes/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Debug highlight issues
" Plug 'benknoble/vim-synstax'
call plug#end()


" load configs
runtime! config/*.vim

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source $HOME/.vimrc_background
endif

function! Dot_set_colours(bg, error_fg, warning_fg)
  exe 'hi ALEError guibg=' . a:bg . ' cterm=underline'
  exe 'hi ALEErrorSign guibg=' . a:bg . ' guifg=' . a:error_fg
  exe 'hi ALEWarning guibg=' . a:bg . ' cterm=underline'
  exe 'hi ALEWarningSign guibg=' . a:bg . ' guifg=' . a:warning_fg
  exe 'hi CocErrorSign guibg=' . a:bg . ' guifg=' . a:error_fg
  exe 'hi CocInfoSign guibg=' . a:bg . ' guifg=' . a:warning_fg
  exe 'hi CocWarningSign guibg=' . a:bg . ' guifg=' . a:warning_fg

endfunction

if exists('g:colors_name')
  let coloursettings = '$DOTFILES/nvim/config/colours/'.g:colors_name.'.vim'
  if !empty(glob(coloursettings))
    execute 'source '.coloursettings
  endif
endif
