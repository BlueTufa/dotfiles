#! /bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

git clone https://github.com/BlueTufa/dotfiles.git $HOME/src/dotfiles
cd $HOME/src/dotfiles
./installer.sh --skip-starship --skip-fish
curl -fsSL https://pyenv.run | zsh
echo "export WORK_SRC=$HOME/src" >> $HOME/.zsh/.exportsLocal
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(pyenv init --path)"' >> $HOME/.zprofile

apt install curl gnupg2 software-properties-common
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
curl -fsSL https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.deb -o nvim.deb
apt install ./nvim.deb

cargo install eza git-delta

cp $HOME/src/dotfiles/.gitconfig $HOME/
