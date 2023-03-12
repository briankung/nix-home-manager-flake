# Nix Home Manager Flake

## Setup

1. Install the [DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer):

    `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`
2. `cd ~/.config`
3. `git clone git@github.com:briankung/nix-home-manager-flake.git nixpkgs`
4. `cd nixpkgs`
3. Run `nix run . && home-manager switch -b bak`

In the future just `nix run . && home-manager switch`

TODO: What does `nix run .` do vs `home-manager switch`?

Update with `nix flake update && home-manager switch`
