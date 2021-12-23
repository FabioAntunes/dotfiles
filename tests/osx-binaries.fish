##########################
# Test binaries installed
##########################
if test (uname) = Darwin
    set -l binaries brew fzf gpg htop jq ag go

    for bin in $binaries
        @test "binary $bin installed" (command -v $bin > /dev/null) $status -eq 0
    end

end
