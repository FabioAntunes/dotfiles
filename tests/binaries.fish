##########################
# Test binaries installed
##########################
set -l binaries node vim nvim kubectl kubectx yarn
# source node
nvm use default

for bin in $binaries
  @test "binary $bin installed" (command -v $bin > /dev/null) $status -eq 0
end

##########################
# Test fishfile packages
##########################
set -l packages bass fishtape

for package in $packages
  @test "fisher package $package installed" (type -qp $package > /dev/null) $status -eq 0
end

##########################
# Test loaded functions
##########################
set -l functions yolo toggle-js-configs

for function in $functions
  @test "function $function is loaded" (type -qp $function > /dev/null) $status -eq 0
end

##########################
# Test go binaries installed
##########################
set -l go_binaries godoc goimports gopls dlv

for go_bin in $go_binaries
  @test "binary $go_bin installed" (command -v $go_bin > /dev/null) $status -eq 0
end
