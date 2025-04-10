#! /bin/bash

mkdir -p $HOME/src
cd $HOME/src
git clone https://github.com/BlueTufa/dotfiles.git
cd dotfiles
./installer.sh --skip-starship --skip-fish
curl -fsSL https://pyenv.run | zsh
echo "export WRK_SRC=$HOME/src" >> $HOME/.zsh/.exportsLocal
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(pyenv init --path)"' >> $HOME/.zprofile
chsh -s $(which zsh)
# required python build dependencies
sudo dnf install -y make gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel tk-devel libffi-devel xz-devel libuuid-devel gdbm-devel libnsl2-devel
