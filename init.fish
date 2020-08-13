set -gx fish_greeting
set current_dir (dirname (realpath (status --current-filename)))

#create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a me cd $HOME/playground
abbr -a dot cd $current_dir
abbr -a work cd $HOME/work

function add_to_path
  if not contains $argv[1] $fish_user_paths
    set -U fish_user_paths $argv[1] $fish_user_paths
  end
end

#modify $PATH
add_to_path /usr/local/go/bin
add_to_path /usr/local/go/bin
add_to_path $HOME/.yarn/bin

if test (uname -s) = 'Darwin'
  add_to_path /usr/local/homebrew/bin
end

source fish/functions/yolo.fish
yolo
