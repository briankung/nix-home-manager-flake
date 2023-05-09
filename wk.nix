{ pkgs, lib, ... }: {
  programs.git.userEmail = lib.mkForce "brian.kung@backpacknetworks.com";

  programs.zsh.initExtra =
    lib.mkForce ((builtins.readFile ./zshrc) + (builtins.readFile ./wk-zshrc));

  home.packages = lib.mkAfter [ pkgs.google-cloud-sdk pkgs.heroku ];
}
