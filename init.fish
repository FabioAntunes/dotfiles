set -gx os (uname | tr '[:upper:]' '[:lower:]')
############################
### source yolo function ###
############################
source fish/functions/yolo.fish

########################
### fish shell setup ###
########################
set -gx fish_greeting
set current_dir (dirname (realpath (status --current-filename)))

#create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a k kubectl
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

fish_add_path /usr/local/go/bin
fish_add_path $HOME/.yarn/bin

#######################
### create symlinks ###
#######################
yolo -s

####################
### brew bundle  ###
####################
if [ (uname) = Darwin ]
    brew update
    echo "Installing brew dependencies, it will take 💩💩💩 loads of time. Time for a ☕️"
    brew bundle --global --verbose
end

####################
### post install ###
####################
if command -v pip3 >/dev/null
    # install python support for nvim
    pip3 install wheel
    pip3 install --user pynvim
end

function tar_archive
    set url $argv[1]
    set path $argv[2]
    set filename $argv[3]

    echo "Dowloading archive from: $url"
    echo "Installing $filename in $path"

    wget $url && sudo tar -C $path -xzf $filename
end

function install_go_dependencies
    go get golang.org/x/tools/cmd/godoc
    go get golang.org/x/tools/cmd/goimports
    go get -u github.com/go-delve/delve/cmd/dlv
    GO111MODULE=on go get golang.org/x/tools/gopls@latest
end

if [ "$GITHUB_ACTIONS" = true ]
    # machines on Github actions already have golang installed
    install_go_dependencies
else
    set version (curl 'https://golang.org/VERSION?m=text')
    set filename "$version.$os-amd64.tar.gz"
    set golang_path /usr/local
    set url "https://dl.google.com/go/$filename"

    tar_archive $url $golang_path $filename

    if [ $status -eq 0 ]
        set PATH "$path/go/bin" $PATH
        install_go_dependencies
    end
end

##### install lua language server on OSX only
if [ (uname) = Darwin ]
    pushd $DOTFILES/lua-language-server
    git submodule update --init --recursive
    pushd $DOTFILES/lua-language-server/3rd/luamake
    ninja -f compile/ninja/macos.ninja
    popd
    ./3rd/luamake/luamake rebuild
    popd
end

##### install nnn
pushd $DOTFILES/nnn
git submodule update --init --recursive
make O_NERD=1
mv nnn /usr/local/bin/
popd

curl -LO 'https://storage.googleapis.com/kubernetes-release/release/v1.16.12/bin/'$os'/amd64/kubectl'
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

set base_url "https://github.com/ahmetb/kubectx/releases/download/v0.9.4"
set ctx_filename 'kubectx_v0.9.4_'$os'_x86_64.tar.gz'
set ctx_url $base_url'/'$ctx_filename
set ns_filename 'kubens_v0.9.4_'$os'_x86_64.tar.gz'
set ns_url $base_url'/'$ns_filename
set destination_path /usr/local/bin

tar_archive $ctx_url $destination_path $ctx_filename
tar_archive $ns_url $destination_path $ns_filename

rm $ctx_filename
rm $ns_filename

#### install rust
curl https://sh.rustup.rs -sSf | sh
cargo install stylua

############
### YOLO ###
############
yolo
