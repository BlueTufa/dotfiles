#! /bin/bash

# this file is idempotent and can safely be run many times. 

make-backup () {
  # if the file exists and is not a symlink...
  if [[ -f $1 ]] && [[ ! -L $1 ]] 
  then
    new_path="$(dirname $1)/backup-of-$(basename $1)"
    echo "Making a backup of non-symlinked $1 to ${new_path}"
    mv $1 ${new_path}
  fi
}

install-nvim () {
  echo "Configuring nvim and installing vim-plug"
  mkdir -p ~/.config/nvim/lua
  make-backup ~/.config/nvim/init.lua
  make-backup ~/.config/nvim/lua/plugins.lua

  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  
  ln -sf $(pwd)/nvim/init.lua ~/.config/nvim/init.lua
  ln -sf $(pwd)/nvim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua

  nvim -c ':PlugInstall' +qa
}

install-oh-my-zsh () {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
  sh -c "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

  mkdir -p ~/.zsh
  for file in zsh/.{functions,exports,aliases}
  do
    make-backup ~/.${file}
    echo "Linking ${file}..."
    ln -sf $(pwd)/${file} ~/.${file}
  done

  make-backup ~/.zshrc
  ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
}

install-fish () {
  if ! command -v fish &> /dev/null
  then
    echo "Fish shell not found"
    exit 0
  fi

  mkdir -p ~/.config/fish
  make-backup ~/.config/fish/config.fish 
  ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish

  for file in fish/.{abbr,functions,exports,aliases}
  do
    make-backup ~/.config/${file}
    echo "Linking ${file}..."
    ln -sf $(pwd)/${file} ~/.config/${file}
  done

  fish -c "curl -sL https://git.io/fisher | source" \
    " && fisher install jorgebucaran/fisher && fisher install jorgebucaran/nvm.fish" \
    " && fisher install evanlucas/fish-kubectl-completions && fisher install patrickf1/fzf.fish" \
    " && fisher install brgmnn/fish-docker-compose"
}

config-starship() {
# starship is the default prompt on zsh and fish
  make-backup ~/.config/starship.toml
  ln -sf $(pwd)/starship.toml ~/.config/starship.toml
}

config-fastfetch() {
  mkdir -p ~/.config/fastfetch/
  make-backup ~/.config/fastfetch/config.jsonc
  ln -sf $(pwd)/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
}

mkdir -p ~/src/bin
mkdir -p ~/.config
touch ~/.hushlogin

if [[ $(uname) == "Darwin" ]]; then
  [[ -d ~/Library/KeyBindings/ ]] || mkdir -p ~/Library/KeyBindings/
  cp ./macos/Library/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/
  [[ " $* " == *" --sync-brew "* ]] && brew bundle --cleanup
fi

# comment this out if you don't want nvim
[[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || install-nvim

# comment this out if you don't want to use oh-my-zsh or zsh support
[[ -d ~/.oh-my-zsh ]] || install-oh-my-zsh

[[ " $* " == *" --skip-starship "* ]] || config-starship
[[ " $* " == *" --skip-fish "* ]] || install-fish

config-fastfetch
