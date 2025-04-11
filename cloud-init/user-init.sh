#! /bin/bash

git clone https://github.com/BlueTufa/dotfiles.git $HOME/src/dotfiles
cd $HOME/src/dotfiles
./installer.sh --skip-starship --skip-fish
curl -fsSL https://pyenv.run | zsh
echo "export WORK_SRC=$HOME/src" >> $HOME/.zsh/.exportsLocal
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zprofile
echo 'eval "$(pyenv init --path)"' >> $HOME/.zprofile
