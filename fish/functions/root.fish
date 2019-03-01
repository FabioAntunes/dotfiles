function root -d "goes to the root of git repo"
    set -l root (command git rev-parse --show-toplevel --is-bare-repository 2>/dev/null)
    or return

    [ "$root[2]" = "false" ]; and cd $root[1]
end
