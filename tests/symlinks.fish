###############################################
# tests symlinks created by the yolo function #
###############################################
set -l dir (string replace /tests '' (cd (dirname (status -f)); and pwd))


function test_symlink
    set -l filename $argv[1]
    set -l basepath $argv[2]
    set -l dot_basepath $argv[3]
    set -q argv[4]; and set -l dot_filename $argv[4]; or set -l dot_filename $filename


    @test "$filename is a symlink" -L $basepath/$filename
    @test "$filename has the correct path" (realpath $basepath/$filename) = $dot_basepath/$dot_filename
end

##########################
# Test .config/fish/
##########################
set -l basepath $HOME/.config/fish
set -l dot_basepath $dir/fish

test_symlink fish_plugins $basepath $dot_basepath
test_symlink config.fish $basepath $dot_basepath

##########################
# Test .config/fish/functions
##########################
set -l basepath $HOME/.config/fish/functions
set -l dot_basepath $dir/fish/functions

test_symlink root.fish $basepath $dot_basepath
test_symlink toggle-js-configs.fish $basepath $dot_basepath
test_symlink yolo.fish $basepath $dot_basepath

##########################
# Test .config/fish/completions
##########################
set -l basepath $HOME/.config/fish/completions
set -l dot_basepath $dir/fish/completions

test_symlink yolo.fish $basepath $dot_basepath
test_symlink aws-okta.fish $basepath $dot_basepath


##########################
# Test .vim/vimrc
# Test .config/nvim/init.vim
##########################
set -l nvim_path $HOME/.config/nvim
set -l basepath $HOME/.vim
set -l n_basepath $nvim_path

test_symlink vimrc $basepath $dir/vim init.vim
test_symlink init.lua $n_basepath $dir/nvim

##########################
# Test .vim/UltiSnips
# Test .config/nvim/UltiSnips
##########################
set -l basepath $HOME/.vim/UltiSnips
set -l nvim_basepath $nvim_path/UltiSnips

test_symlink javascript.snippets $basepath $dir/vim/UltiSnips
test_symlink javascript.snippets $nvim_basepath $dir/nvim/UltiSnips

##########################
# Test .vim/after/ftplugin
# Test .config/nvim/after/ftplugin
##########################
set -l basepath $HOME/.vim/after/ftplugin
set -l nvim_basepath $nvim_path/after/ftplugin

test_symlink javascript.vim $basepath $dir/vim/after/ftplugin
test_symlink markdown.vim $basepath $dir/vim/after/ftplugin

##########################
# Test .vim/config/colours
# Test .config/nvim/config/colours
##########################
set -l basepath $HOME/.vim/config/colours
set -l dot_basepath $dir/vim/config/colours

test_symlink base16-nord.vim $basepath $dot_basepath
test_symlink base16-oceanicnext.vim $basepath $dot_basepath
test_symlink base16-solarflare-light.vim $basepath $dot_basepath
test_symlink base16-solarflare.vim $basepath $dot_basepath

##########################
# Test .vim/config/
# Test .config/nvim/config/
##########################
set -l basepath $HOME/.vim/config
set -l dot_basepath $dir/vim/config

test_symlink asimple.vim $basepath $dot_basepath
test_symlink autocmds.vim $basepath $dot_basepath
test_symlink commands.vim $basepath $dot_basepath
test_symlink plugins-keymaps.vim $basepath $dot_basepath
test_symlink plugins.vim $basepath $dot_basepath
test_symlink visuals.vim $basepath $dot_basepath

##########################
# Test ~/
##########################
set -l basepath $HOME
set -l dot_basepath $dir/tilde

test_symlink .Brewfile $basepath $dot_basepath
test_symlink .eslintrc.js $basepath $dot_basepath
test_symlink .gitignore_global $basepath $dot_basepath
test_symlink .prettierrc.js $basepath $dot_basepath
test_symlink .stylelintrc.json $basepath $dot_basepath

##########################
# Test .config/yamllint
##########################
set -l basepath $HOME/.config/yamllint
set -l dot_basepath $dir/yamllint

test_symlink config $basepath $dot_basepath

##########################
# Test .ssh
##########################
set -l basepath $HOME/.ssh
set -l dot_basepath $dir/ssh

test_symlink config $basepath $dot_basepath

##########################
# Test iterm2
##########################
if test (uname) = Darwin
    set -l basepath $HOME/Library/Application\ Support/iTerm2/DynamicProfiles
    set -l dot_basepath $dir/iterm2

    test_symlink amaster.json $basepath $dot_basepath
end
