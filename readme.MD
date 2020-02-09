# BlueTufa dotfiles Private Repository
## Contents
### Fish shell support
A comprensive collection of Fish (Friendly Interactive Shell) dotfiles which will allow a quick and easy customization of Fish on an existing system.  This configuration will generally work cross-platform betwen MacOS and Linux, although you may encounter minor bugs on either.  You can link your dotfiles from this repo into the home directory by running the `link-dotfiles.sh` file at the root of this repository.

### Neovim support
This directory includes a basic neovim configuration as well.  You will still need to configure vim-plug and run :PlugInstall to get a fully working installation.  To install vim-plug, run the following command:
  `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

Then once inside vim, run: `:PlugInstall`

Note that the ./link-dotfiles.sh script will also link from this repo into your nvim config directory.

### Backup with rsync
This repo includes a simple script that will backup to an encrypted external drive using rsync.  You may need to modify it depending on your hardware configuration and operating system.

### Example script for mounting an encrypted Luks volume
Again, this may vary based on your hardware and operating system configuration.


### Various technical README's
Mostly Arch Linux notes.

