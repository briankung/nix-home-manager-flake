#!/usr/bin/env sh

if [ -f "/nix/receipt.json" ]; then
  read -rp "nix is installed, uninstall? (y/n) " CONFIRM

  if [[ $CONFIRM == [yY] ]]; then
    /nix/nix-installer uninstall
  fi
fi

if [ ! -f "/nix/receipt.json" ]; then
  read -rp "Reinstall nix? (y/n) " CONFIRM

  if [[ $CONFIRM == [yY] ]]; then
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  fi
fi

read -rp "Set up home manager? (y/n) " CONFIRM

if [[ $CONFIRM == [yY] ]]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

  sudo mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
  sudo chown -R $USER:nixbld /nix/var/nix/profiles/per-user/$USER

  nix run .#homeConfigurations."$(scutil --get LocalHostName)".activationPackage
fi
