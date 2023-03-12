{ pkgs, ... }: {
  home.username = "brian"; # REPLACE ME
  home.homeDirectory = "/Users/brian"; # REPLACE
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    includes = [{ path = "~/.config/nixpkgs/gitconfig"; }];
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
  };
}