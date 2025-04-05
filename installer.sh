#! /bin/bash

# this file is idempotent and can safely be run many times. 
# However, note that the backup function may overwrite previous file backups.

install-vim-plug () {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install-oh-my-zsh () {
  make-backup ~/.zshrc
  echo "Remember to type exit after the oh-my-zsh install is complete"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sh -c "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

  ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
}

make-backup () {
  # if the file exists and is not a symlink...
  if [[ -f $1 ]] && [[ ! -L $1 ]] 
  then
    new_path="$(dirname $1)/backup-of-$(basename $1)"
    echo "Making a backup of non-symlinked $1 to ${new_path}"
    mv $1 ${new_path}
  fi
}

# os-independent config directories
mkdir -p ~/src/bin
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim

# comment this out if you don't want to use oh-my-zsh or zsh support
[[ -d ~/.oh-my-zsh ]] || install-oh-my-zsh

# install vim-plug if not already present
[[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || install-vim-plug

make-backup ~/.config/fish/config.fish 
make-backup ~/.config/nvim/init.vim

mkdir -p ~/.config/nvim/lua

ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/nvim/init.lua ~/.config/nvim/init.lua
ln -sf $(pwd)/nvim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua

touch ~/.hushlogin

if [[ $(uname) == "Darwin" ]]; then
  [[ -d ~/Library/KeyBindings/ ]] || mkdir -p ~/Library/KeyBindings/
  cp ./macos/Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/
fi

ln -sf $(pwd)/starship.toml ~/.config/starship.toml
# if fish is present, go ahead and install fisher and plugins
[[ $(which fish) ]] && fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher && fisher install jorgebucaran/nvm.fish"

for file in fish/.{abbr,functions,exports,aliases,*$(uname)}
do
  make-backup ~/.config/${file}
  echo "Linking ${file}..."
  ln -sf $(pwd)/${file} ~/.config/${file}
done


