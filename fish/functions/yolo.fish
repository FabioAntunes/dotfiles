function yolo -d "All your dotfiles are belong to us"
    set -gx flags $argv
    set -l options (fish_opt --short=f --long=force)
    set -l options $options (fish_opt --short=n --long=node)
    set -l options $options (fish_opt --short=m --long=fisherman)
    set -l options $options (fish_opt --short=s --long=symlink)
    set -l options $options (fish_opt --short=v --long=vimplug)
    set -l options $options (fish_opt --short=c --long=copy)
    argparse $options -- $argv

    set -gx functions_list $_flag_n $_flag_m $_flag_s $_flag_v $_flag_c
    # the order of the keys must map to the orther of the $paths variable
    set -gx keys fish nvim vim iterm2 ssh gnupg tilde config
    # sets paths multiple times so it breaks nicely in multiple lines
    set -gx paths ~/.config/fish ~/.config/nvim ~/.vim
    set -a paths ~/Library/Application\ Support/iTerm2/DynamicProfiles
    set -a paths ~/.ssh ~/.gnupg
    # this maps to the tilde key/folder
    set -a paths ~
    set -a paths ~/.config
    set -e symlinks
    set -gx symlinks
    set -gx symlinks_error
    set -gx backups
    set -gx has_force 0

    if test -L (status -f)
        set -gx dir (string replace /fish/functions '' (dirname (realpath (status -f))))
    else
        set -gx dir (pwd)
    end

    if set -q _flag_f
        set has_force 1
    end

    function install_fisher
        curl -sL git.io/fisher | source && fisher update
    end

    function install_node_packages
        npm i -g eslint stylelint prettier @fsouza/prettierd eslint-config-prettier \
            eslint-plugin-react stylelint-config-recommended eslint_d \
            typescript typescript-language-server vscode-langservers-extracted \
            yaml-language-server
    end

    function install_vim_plug
        set plug_url https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs $plug_url

        #install Plugins for vim and neovim
        if status --is-interactive; and [ "$GITHUB_ACTIONS" != true ]
            vim +PlugInstall +qall
        end
    end

    function copy_files
        echo -e "\nCopying files"
        set origin $dir/consolas-powerline/*.ttf
        set dest $HOME/Library/Fonts/
        mkdir -p $dest

        if test $has_force -ge 1
            cp -f $origin $dest
        else
            cp $origin $dest
        end

        [ $status -eq 0 ]; and echo -e "\nFiles copied successfully: $origin"; or echo -e "\nNo files copied"
    end

    function create_symlink
        if test $has_force -ge 1
            ln -Fs $argv[1] $argv[2]
        else
            ln -s $argv[1] $argv[2]
        end
        if test $status -eq 0
            set symlinks $symlinks $argv[2]
        else
            set symlinks_error $symlinksError $argv[2]
        end
    end

    function iterate
        set src_path $argv[1]
        set dist_path $argv[2]

        # create dist dir if it doesn't exist
        mkdir -p $dist_path

        set files (ls -A $src_path)
        for file in $files
            set src_file $src_path'/'$file
            set dist_file $dist_path'/'$file
            if string match -q -- "*.vim/init.vim" $dist_file
                set dist_file $dist_path'/vimrc'
            end

            if string match -q -- '*noop*' $file
                continue
            end


            if test -d $src_file
                iterate $src_file $dist_file
            else if test -e $dist_file
                and not test -L $dist_file
                set backup_name $dist_file'_backup_'(random)
                mv $dist_file $backup_name
                if test $status -eq 0
                    set backups $backups "$dist_file ➡️  $backup_name"
                    create_symlink $src_file $dist_file
                end
            else if test -L $dist_file
                and test $has_force -ge 1
                or not test -e $dist_file
                create_symlink $src_file $dist_file
            end
        end
    end



    function create_symlinks
        for key in $keys
            if set -l index (contains -i -- $key $keys)
                set src_dir $dir'/'$key
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
            for backup in $backups
                printf '  %s\n' $backup
            end
            echo -e '\n\n\n'
        end

        if test (count $symlinks_error) -ge 1
            echo -e '\Failed Symlinks:'
            for sym_error in $symlinks_error
                printf '  %s\n' $sym_error
            end
            echo -e '\n\n\n'
        end
    end

    if test -n "$_flag_s"
        or not set -q functions_list[1]
        create_symlinks
    end

    if test -n "$_flag_m"
        or not set -q functions_list[1]
        install_fisher
    end

    if test -n "$_flag_v"
        or not set -q functions_list[1]
        install_vim_plug
    end

    if test -n "$_flag_c"
        or not set -q functions_list[1]
        copy_files
    end

    if test -n "$_flag_n"
        or not set -q functions_list[1]
        install_node_packages
    end
end
