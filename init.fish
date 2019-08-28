set -gx fish_greeting
set current_dir (dirname (readlink (status --current-filename)))
# create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a me cd $HOME/playground
abbr -a dot cd $current_dir/dotfiles
abbr -a work cd $HOME/work
source fish/functions/yolo.fish
yolo
