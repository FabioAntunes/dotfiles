# Dotfiles
:love_hotel: `$HOME` is where your dotfiles are

<img width="1792" alt="screen shot 2018-03-05 at 23 12 36" src="https://user-images.githubusercontent.com/2544673/37005161-ee8ddeac-20ca-11e8-9c30-88ea69d30dc6.png">
<img width="1202" alt="screen shot 2018-03-05 at 10 22 11" src="https://user-images.githubusercontent.com/2544673/37005166-f3ba8902-20ca-11e8-868c-a3069b90d5a4.png">
<img width="1792" alt="screen shot 2018-07-03 at 00 18 41" src="https://user-images.githubusercontent.com/2544673/42190742-b69acc14-7e56-11e8-984e-12d03f704522.png">
<img width="1194" alt="screen shot 2018-07-03 at 00 17 46" src="https://user-images.githubusercontent.com/2544673/42190734-b0d9fd04-7e56-11e8-92f2-5c01ebb8cac7.png">

## Installation
#### Clone this repo
First step, clone this repo, because I'm lazy and these are my dotfiles, they need to be placed in `~/playground/dotfiles`

``` bash
$ git clone https://github.com/FabioAntunes/dotfiles.git ~/playground/dotfiles --recurse-submodules
```

Oh btw I'm using some git submodules.

### Run the init script

``` bash
$ cd ~/playground/dotfiles
$ bash init.sh
```

It will ask for your user and email to set your git global config. This will install everything in the `Brewfile` which will take shit loads of time :no_good:, it will also install `nvm` and `powerline fonts`.

After all this it will set :fish: as your default shell, and it will start the `init.fish` script

### NOTE
Some operations require sudo permissions, your password will be asked a couple of times and sent to a random server so I can take over all your data. :ok_hand:

### Global functions

After running both the `init.sh` and `init.fish` there will be a couple functions available globally.

#### yolo
This is the main function that allows us run all the commands related to dotfiles, it has autocompletion enabled just type `yolo -` and press tab.
If no args are passed to the `yolo` function, all the options will be executed in this order:

1. create symlinks, any existing symlinks will be preserved. 
2. install fisher
3. install vim plug Plugins
4. install global npm packages 

If we use the `-f/--force` it will run all the options above, but won't preserve any symlinks

The next args allows you to run the function in a granular way, feel free to combine multiple args

* `-f/--force` - it will overwrite existing symlinks
* `-s/--symlink` - create symlinks, this option will ignore already created symlinks. If a regular file already exists, it will be renamed aka backup file. Combine with the `-f/--force`
* `-n/--node` - install global packages.
* `-m/--fisher` - install fisher and it's plugins.
* `-v/--vimplug` - install vim and nvim Plugins.


At the end it will output all the symlinks created, any errors creating symlinks and any backup files created.

### Post install
All the paths should direct you to the dotfiles! There's a `post_exec` function inside the `config.fish`, that listens for any `brew install` and `brew cask install`. Whenever that happens, a Brewfile is dumped.
After that a check on the git files is done, if the only file changed is the Brewfile, a commit is created and pushed automatically (new files are automatically ignored).
The message will be `Updated Brewfile :beer:`. You can change this by setting `$DOTFILES_MSG` to whatever you want.
