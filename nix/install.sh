#! /bin/bash

mkdir -p ~/.config/nix

grep -qxF 'experimental-features = nix-command flakes' ~/.config/nix/nix.conf 2>/dev/null ||
    echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.config

nix eval .#homeConfigurations.badger.activationPackage
nix run home-manager/master -- switch --flake .#badger
