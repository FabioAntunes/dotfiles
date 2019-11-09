##########################
# Test binaries installed
##########################
if test (uname) = 'Darwin'
  set -l binaries fzf gpg gomplate htop jq kubectx kubectl ag

  for bin in $binaries
    @test "binary $bin installed" (command -v $bin > /dev/null) $status -eq 0
  end

end
