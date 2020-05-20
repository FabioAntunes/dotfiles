package main

import (
	"flag"
	"fmt"
	"os"
)

var flags = flag.NewFlagSet("", flag.ExitOnError)
var forceFlagDesc = "If a file with the same name already exists. It will rename the existing file appending the current timestamp"
var symlinkFlagDesc = "Symlinks all the files"
var vimPlugFlagDesc = "Installs all vim-plug packages"
var copyFlagDesc = "Copies all the files"

var forceFlag = flags.Bool("force", false, forceFlagDesc)
var symlinkFlag = flags.Bool("symlink", false, symlinkFlagDesc)
var vimPlugFlag = flags.Bool("vim-plug", false, vimPlugFlagDesc)
var copyFlag = flags.Bool("copy", false, copyFlagDesc)

func init() {
	flags.BoolVar(forceFlag, "f", false, forceFlagDesc)
	flags.BoolVar(symlinkFlag, "s", false, symlinkFlagDesc)
	flags.BoolVar(vimPlugFlag, "v", false, vimPlugFlagDesc)
	flags.BoolVar(copyFlag, "c", false, copyFlagDesc)
}

func symlink(force bool) {
	fmt.Printf("symlink %t", force)
}

func vimPlug() {
	fmt.Println("vim plug")
}

func copyFiles(force bool) {
	fmt.Printf("symlink %t", force)
}

func main() {
	err := flags.Parse(os.Args[0:])

	if err != nil {
		statusCode := 1
		os.Exit(statusCode)
	}

	hasForce := *forceFlag

	if flags.NFlag() > 1 || flags.NFlag() == 1 && !hasForce {
		if *symlinkFlag {
			symlink(hasForce)
		}

		if *vimPlugFlag {
			vimPlug()
		}

		if *copyFlag {
			copyFiles(hasForce)
		}
	} else {
		symlink(hasForce)
		vimPlug()
		copyFiles(hasForce)
	}
}
