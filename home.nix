{ pkgs, ... }: {
  home.username = "brian"; # REPLACE ME
  home.homeDirectory = "/Users/brian"; # REPLACE
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];
  };

  home.packages = [
    pkgs.bat
    pkgs.comma
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.ponysay
    pkgs.ripgrep
    pkgs.ruby_3_1
    pkgs.starship
    pkgs.tree
    pkgs.wget
  ];

  programs.zsh = {
    enable = true;
    initExtra =
      builtins.readFile ./zshrc + builtins.readFile ./wk-zshrc;
  };
}