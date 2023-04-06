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

  programs.zsh = lib.mkForce {
    enable = true;
    initExtra = builtins.readFile ./zshrc + builtins.readFile ./wk-zshrc;
    shellAliases = {
      # Directory navigation helpers
      dl = "cd ~/Downloads";
      play-nix = "cd ~/.config/nixpkgs";
      wk = "cd $(fd . $HOME/Code --type=d | fzf)";

      # Git aliases
      gs = "git status";
      gb = "git branch";
      gd = "git diff";
      gdc = "git diff --staged";
      ga = "git add";
      gp = "git push";
      gap = "git add -p";
      gl = "git log";
      gc = "git commit";
    };
  };

  home.packages = [ pkgs.google-cloud-sdk ];
}
