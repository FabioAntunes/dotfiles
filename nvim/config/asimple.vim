" make comments italic https://stackoverflow.com/a/30937851/1449157
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic
highlight xmlAttrib cterm=italic





"------------------------------------------------------------------

"
" General settings
"

noremap \ ,




" filetype configs
filetype plugin indent on
runtime macros/matchit.vim

" http://robots.thoughtbot.com/faster-grepping-in-vim/
set grepprg=ag\ --nogroup\ --nocolor

" enable paste toggle, to keep original formatting
set pastetoggle=<F10>

" Save file using sudo, if we don't have permissions
cnoremap w!! w !sudo tee %
" vertical split help
cabbrev h vert h

:command! RefreshSyntax syntax sync fromstart

