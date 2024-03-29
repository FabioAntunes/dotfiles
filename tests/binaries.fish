##########################
# Test binaries installed
##########################
set -l binaries node vim nvim kubectl kubectx nnn
# source node
nvm use default

for bin in $binaries
    @test "binary $bin is installed" (command -v $bin > /dev/null) $status -eq 0
end

##########################
# Test fishfile packages
##########################
set -l packages bass fishtape

for package in $packages
    @test "fisher package $package is installed" (type -p $package > /dev/null) $status -eq 0
end

##########################
# Test loaded functions
##########################
set -l functions yolo toggle-js-configs

for function in $functions
    @test "function $function is loaded" (type -p $function > /dev/null) $status -eq 0
end

##########################
# Test go binaries installed
##########################
set -l go_binaries godoc goimports gopls

for go_bin in $go_binaries
    @test "go binary $go_bin is installed" (command -v $go_bin > /dev/null) $status -eq 0
end
