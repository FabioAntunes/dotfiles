set -l options (fish_opt --short=f --long=force)
argparse $options -- $argv

set -gx fish_greeting
set keys 'fish' 'nvim' 'vim' 'iterm2' 'ssh' '.eslintrc' '.prettierrc'
set paths ~/.config/fish ~/.config/nvim ~/.vim ~/Library/Preferences/ ~/.ssh ~/.eslintrc ~/.prettierrc
set dir (cd (dirname (status -f)); and pwd)
set -e symlinks
set symlinks
set symlinksError
set backups
set hasForce 0

function create_symlink
  if test $isForce -ge 1
    ln -Fs $argv[1] $argv[2]
  else
    ln -s $argv[1] $argv[2]
  end
  if test $status -eq 0
    set symlinks $symlinks $argv[2]
  else
    set symlinksError $symlinksError $argv[2]
  end
end

function iterate
  set src_path $argv[1]
  set dist_path $argv[2]

  # create dist dir if it doesn't exist
  mkdir -p $dist_path

  set files (ls $src_path)
  for file in $files
    set src_file (string join '' $src_path '/' $file)
    set dist_file ( string join '' $dist_path '/' $file )
    if string match -q -- "*.vim/init.vim" $dist_file
      set dist_file ( string join '' $dist_path '/vimrc' )
    end

    if test -d $src_file; and test $file = 'config'
      continue
    end


    if test -d $src_file
      iterate $src_file $dist_file
    else if test -e $dist_file; and not test -L $dist_file
      set backup_name (string join '' $dist_file '_backup_' (random))
      mv $dist_file $backup_name
      if test $status -eq 0
        set backups $backups (string join ' ' $dist_file ' ➡️  ' $backup_name)
        create_symlink $src_file $dist_file
      end
    else if not test -L $dist_file; and not test -d $src_file; or test -L $dist_file; and test $isForce -ge 1
      create_symlink $src_file $dist_file
    end
  end
end

function install_fisherman
  curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
  # install fisher dependencies
  fisher install
end

function install_node_packages
  npm i -g eslint stylelint tern prettier
end

function install_vim_plug
  set plug_url https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs $plug_url
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs $plug_url
  # install Plugins for vim and neovim
  vim +PlugInstall +qall
  nvim +PlugInstall +qall
end

if test -n "$_flag_f"
  set isForce 1
end

for key in $keys
  if set -l index (contains -i -- $key $keys)
    set src_dir ( string join '' $dir '/' $key )
    iterate $src_dir $paths[$index]
  end
end


if test (count $symlinks) -ge 1
  echo -e '\nSymlinks created successfully:'
  for sym in $symlinks
    printf '  %s\n' $sym
  end
end

if test (count $backups) -ge 1
  echo -e '\nBackup folders created:'
  for backup  in $backups
    printf '  %s\n' $backup
  end
  echo -e '\n\n\n'
end

install_fisherman
install_vim_plug
install_node_packages
