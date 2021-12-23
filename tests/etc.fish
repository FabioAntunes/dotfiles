######################
# tests random stuff #
######################

@test "vim has python support" (vim --version | grep -q +python3) $status -eq 0
