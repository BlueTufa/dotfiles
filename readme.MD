# BlueTufa dotfiles Repository
![GitHub Workflow Status](https://github.com/BlueTufa/dotfiles/actions/workflows/ci.yml/badge.svg)
![GitHub pull requests](https://img.shields.io/github/issues-pr/BlueTufa/dotfiles)

## Contents
A comprensive collection of [fish](https://fishshell.com/), [Nushell](https://www.nushell.sh/), and zsh dotfiles which will allow a quick and easy customization of fish or zsh on a new install or an existing system.  This configuration is intended to work cross-platform betwen MacOS and Linux, although Linux compatibility will vary widely.  

### Symlinking dotfiles
This solution works on the concept of symlinking dotfiles from a git repository into their respective configuration locations on the target operating system.  This allows the files to be maintained in version control in a uniform way across multiple systems.

You can symlink your dotfiles from this repo into the home directory by running the [installer.sh](installer.sh) file at the root of this repository.  Linking your dotfiles will first attempt to make backups of any existing dotfiles before establishing the symlink, but it is always recommended that some prep work be done - such as a full backup - to be confident that you won't lose anything.

### Fish support
To permanently change the default shell to Fish, run the following from bash:
`chsh -s $(which fish) $(whoami)`
> https://github.com/fish-shell/fish-shell/issues/2124
> Confirm that your preferred shell is in `/etc/shells`.  

### ZSH support 
The ZSH support will use initialize the prompt with starship.rs, and several other conveniences.

To permanently change the default shell to ZSH, run the following from bash:
`chsh -s $(which zsh) $(whoami)`

#### Preferred font (iTerm2, MacOS only)
```bash
brew install font-meslo-lg-nerd-font
#or simply, from this directory:
brew bundle
```cccccbvgujdutiikluhjkignkefukdeddfufbbegblgk
cccccbvgujdutvgjkchhgckjfjjlbgcgfgducnrigfhh


### Neovim support
This project includes a basic neovim configuration.  If you run `./installer.sh` it will automatically symlink lua and install vim-plug for you.   

Or, if you prefer not to run the symlinking and still want to use the nvim configs, remember to install vim-plug manually:
  ```bash
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  ```
> Remember that after you open neovim for the first time, you will likely see errors until you run: `:PlugInstall`

### Thoughts on sharing dotfiles
Dotfiles are a highly personal thing and will vary widely based on an individual, their current job role and daily workflow.  I am mostly sharing these because I've had a lot of requests over the years for, "how did you get x,y,z to work?"  I expect them to be used as a starting point rather than an end-to-end solution.

The most common usage scenario for these dotfiles would be for you to fork this repo, make any tweaks to your fork as you see fit.  If you make an improvement or bug fix that you would like to share, please open a PR against this repo.  

### Note on bugs
If you find a bug and it's obvious, please just open a PR.  If you find a bug and it's not obvious or you hope for me to fix it, please use the GitHub issues feature for this branch located here: https://github.com/BlueTufa/dotfiles/issues.

### Security
An effort has been made to omit any personally identifiable information, as well as employer names, project names, and user id's.

It is possible to store secrets by adding a new suffix to any of the file types you don't want checked in.  For example, create an `.aliasesLocal` or `.exportsLocal` under `~/.config/fish`.  These files will be detected by the `fish` pattern matching scheme in use by this solution.  But unlike the other shared dotfiles in this project, these would not be symlinked into the git repository, making them suitable for storing secrets.

If you discover anything that is of a privacy or security concern please report using the [Issue tracker](https://github.com/BlueTufa/dotfiles/issues) or contact mailto:github@bluetufa.com.  The security policy is [here](https://github.com/BlueTufa/dotfiles/security).
