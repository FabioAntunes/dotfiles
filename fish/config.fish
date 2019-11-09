# misc vars
set -gx DOTFILES (string replace /fish '' (dirname (readlink (status --current-filename))))
set -gx color_scheme 1

# theme configs
set -gx theme_display_k8s_namespace no
set -gx theme_display_git_untracked yes
set -gx theme_display_user no
set -gx theme_display_git yes
set -gx theme_color_scheme terminal
set -gx theme_display_date no
set -gx theme_display_cmd_duration no
set -gx IS_OSX 0

# use ag to pipe the results to fzf, ag respects the gitignore
set -gx FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
if test (uname -s) = 'Darwin'
  set -gx IS_OSX 1
  set -gx PATH /usr/local/homebrew/bin $PATH
end
if test -d ~/platform-tools
  set -gx PATH ~/platform-tools $PATH
end

set -gx PATH $GOPATH/bin $PATH

# add aws completions
type -q aws_completer;\
  and complete --command aws --no-files --arguments\
  '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


function postexec --on-event fish_postexec
  if test (count $argv) -ge 1; and test $IS_OSX -eq 1
    if string match -q -- "*brew install*" $argv;\
      or string match -q -- "*brew cask install*" $argv;\
      or string match -q -- "*brew remove*" $argv;\
      or string match -q -- "*brew uninstall*" $argv;

      brew bundle dump --force --global

      pushd $DOTFILES
      set files (git diff --name-only)

      if test (count $files) -eq 1; and set -l index (contains -i -- 'tilde/.Brewfile' $files)
        read -l -P 'Commit Brewfile? [y/N] ' confirm
        if test $confirm = 'Y' -o $confirm = 'y' -o $confirm = 'yes';
          set -q DOTFILES_MSG; or set DOTFILES_MSG 'Updated Brewfile :beer:'
          git commit -am $DOTFILES_MSG
          git push
        end
      end
      popd
    end
  end
end

if status --is-interactive
  set BASE16_SHELL "$DOTFILES/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]; source '$HOME/google-cloud-sdk/path.fish.inc'; end
