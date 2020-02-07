#! /bin/bash

ln -sf $(pwd)/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

for file in fish/.{functions,exports,aliases}
do
  ln -sf $(pwd)/$file ~/.config/${file}
done
