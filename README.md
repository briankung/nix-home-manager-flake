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

## Troubleshooting

[opening lock file '/nix/var/nix/profiles/per-user/root/home-manager.lock': No such file or directory · Issue #3734 · nix-community/home-manager](https://github.com/nix-community/home-manager/issues/3734)

> > I'm on a Kali linux host, and I could solve this issue by doing:
> >
> >     mkdir -m 0755 -p /nix/var/nix/{profiles,gcroots}/per-user/$USER
> >
>
> Similarly, the following worked for me: `sudo chown -R $USER:nixbld /nix/var/nix/profiles/per-user/$USER`

## Justfile

You can also use [`just`](https://github.com/casey/just) to run common commands. Running `just` by itself will output this readme and the available recipes.