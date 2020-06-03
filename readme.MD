# BlueTufa dotfiles Repository
## Contents
A comprensive collection of Fish (Friendly Interactive Shell) and ZSH dotfiles which will allow a quick and easy customization of Fish on an existing system.  This configuration will generally work cross-platform betwen MacOS and Linux, although you may encounter minor bugs on either.  

## Note on bugs
If you find a bug and it's obvious, please just open a PR.  If you find a bug and it's not obvious or you hope for me to fix it, please use the GitHub issues feature for this branch located here: https://github.com/BlueTufa/dotfiles/issues.

### Symlinking dotfiles
You can symlink your dotfiles from this repo into the home directory by running the [installer.sh](installer.sh) file at the root of this repository.  Linking your dotfiles will first attempt to make backups of any existing dotfiles before establishing the link, but it is recommended that some prep work be done - such as a full backup - to be confident that you won't lose any work.  

#### Known issues with symlinking:
* It is recommended that if you want to use the .gitconfig sample file, to make a fork of this repo and update the GitHub account info to your own in your repo.  Then you can symlink your .gitconfig across environments without having to constantly update the account info.  But I've temporarily commented out the symlinking of .gitconfig due to the account info issue.    
* If you run `installer.sh` and the part about zsh/oh-my-zsh is not commented out, then it leaves you in zsh momentarily and you have to type `exit` in order for the script to continue processing.  I consider this a bug for the time being.  If you exit zsh in some other way other than an orderly exit, you'll likely need to run `installer.sh` again.
* If you are using the neovim configuration supplied in these dotfiles, then ignore the long list of errors on your first entry into neovim after symlinking, and remember to run `:PlugInstall`

### Fish support
To permanently change the default shell to Fish, run the following from bash:
`chsh -s $(which fish) $(whoami)`

### ZSH support 
The ZSH support is rather bare-bones but it will automatically install oh-my-zsh and powerlevel10k.  From there, it will likely automatically run the powerlevel10k wizard the first time you are in zsh, or you can run `p10k configure` at any time.  If p10k configure is never run then you will simply have my default zsh configuration.   

To permanently change the default shell to ZSH, run the following from bash:
`chsh -s $(which zsh) $(whoami)`

#### ZSH and fonts on Mac.  
If you want to use p10k in zsh on Mac, you are going to need to make sure you use a powerline font.  If you're unsure what this means and the answer is still yes, then just make sure that you have Meslo font family selected in iTerm2 Under Preferences->Profiles-><Profile Name>->Text->Font.  At the time of this writing, my font name is `MesloLGS NF` and the glyphs are working great in both vim and zsh.  After making a change to a new font, I recommend re-running `p10k configure`.  I am currently using the Code New Roman fonts on both Mac and Linux and am very content with them.
```bash
brew cask install font-codenewroman-nerd-font
``` 

### Neovim support
This directory includes a basic neovim configuration as well.  If you run `./installer.sh` it will automatically symlink neovim's init.vim and install vim-plug for you.   

Or, if you prefer not to run the symlinking and still want to use the init.vim, remember to install vim-plug manually:
  `curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`

Remember that once inside neovim, you will likely see errors until you run: `:PlugInstall`

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
What are the odds that you found these dotfiles, and also like programmable keyboards that use the QMK firmware?  Well in that case welcome to the unlimited bonus points edition (TM).  Check here for more details: https://github.com/BlueTufa/qmk_firmware/.  Preonic, 1up 60 RGB, ad Clueboard 66 are all supported in that fork.  They also share a lot of custom keycodes.  

### Thoughts on sharing dotfiles
Dotfiles are a highly personal thing and should vary based on an individual, their current job role and daily workflow.  I am mostly sharing these because I want to share, and I've had a lot of requests over the years for, "how did you get x,y,z to work."  I fully expect people to use them more for ideas than as a complete solution.  But if you manage to pull off the latter then hats off to you and let's go have a beer because we are mind twins.   

### Feedback and WTF's
I am very welcoming to feedback and I constantly learn from the community and from other peoples' approaches to these common problems.  If you see something that looks odd, or is harder than it should be please let me know, and feel free to open PR's against this branch.  It would be much appreciated.  Also if you discover anything that is of a privacy or security concern please report it immediately as it's not just my well-being but a concern of others who might fork or branch these files.  Please contact github@bluetufa.com.  Thank you.  

