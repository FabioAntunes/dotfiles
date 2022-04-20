function __dot_brew_post_install --on-event fish_postexec
    if test (count $argv) -ge 1; and test (uname -s) = Darwin
        if string match -q -- "*brew install*" $argv; or string match -q -- "*brew untap*" $argv; or string match -q -- "*brew cask install*" $argv; or string match -q -- "*brew cask uninstall*" $argv; or string match -q -- "*brew remove*" $argv; or string match -q -- "*brew uninstall*" $argv

            brew bundle dump --force --global

            pushd $DOTFILES
            set files (git diff --name-only)

            if test (count $files) -eq 1; and set -l index (contains -i -- 'tilde/.Brewfile' $files)
                read -l -P 'Commit Brewfile? [y/N] ' confirm
                if test $confirm = Y -o $confirm = y -o $confirm = yes
                    set -q DOTFILES_MSG; or set DOTFILES_MSG 'Updated Brewfile :beer:'
                    git commit -am $DOTFILES_MSG
                    git push
                end
            end
            popd
        end
    end
end
