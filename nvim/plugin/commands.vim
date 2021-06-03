"
" COMMANDS
"

" map uppercase and mixed case
:command! W w
:command! w!! w !sudo tee %
:command! WA wa
:command! Wa wa
:command! WQ wq
:command! Wq wq
:command! Q q
:command! QA qa
:command! Qa qa
:command! Up up
:command! UP up

function! Base_16_Func(colour)
  echom 'base16-'.a:colour
  execute 'silent !base16-'.trim(a:colour)
  source $HOME/.vimrc_background
  call Load_colour_settings()
endfunction

" Ignore the filenames when doing find all
" https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

:command! AleBufferToggleFixers let b:ale_fix_on_save = !get(b:, 'ale_fix_on_save', 1)
:command! -nargs=1 Base16 call Base_16_Func(<f-args>)
:command! ToggleJsConfigs call system('toggle-js-configs')
