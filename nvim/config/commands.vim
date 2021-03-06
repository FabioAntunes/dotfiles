"
" COMMANDS
"

function! Base_16_Func(colour)
  echom 'base16-'.a:colour
  execute 'silent !base16-'.trim(a:colour)
  source $HOME/.vimrc_background
  call Load_colour_settings()
endfunction

" Ignore the filenames when doing find all
" https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Edit vim configs
:command! DotAutoCmds vsplit $DOTFILES/nvim/config/autocmds.vim
:command! DotCommands vsplit $DOTFILES/nvim/config/commands.vim
:command! DotKeymaps vsplit $DOTFILES/nvim/config/keymaps.vim
:command! DotPlugins vsplit $DOTFILES/nvim/config/plugins.vim
:command! DotSettings vsplit $DOTFILES/nvim/config/settings.vim
:command! DotVisuals vsplit $DOTFILES/nvim/config/visuals.vim

:command! AleBufferToggleFixers let b:ale_fix_on_save = !get(b:, 'ale_fix_on_save', 1)
:command! -nargs=1 Base16 call Base_16_Func(<f-args>)
:command! ToggleJsConfigs call system('toggle-js-configs')
