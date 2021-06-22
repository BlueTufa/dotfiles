#! /bin/bash
apt update
apt install -y exa fish git lolcat neovim neofetch tree silversearcher-ag trash-cli avahi-daemon avahi-discover libnss-mdns curl wget yarn

mkdir -p ~/.local/share/fonts/
wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip'
unzip Hack.zip

wget 'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CodeNewRoman.zip'
unzip CodeNewRoman.zip
mv *.otf ~/.local/share/fonts/
mv *.ttf ~/.local/share/fonts/

wget https://github.com/sharkdp/bat/releases/download/v0.18.1/bat_0.18.1_amd64.deb
dpkg -i bat_0.18.1_amd64.deb

# TODO: set locale

