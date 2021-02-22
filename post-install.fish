set -gx os (uname | tr '[:upper:]' '[:lower:]')

if command -v pip3 > /dev/null
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

if [ "$GITHUB_ACTIONS" = "true" ]; then
  # machines on Github actions already have golang installed
  install_go_dependencies
else
  set version (curl 'https://golang.org/VERSION?m=text')
  set filename "$version.$os-amd64.tar.gz"
  set golang_path "/usr/local"
  set url "https://dl.google.com/go/$filename"

  tar_archive $url $golang_path $filename

  if [ $status -eq 0 ]
    set PATH "$path/go/bin" $PATH
    install_go_dependencies
  end
end

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.12/bin/${os}/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

set base_url "https://github.com/ahmetb/kubectx/releases/download/v0.9.1"
set ctx_filename "kubectx_v0.9.1_${os}_x86_64.tar.gz"
set ctx_url "$base_url/$ctx_filename"
set ns_filename "kubens_v0.9.1_${os}_x86_64.tar.gz"
set ns_url "$base_url/$ns_filename"
set destination_path "/usr/local/bin"

tar_archive $ctx_url $destination_path $ctx_filename
tar_archive $ns_url $destination_path $ns_filename


