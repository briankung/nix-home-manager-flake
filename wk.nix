{ pkgs, lib, ... }: {
  programs.git.userEmail = lib.mkForce "brian.kung@backpacknetworks.com";

  programs.zsh.initExtra =
    lib.mkForce ((builtins.readFile ./zshrc) + (builtins.readFile ./wk-zshrc));

  programs.zsh.sessionVariables = lib.mkForce {
    BPN_JWT_ROLE = "admin";
    BPN_JWT_USER_ID = "1219";
  };

  home.packages = lib.mkAfter [
    pkgs.google-cloud-sdk
    pkgs.heroku
    pkgs.kustomize
    pkgs.openapi-generator-cli
    pkgs.postgresql
    pkgs.git-crypt
    pkgs.git-filter-repo
    pkgs.nodePackages_latest.typescript-language-server

  ];
}
