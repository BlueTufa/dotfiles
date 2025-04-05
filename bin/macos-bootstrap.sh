#! /bin/bash

# This file is a reference for use getting a clean MacOS install started.
# Note that this file is not particularly useful assuming you plan to use brew
# to install git, etc.  


xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle

sudo sysadminctl -afpGuestAccess off
sudo sysadminctl -smbGuestAccess off
sudo sysadminctl -guestAccount off

sudo scutil --set HostName $(pwgen 32 1)
sudo scutil --set ComputerName $(pwgen 32 1)
