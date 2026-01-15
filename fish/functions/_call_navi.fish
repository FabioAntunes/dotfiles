function _call_navi
    # Run navi, redirecting terminal input, and capture the output
    set selected (navi --print < /dev/tty)

    # If the command was successful (status is 0) and it returned text...
    if test -n "$selected"; and test $status -eq 0
        # Insert the selected text into the current command line at the cursor
        commandline --insert "$selected"
    end
end
