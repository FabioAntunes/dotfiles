# Dotfiles
:love_hotel: `$HOME` is where your dotfiles are

<img width="1792" alt="screen shot 2018-03-05 at 23 12 36" src="https://user-images.githubusercontent.com/2544673/37005161-ee8ddeac-20ca-11e8-9c30-88ea69d30dc6.png">
<img width="1202" alt="screen shot 2018-03-05 at 10 22 11" src="https://user-images.githubusercontent.com/2544673/37005166-f3ba8902-20ca-11e8-868c-a3069b90d5a4.png">

## Installation
#### Clone this repo
First step, clone this repo, because I'm lazy and this is my dotfiles, they need to be placed in ~/playground/dotfiles

``` bash
$ git clone https://github.com/epilande/dotfiles.git ~/playground/dotfiles
```

### Run the init script

``` bash
$ cd ~/playgroud/dotfiles
$ bash init.sh
```

It will ask for your user and email to set your git global config. This will install everything in the `Brewfile` which will take shit loads of time :no_good:, it will also install `nvm` and `powerline fonts`.

After all this it will set :fish: as your default shell, and it will start the `yolo.fish` script

### NOTE
Some operations require sudo permissions, your password will be asked a couple of times and sent to a random server so I can take over all your data. :ok_hand:

### yolo.fish

This is where all the magic happens :sparkles: a really complex algorithm will create the symlinks. If there's a file already but it's not a symlink, it will create a backup and then the symlink.

It will output all the symlinks created and any backups as well.

After that it will install:
* :man::fishing_pole_and_fish::tropical_fish: and it's plugins
* Vim Plug for vim and neovim
* node global packages `eslint stylelint tern`


It will also install vim and neovim plugins, by openeing both editors running  `n?vim +PlugInstall +qall`


### Post install
All the paths should direct you to the dotfiles! There's a `post_exec` function inside the `config.fish`, that listens for any `brew install` and `brew cask install`. Whenever that happens, a Brewfile is dumped.
After that a check on the git files is done, if the only file changed is the Brewfile, a commit is created and pushed automaticallly (new files are automatically ignored).
The message will be `Updated Brewfile :beer:`. You can change this by setting `$DOTFILES_MSG` to whatever you want.
