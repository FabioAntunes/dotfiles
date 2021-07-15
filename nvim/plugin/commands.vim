"
" COMMANDS
"
" map uppercase and mixed case
command! W :w
command! -nargs=0  WriteWithSudo :w !sudo tee % >/dev/null
command! WA :wa
command! Wa :wa
command! WQ :wq
command! Wq :wq
command! Q :q
command! QA :qa
command! Qa :qa
command! Up :up
command! UP :up

function! Base_16_Func(colour)
  echom 'base16-'.a:colour
  execute 'silent !base16-'.trim(a:colour)
  source $HOME/.vimrc_background
  call Load_colour_settings()
endfunction

command! AleBufferToggleFixers let b:ale_fix_on_save = !get(b:, 'ale_fix_on_save', 1)
command! -nargs=1 Base16 call Base_16_Func(<f-args>)
command! ToggleJsConfigs call system('toggle-js-configs')
