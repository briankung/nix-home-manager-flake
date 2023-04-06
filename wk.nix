{ pkgs, lib, ... }: {
  programs.git = lib.mkForce { userEmail = "brian.kung@backpacknetworks.com"; };

  programs.zsh = lib.mkForce {
    initExtra = builtins.readFile ./zshrc + builtins.readFile ./wk-zshrc;
  };

  home.packages = [ pkgs.google-cloud-sdk ];
}
