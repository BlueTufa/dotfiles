#! /bin/bash

# This file is a reference for use getting a clean MacOS install started.
# Note that this file is not particularly useful assuming you plan to use brew
# to install git, etc.  

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew bundle

xcode-select --install

sudo sysadminctl -afpGuestAccess off
sudo sysadminctl -smbGuestAccess off
sudo sysadminctl -guestAccount off
sudo scutil --set HostName $(pwgen 32 1)
sudo scutil --set ComputerName $(pwgen 32 1)
# defaults write NSGlobalDomain AppleHighlightColor "1.000000 0.874510 0.701961 Orange"
# defaults write NSGlobalDomain AppleAccentColor 1
# defaults write NSGlobalDomain AppleInterfaceStyle Dark
