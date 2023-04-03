{ pkgs, ... }: {
  programs.git = {
    userEmail = mkForce "brian.kung@backpacknetworks.com";
  };

  programs.zsh = {
    initExtra = mkForce
      builtins.readFile ./zshrc + builtins.readFile ./wk-zshrc;
  };

  home.packages = [
    pkgs.google-cloud-sdk
  ];
}