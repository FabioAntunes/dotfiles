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
" Javascript, Node and React
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript', 'javascript.jsx']}
Plug 'styled-components/vim-styled-components', {'for': ['javascript', 'javascript.jsx']}
" css and scss
Plug 'JulesWang/css.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss'] }
" html
Plug 'othree/html5.vim'
Plug 'tpope/vim-git'
Plug 'dag/vim-fish'
Plug 'elzr/vim-json'
" golang
Plug 'fatih/vim-go', { 'for': 'go' }
" terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }
" pandoc and markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" linter
Plug 'w0rp/ale'

" deoplete for nvim and vim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" tern
Plug 'ternjs/tern_for_vim', { 'do': 'npm install --global tern' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install --global tern' }

" Run async stuff
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" emmet support
Plug 'mattn/emmet-vim'
" enhanced quickfix window
Plug 'romainl/vim-qf'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Split and join lines
Plug 'AndrewRadev/splitjoin.vim'
" highlights matching tags
Plug 'Valloric/MatchTagAlways'
" Insert or delete brackets, parens, quotes in pair.
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

" shit aka typescript
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'

" themes and status bar
Plug 'FabioAntunes/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" load configs
runtime! config/*.vim

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

if exists('g:colors_name')
  let coloursettings = '~/playground/dotfiles/nvim/config/colours/'.g:colors_name.'.vim'
  if !empty(glob(coloursettings))
    execute 'source '.coloursettings
  endif
endif
