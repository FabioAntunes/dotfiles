#!/bin/bash
os="$(uname | tr '[:upper:]' '[:lower:]')"

if [ "$GITHUB_ACTIONS" = "true" ]; then
  # osx on Github actions has node installed already
  command -v npm > /dev/null && npm config delete prefix
  # we need to pull our submodules
  git submodule update --recursive --remote
fi

make_dirs () {
  mkdir -p $HOME/.local/share/nvim/undodir
  mkdir -p $HOME/.vim/undodir
  mkdir -p $HOME/go
  mkdir -p $HOME/playground
  mkdir -p $HOME/work
}

config_git () {
  # although this file doesn't exist, yet, git doesn't seem to be bothered by that
  git config --global core.excludesfile $HOME/.gitignore_global
  git config --global alias.yolo "push origin head --no-verify --force-with-lease"
  git config --global init.defaultBranch main
  git config --global commit.gpgSign true
  git config --global user.signingkey 5FA46F5D9283889A5DEA82559A22C137957B5A47
  if [ "$GITHUB_ACTIONS" != "true" ]; then
    git remote set-url origin git@github.com:FabioAntunes/dotfiles.git
  fi

  # don't run if the terminal isn't interactive
  if [ -t 0 ] ; then
    echo "git user name:"
    read name
    echo "git email:"
    read email

    git config --global user.name $name
    git config --global user.email $email
  fi

  # set path for hooks in the dotfiles
  git config core.hooksPath hooks
  chmod +x hooks/post-merge
}

install_brew () {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

set_fish_shell () {
  fish_path=$(command -v fish)

  if command -v fish > /dev/null; then
    echo -e "\nSetting fish shell $fish_path"
    echo $fish_path | sudo tee -a /etc/shells
    chsh -s $fish_path

    # start init.fish
    eval "$fish_path init.fish"
  fi
}

install_nvm () {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
  # manually source nvm
  \. "$HOME/.nvm/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
}

config_git
install_nvm
install_powerfonts

if [ "$(uname)" == "Darwin" ]; then
  DevToolsSecurity -enable
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 2
  touch $HOME/.hushlogin
  install_brew
  brew install fish
else
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt-add-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get -y install fish vim-gtk python3 python3-dev python3-pip python3-setuptools neovim
fi

set_fish_shell
