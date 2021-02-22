########################
### fish shell setup ###
########################
set -gx fish_greeting
set current_dir (dirname (realpath (status --current-filename)))

#create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a me cd $HOME/playground
abbr -a dot cd $current_dir
abbr -a work cd $HOME/work

#################
### make dirs ###
#################
mkdir -p $HOME/.local/share/nvim/undodir
mkdir -p $HOME/.vim/undodir
mkdir -p $HOME/go
mkdir -p $HOME/playground
mkdir -p $HOME/work

####################
### install yarn ###
###################
curl -o- -L https://yarnpkg.com/install.sh | bash

######################
### install awscli ###
######################
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
rm AWSCLIV2.pkg

###################
### install fzf ###
###################
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all --no-bash --no-zsh

####################
### modify $PATH ###
####################
function add_to_path
  if not contains $argv[1] $fish_user_paths
    set -U fish_user_paths $argv[1] $fish_user_paths
  end
end

if test (uname -s) = 'Darwin'
  add_to_path /usr/local/homebrew/bin
end
add_to_path /usr/local/go/bin
add_to_path $HOME/.yarn/bin

############
### YOLO ###
############
source fish/functions/yolo.fish
yolo

fish ./post-install.fish


