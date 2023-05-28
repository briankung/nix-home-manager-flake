# Nix Home Manager Flake

## Setup

1. Install the [DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer):

    `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`
2. `cd ~/.config`
3. `git clone git@github.com:briankung/nix-home-manager-flake.git nixpkgs`
4. `cd nixpkgs`
5. On first run home-manager isn't available, so you can use `nix run .#homeConfigurations.<homeConfiguration name>.activationPackage`. That may or may not work since you also need to source the `~/.zshrc` file and if one exists you'll need to pass the `-b / --backup <some file extension>` to `home-manager` as well.

    Ex: `nix run .#homeConfigurations.foundation.activationPackage`.
    Alternative example: `nix run . && home-manager switch --flake .#foundation -b bak`
6. Second runs are easier: `home-manager switch --flake .#<homeConfiguration name>`.

    Ex: `home-manager switch --flake .#foundation`
7. Source your updated ~/.zshrc file

    Ex: `. ~/.zshrc`

Update dependencies with `nix flake update .`

## Justfile

You can also use [`just`](https://github.com/casey/just) to run common commands. Running `just` by itself will output this readme and the available recipes.