# BlueTufa dotfiles Repository
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/BlueTufa/dotfiles/CI)
![GitHub issues](https://img.shields.io/github/issues/BlueTufa/dotfiles)
![GitHub pull requests](https://img.shields.io/github/issues-pr/BlueTufa/dotfiles)

## Contents
A comprensive collection of Fish (Friendly Interactive Shell) and ZSH dotfiles which will allow a quick and easy customization of Fish or Zsh on a new install or an existing system.  This configuration will generally work cross-platform betwen MacOS and Linux, although you may encounter minor bugs on either.  

### Symlinking dotfiles
You can symlink your dotfiles from this repo into the home directory by running the [installer.sh](installer.sh) file at the root of this repository.  Linking your dotfiles will first attempt to make backups of any existing dotfiles before establishing the link, but it is recommended that some prep work be done - such as a full backup - to be confident that you won't lose any work.  But if it's a clean install then just go for it and tell me if there's a bug.

#### Known issues with symlinking:
* It is recommended that if you want to use the .gitconfig sample file, to make a fork of this repo and update the GitHub account info to your own in your repo.  Then you can symlink your .gitconfig across environments without having to constantly update the account info.  But I've temporarily commented out the symlinking of .gitconfig due to the account info issue.    
* If you run `installer.sh` and the part about zsh/oh-my-zsh is not commented out, then it leaves you in zsh momentarily and you have to type `exit` in order for the script to continue processing.  I consider this a bug for the time being.  If you exit zsh in some other way other than an orderly exit, you'll likely need to run `installer.sh` again.
* If you are using the neovim configuration supplied in these dotfiles, then ignore the long list of errors on your first entry into neovim after symlinking, and remember to run `:PlugInstall`

### Fish support
To permanently change the default shell to Fish, run the following from bash:
`chsh -s $(which fish) $(whoami)`

### ZSH support 
The ZSH support is rather bare-bones but it will automatically try to symlink oh-my-zsh and powerlevel10k.  From there, you may wish to run the powerlevel10k via `p10k configure` at any time.  If p10k configure is never run then you will simply have my default zsh configuration.

To permanently change the default shell to ZSH, run the following from bash:
`chsh -s $(which zsh) $(whoami)`

> NOTE: You also need to confirm that your preferred shell is in `/etc/shells`.

### ZSH and fonts on Mac.
If you want to use p10k in zsh on Mac, you are going to need to make sure you use a powerline font.  If you're unsure what this means and the answer is still yes, then just make sure that you have Meslo font family selected in iTerm2 Under Preferences->Profiles-><Profile Name>->Text->Font.  The fonts listed below as examples both work great for me on both shells.  After making a change to a new terminal font and using zsh, I recommend re-running `p10k configure` just to make sure everything is lined up.

> Note that iTerm2 does not have direct, intuitive support for deploying configuration files.  If you go under iTerm2 -> Preferences -> Profiles and import the latest [Gruvbox theme](themes/Gruvbox.json), it will automatically configure a default color scheme as well as the font.  I didn't attempt to automate it further than that.  
#### Preferred font (iTerm2, MacOS only)
```bash
# on Mac.  Note that you may need to run `brew tap homebrew/cask-fonts` first
brew cask install font-meslo-lg-nerd-font
```

### Kitty 
I have been using Kitty as my default terminal lately and other than some minor annoyances with ssh, it's a win.  Kitty is also configuration file based in a much more practical way than iTerm2.  If you choose to use that combination you'll get a default configuration by way of the symlink to `~/.config/kitty/kitty.conf`.    The great thing about the Kitty and Code New Roman font combination is that it works extremely well across multiple Linux distributions as well as MacOS, with great glyph support.  

> The commands below will establish Kitty and Code New Roman on Mac, which work in tandem with the symlinked `~/.config/kitty/kitty.conf`.  If you are running on Linux then you still get the symlink, but the package manager install commands will vary wildly based on the distribution, so that will have to be out of the scope of this README.  TLDR: do the equivalent of the command below for your Linux distro and everything might just work.  

#### Preferred font (kitty terminal)
```bash
# Note that you may need to run `brew tap homebrew/cask-fonts` first
brew cask install kitty
brea cask install font-codenewroman-nerd-font
```

### Cross-platform fonts and terminal support
I am currently able to use the Code New Roman font across both platforms with the Kitty terminal with minimal changes to the config file.  I had to resize the font slightly for Linux, but that's it.  I also find the user experience and readability with Kitty on Linux to be slightly better with some background transparency.  So I set the `background_opacity: 0.9` on Linux only.  
  
### Neovim support
This directory includes a basic neovim configuration as well.  If you run `./installer.sh` it will automatically symlink neovim's init.vim and install vim-plug for you.   

Or, if you prefer not to run the symlinking and still want to use the init.vim, remember to install vim-plug manually:
  `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

> Remember that after you open neovim for the first time, you will likely see errors until you run: `:PlugInstall`

The following are included in init.vim with customizations:
* coc.nvim 
* Nerdtree
* Airline
* https://scalameta.org/metals/docs/editors/vim.html integrated with coc.nvim.
* Terminal support.

### For linux users, I've also recently added random config files for the following:
* .ncmpcpp music player
* mpd music server
* alacritty terminal
* atom editor install plug-ins from command line
* sway wm config
* waybar support
* kitty terminal config

### Technical readmes
It makes sense to consolidate notes on multi-platform issues in a global location such as GitHub.  Hence there are several howto/readmes on a long history of notes.
- [GitHub](git_notes.MD)
- [Cheat Sheet](tech_cheat_sheet.MD)
- [QMK Firmware](qmk_notes.MD)
- [Rust](rust_notes.MD)

### Unlimited Bonus Points Edition
What are the odds that you found these dotfiles, and also have a programmable keyboards that uses the QMK firmware?  Well in that case welcome to the unlimited bonus points edition (TM).  Check here for more details: https://github.com/qmk/qmk_firmware/tree/master/users/badger.  I have contributed multi-platform support and new layouts for Preonic, 1up 60 RGB, Clueboard 66 and more.  One of the key design goals of my layouts is to have each key sequence provide a similar feature parity between both Linux and MacOS via a static OS-specific `MOVE` layer.  

### Thoughts on sharing dotfiles
Dotfiles are a highly personal thing and will vary based on an individual, their current job role and daily workflow.  I am mostly sharing these because I want to share, and I've had a lot of requests over the years for, "how did you get x,y,z to work."  I fully expect people to use them more for ideas than as a complete solution.  But if you manage to pull off the latter then let's go have a beer and talk about what you're working on.   

The most common usage scenario for these dotfiles would be for you to fork this repo, make any tweaks to your fork as you see fit, then pull my latest changes into your fork on whatever schedule you find useful.  If you make an improvement or bug fix that you would like to share please open a PR against this repo.  

### Note on bugs
If you find a bug and it's obvious, please just open a PR.  If you find a bug and it's not obvious or you hope for me to fix it, please use the GitHub issues feature for this branch located here: https://github.com/BlueTufa/dotfiles/issues.

### Feedback and WTF's
I am very welcoming to feedback and I constantly learn from the community and from other peoples' approaches to these common problems.  If you see something that looks odd, or is harder than it should be please let me know, and feel free to open PR's against this branch.  It would be much appreciated.  

### Security
If you discover anything that is of a privacy or security concern please report it immediately as it's not just my well-being but a concern of others who might fork or use these files.  Use the [Issue tracker](https://github.com/BlueTufa/dotfiles/issues) or contact mailto:github@bluetufa.com.  I also bothered to set up a security policy [here](https://github.com/BlueTufa/dotfiles/security).

Thanks for looking!
