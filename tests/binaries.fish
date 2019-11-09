##########################
# Test binaries installed
##########################
set -l binaries node vim nvim yarn
if test (uname) = 'Darwin'
  set -a binaries brew
end

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
set -l functions yolo toggle-background-color toggle-js-configs

for function in $functions
  @test "function $function is loaded" (type -qp $function > /dev/null) $status -eq 0
end
