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
\   'go': ['gofmt', 'goimports'],
\}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['golangci-lint'],
\   'typescript': ['tsserver', 'eslint'],
\}
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 1000
let g:ale_lint_on_enter = 0 " don't lint when we open a file
let g:ale_sign_error = '✖' " looks nicer than the default >>
let g:ale_sign_warning = '⚑'

" Shitty typescript stuff
let g:ale_typescript_tslint_use_global = 0
let g:ale_typescript_tslint_config_path = ''
let g:ale_linters_ignore = {'typescript': ['tslint']}
" end of shitty typescript stuff

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

" vim-javascript
let g:javascript_plugin_flow = 1

" vim-localvimrc
let g:localvimrc_persistent = 1

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

" vim-go
let g:go_fmt_autosave = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_gopls_enabled = 0

" pandoc
let g:pandoc#modules#disabled = ["folding"]
