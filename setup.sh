#!/usr/bin/env sh

nix run .#homeConfigurations."$(scutil --get LocalHostName)".activationPackage
