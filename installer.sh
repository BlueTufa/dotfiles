#! /bin/bash

install-vim-plug () {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install-oh-my-zsh () {
  echo "Remember to type exit after the oh-my-zsh install is complete"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "Remember to run p10k configure any time you want to reconfigure powerlevel10k."
}

make-backup () {
  # if the file exists and is not a symlink...
  if [[ -f $1 ]] && [[ ! -L $1 ]] 
  then
    new_path="$(dirname $1)/backup.of.$(basename $1)"
    echo "Making a backup of non-symlinked $1 to ${new_path}"
    mv $1 ${new_path}
  fi
}

# os-independent config directories
mkdir -p ~/src/bin
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
mkdir -p ~/.config/kitty

# comment this out if you don't want to use oh-my-zsh or zsh support
[[ -d ~/.oh-my-zsh ]] || install-oh-my-zsh

[[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || install-vim-plug

make-backup ~/.config/fish/config.fish 
make-backup ~/.config/nvim/init.vim
make-backup ~/.zshrc
make-backup ~/.p10k.zsh

# comment this out if you don't want to symlink gitconfig.  
# make-backup ~/.gitconfig

ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
ln -sf $(pwd)/zsh/.p10k.zsh ~/.p10k.zsh

if [[ $(uname) == "Linux" ]]; then
  mkdir -p ~/.config/alacritty
  mkdir -p ~/.config/sway/scripts
  mkdir -p ~/.config/mpd
  mkdir -p ~/.ncmpcpp
  mkdir -p ~/.config/waybar
  mkdir -p ~/.config/wofi
  ln -sf $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
  ln -sf $(pwd)/sway/config ~/.config/sway/config
  ln -sf $(pwd)/sway/scripts/sway-launcher-desktop.sh ~/.config/sway/scripts/sway-launcher-desktop.sh
  ln -sf $(pwd)/mpd/mpd.conf ~/.config/mpd/mpd.conf
  ln -sf $(pwd)/.ncmpcpp/config ~/.ncmpcpp/config
  ln -sf $(pwd)/waybar/config ~/.config/waybar/config
  ln -sf $(pwd)/waybar/executable_mediaplayer.sh ~/.config/waybar/executable_mediaplayer.sh
  ln -sf $(pwd)/waybar/style.css ~/.config/waybar/style.css
  ln -sf $(pwd)/wofi/style.css ~/.config/wofi/style.css
fi 

[[ $(uname) == "Darwin" ]] && ln -sf $(pwd)/kitty/kitty.conf.Darwin ~/.config/kitty/kitty.conf

for file in fish/.{functions,exports,aliases,*$(uname)}
do
  make-backup ~/.config/${file}
  echo "Linking ${file}..."
  ln -sf $(pwd)/${file} ~/.config/${file}
done

