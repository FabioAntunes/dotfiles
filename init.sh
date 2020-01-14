#!/bin/bash

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

  # don't run if the terminal isn't interactive
  if [[ $- == *i* ]]; then
    echo "git user name:"
    read username
    echo "git email:"
    read email

    git config --global user.name $username
    git config --global user.email $email
  fi

  # set path for hooks in the dotfiles
  git config core.hooksPath hooks
  chmod +x hooks/post-merge
}

install_brew () {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

install_yarn () {
  curl -o- -L https://yarnpkg.com/install.sh | bash
}

install_go_dependencies () {
  /usr/local/go/bin/go get golang.org/x/tools/cmd/godoc
  /usr/local/go/bin/go get golang.org/x/tools/cmd/goimports
  /usr/local/go/bin/go get -u github.com/go-delve/delve/cmd/dlv
  GO111MODULE=on go get golang.org/x/tools/gopls@latest
}

install_go () {
  if [ "$GITHUB_ACTIONS" = "true" ]; then
    # machines on Github actions already have golang installed
    install_go_dependencies
  else
    filename="$(curl 'https://golang.org/VERSION?m=text').$1-amd64.tar.gz"
    tar_archive="https://dl.google.com/go/$filename"
    echo "Dowloading go from: $tar_archive"
    wget $tar_archive && sudo tar -C /usr/local -xzf $filename
    if [ $? -eq 0 ]; then
      install_go_dependencies
    fi
  fi
}

install_from_brewfile () {
  brew_path=/usr/local/bin/brew
  $brew_path update --force
  echo "Installing brew dependencies, it will take 💩💩💩 loads of time. Time for a ☕️"
  $brew_path bundle --verbose --force --file=tilde/.Brewfile
}

set_fish_shell () {
  fish_path=$(command -v fish)

  if command -v fish > /dev/null; then
    echo -e "\nSetting fish shell $fish_path"
    echo $fish_path | sudo tee -a /etc/shells
    sudo chsh -s $fish_path

    # start init.fish
    eval "$fish_path init.fish"
  fi
}

install_powerfonts () {
  # create the folder if it doesn't exist
  mkdir -p $HOME/Library/Fonts
  # clone
  command git clone https://github.com/powerline/fonts.git --depth=1 && \
  # install
  cd fonts && \
  command bash install.sh && \
  # clean-up a bit
  cd ..; rm -rf fonts/
}

install_nvm () {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  # manually source nvm
  \. "$HOME/.nvm/nvm.sh"
  nvm install --lts
  nvm alias default 'lts/*'
}

make_dirs
config_git
install_nvm
install_yarn
install_powerfonts
if [ "$(uname)" == "Darwin" ]; then
  DevToolsSecurity -enable
  defaults write -g InitialKeyRepeat -int 10
  defaults write -g KeyRepeat -int 2
  touch $HOME/.hushlogin
  install_go "darwin"
  install_brew
  install_from_brewfile
else
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt-add-repository -y ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get -y install fish vim-gtk python3 python3-dev python3-pip python3-setuptools neovim
  install_go "linux"
fi

if command -v pip3 > /dev/null; then
  # install python support for nvim
  pip3 install wheel
  pip3 install --user pynvim
fi

set_fish_shell
