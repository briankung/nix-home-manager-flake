{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      withArch = arch: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${arch};
          inherit modules;
        };
    in {
      defaultPackage = {
        x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
        aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
        # aarch64-linux = home-manager.defaultPackage.aarch64-linux;
      };

      homeConfigurations = {
        "platinum"  = withArch "aarch64-darwin"  [ ./home.nix ];
        "obsidian"  = withArch "aarch64-darwin"  [ ./home.nix ./wk.nix ];
        "foundation" = withArch "x86_64-darwin"  [ ./home.nix ];
        # "???" = withArch "aarch64-linux" [ ./home.nix ];
      };
    };
}
