{ pkgs, ... }: {
  home.username = "brian"; # REPLACE ME
  home.homeDirectory = "/Users/brian"; # REPLACE
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];
  };

  programs.atuin = {
    enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.pandoc = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
  };

  home.packages = [
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.libiconv
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.nodePackages.sql-formatter
    pkgs.nodePackages_latest.mermaid-cli
    pkgs.ponysay
    pkgs.ripgrep
    pkgs.rsync
    pkgs.ruby_3_1
    pkgs.tree
    pkgs.wget
    pkgs.zbar
  ];
}