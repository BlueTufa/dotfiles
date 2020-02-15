#! /bin/bash

ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

for file in fish/.{functions,exports,aliases,*$(uname)}
do
  echo "Linking ${file}..."
  ln -sf $(pwd)/$file ~/.config/${file}
done

mkdir -p ~/src/bin

[[ -d ~/.oh-my-zsh ]] || install-oh-my-zsh 

[[ -f ~/.local/share/nvim/site/autoload/plug.vim ]] || install-vim-plug

function install-vim-plug() {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function install-oh-my-zsh() {
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}
