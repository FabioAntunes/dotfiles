"
" Plugin settings
"

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme='base16'

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnips_javascript = {
  \ 'keyword-spacing': 'always',
  \ 'semi': 'never',
  \ 'space-before-function-paren': 'always',
  \ }

" MatchTagAlways, add javascript
let g:mta_filetypes = {
  \ 'javascript': 1,
  \ 'html' : 1,
  \ 'xhtml' : 1,
  \ 'xml' : 1
\}

" always show signcolumns
set signcolumn=yes

" ale
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'json': ['prettier'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 0 " don't lint when we open a file
let g:ale_sign_error = '✖' " looks nicer than the default >>
let g:ale_sign_warning = '⚑'

" coc.nvim
set cmdheight=2 " Better display for messages
set updatetime=300
set shortmess+=c " don't give ins-completion-menu messages.
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-tsserver',
\ 'coc-html',
\ 'coc-css',
\ ]

" Emmet remap
let g:user_emmet_leader_key='<C-Z>'

" vim-javascript
let g:javascript_plugin_flow = 1

" FZF.vim
let g:fzf_prefer_tmux = 1

" qf
let g:qf_window_bottom = 0
let g:qf_loclist_window_bottom = 0
let g:qf_auto_resize = 0
let g:qf_nowrap = 0

" splitjoin
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

" terraform
let g:terraform_align=1
let g:terraform_fmt_on_save=1

" pandoc
let g:pandoc#modules#disabled = ["folding"]
