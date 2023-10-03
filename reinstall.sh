#!/usr/bin/env sh
set -e

# Uninstall nix
echo "Uninstalling nix"
/nix/nix-installer uninstall

# Reinstall nix
echo "Reinstalling nix"
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Set up profiles and gcroots directories
echo "Setting up directories"
sudo mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
sudo chown -R $USER:nixbld /nix/var/nix/profiles/per-user/$USER

#
echo "Set up nix"
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# Reinstall home-manager
echo "Reinstalling home-manager"
nix run ".#homeConfigurations.$(scutil --get LocalHostName).activationPackage"

echo "\n\nRun \`. ~/.zshrc\` to load your nix environment"
