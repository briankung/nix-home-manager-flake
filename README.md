# Nix Home Manager Flake

## Setup

1. Install the [DeterminateSystems/nix-installer](https://github.com/DeterminateSystems/nix-installer)

2. Clone this repo into your `~/.config` directory and `cd` into it
3. Run `nix run . && home-manager switch -b bak`

In the future just `nix run . && home-manager switch`

TODO: What does `nix run .` do vs `home-manager switch`?

Update with `nix flake update && home-manager switch`
