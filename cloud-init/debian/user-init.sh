#! /bin/bash

git clone https://github.com/BlueTufa/dotfiles.git $HOME/src/dotfiles
cd $HOME/src/dotfiles
curl -fsSL https://pyenv.run | zsh
echo "export WORK_SRC=$HOME/src" >> $HOME/.zsh/.exportsLocal
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(pyenv init --path)"' >> $HOME/.zprofile

wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

./installer.sh --skip-starship --skip-fish

cargo install eza git-delta macchina

cp $HOME/src/dotfiles/.gitconfig $HOME/
