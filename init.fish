set -gx os (uname | tr '[:upper:]' '[:lower:]')
############################
### source yolo function ###
############################
source fish/functions/yolo.fish

########################
### fish shell setup ###
########################
set -gx fish_greeting
set -gx $DOTFILES (dirname (realpath (status --current-filename)))

#create abbreviations
abbr -a gout git checkout
abbr -a g git
abbr -a k kubectl
abbr -a me cd $HOME/playground
abbr -a dot cd $DOTFILES
abbr -a work cd $HOME/work

#################
### make dirs ###
#################
mkdir -p $HOME/.local/share/nvim/undodir
mkdir -p $HOME/.vim/undodir
mkdir -p $HOME/go
mkdir -p $HOME/playground
mkdir -p $HOME/work

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

#######################
### create symlinks ###
#######################
yolo -s

######################
### install fisher ###
######################
curl -sL https://git.io/fisher | source && fisher update

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
    echo "Installing go dependencies"
    go install golang.org/x/tools/cmd/godoc@latest
    go install golang.org/x/tools/cmd/goimports@latest
    go install golang.org/x/tools/gopls@latest
end

if [ "$GITHUB_ACTIONS" = true ]
    # machines on Github actions already have golang installed
    install_go_dependencies
else
    echo "Installing golang"
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

##### install nnn
echo "Installing nnn"
echo $DOTFILES/nnn
pushd ./nnn
ls -la
git submodule update --init --recursive
make O_NERD=1
sudo make install
popd

curl -LO 'https://dl.k8s.io/release/v1.26.13/bin/'$os'/amd64/kubectl'
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl completion fish >~/.config/fish/completions/kubectl.fish

set base_url "https://github.com/ahmetb/kubectx/releases/download/v0.9.5"
set ctx_filename 'kubectx_v0.9.5_'$os'_x86_64.tar.gz'
set ctx_url $base_url'/'$ctx_filename
set ns_filename 'kubens_v0.9.5_'$os'_x86_64.tar.gz'
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
