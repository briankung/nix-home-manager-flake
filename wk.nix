{ pkgs, lib, ... }: {
  programs.git = lib.mkForce {
    enable = true;
    userName = "Brian Kung";
    userEmail = "brian.kung@backpacknetworks.com";
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = true; };
    };
    aliases = {
      co = "checkout";
      cleanbr =
        "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
    };
  };

  programs.zsh.initExtra =
    lib.mkForce ((builtins.readFile ./zshrc) + (builtins.readFile ./wk-zshrc));

  home.packages = lib.mkAfter [ pkgs.google-cloud-sdk ];
}
