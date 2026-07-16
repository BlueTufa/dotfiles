#! /bin/bash
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

nix eval .#homeConfigurations.badger.activationPackage
nix run home-manager/master -- switch --flake .#badger
