# BlueTufa dotfiles Private Repository
## Contents
A comprensive collection of Fish (Friendly Interactive Shell) and ZSH dotfiles which will allow a quick and easy customization of Fish on an existing system.  This configuration will generally work cross-platform betwen MacOS and Linux, although you may encounter minor bugs on either.  

### Symlinking dotfiles
You can symlink your dotfiles from this repo into the home directory by running the `link-dotfiles.sh` file at the root of this repository.  Linking your dotfiles will first attempt to make backups of any existing dotfiles before establishing the link, but it is recommended that some prep work be done - such as a full backup - to be confident that you won't lose any work.  

#### Known issues with symlinking:
* Currently if you symlink everything, your GitHub user name will be pointed at my account and gpg key.  It is recommended that if you want to use my .gitconfig file, to make a fork of this repo and update that account info to your own in your repo.  Otherwise, just comment out the part that symlinks .gitconfig. 
* If you run `link-dotfiles.sh` and the part about zsh/oh-my-zsh is not commented out, then it leaves you in zsh momentarily and you have to type `exit` in order for the script to continue processing.  I consider this a bug for the time being.  If you exit zsh in some other way other than an orderly exit, you'll likely need to run `link-dotfiles.sh` again.
* If you are using the neovim configuration supplied in these dotfiles, then ignore the long list errors on your first entry into neovim after symlinking, and remember to run `:PlugInstall`
### Fish support
To permanently change the default shell to Fish, run the following from bash:
`chsh -s $(which fish) $(whoami)`

### ZSH support 
The ZSH support is rather bare-bones but it will automatically install oh-my-zsh and powerlevel10k.  From there, it will likely automatically run the powerlevel10k wizard the first time you are in zsh, or you can run `p10k configure` at any time.  

To permanently change the default shell to ZSH, run the following from bash:
`chsh -s $(which zsh) $(whoami)`

#### ZSH and fonts on Mac.  
If you want to use p10k in zsh on Mac, you are going to need to make sure you use a powerline font.  If you're unsure what this means and the answer is still yes, then just make sure that you have Meslo font family selected in iTerm2 Under Preferences->Profiles-><Profile Name>->Text->Font.  At the time of this writing, my font name is `MesloLGS NF` and the glyphs are working great in both vim and zsh.  After making a change to an unknown font, I recommend re-running `p10k configure`.  

### Neovim support
This directory includes a basic neovim configuration as well.  If you run `./link-dotfiles.sh` it will automatically symlink neovim's init.vim and install vim-plug for you.   

Or, if you prefer not to run the symlinking and still want to use the init.vim, remember to install vim-plug manually:
  `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

Remember that once inside neovim, you will likely see errors until you run: `:PlugInstall`

The following are included in init.vim with customizations:
* coc.nvim 
* Nerdtree
* Airline
* Terminal support

### Backup with rsync
This repo includes a simple script that will backup to an encrypted external drive using rsync.  You may need to modify it depending on your hardware configuration and operating system.

### Example script for mounting an encrypted Luks volume
Again, this may vary based on your hardware and operating system configuration.

### Various technical README's
Mostly Arch Linux notes.

### Feedback and WTF's
Just because I've been doing this for a long time doesn't necessarily mean I'm good at it.  I am very welcoming to feedback and I constantly learn from the community and from other peoples' approaches to these common problems.  If you see something that looks odd, or is harder than it should be please let me know, and feel free to open PR's against this branch.  It would be much appreciated.  Also if you discover anything that is of a privacy or security concern please report it immediately as it's not just my well-being but a concern of others who might fork or branch these files.  Please contact github@bluetufa.com.  Thank you.  

