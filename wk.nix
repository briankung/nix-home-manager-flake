{ pkgs, lib, ... }: {
  programs.git.userEmail = lib.mkForce "brian.kung@backpacknetworks.com";

  programs.zsh.initExtra =
    lib.mkForce ((builtins.readFile ./zshrc) + (builtins.readFile ./wk-zshrc));

  programs.zsh.sessionVariables = lib.mkForce {
    BPN_JWT_ROLE = "admin";
    BPN_JWT_USER_ID = "1219";
  };

  home.packages = lib.mkAfter [
    pkgs.git-crypt
    pkgs.git-filter-repo
    pkgs.google-cloud-sdk
    pkgs.heroku
    pkgs.kustomize
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.sbt
    pkgs.sshuttle
  ];
}
