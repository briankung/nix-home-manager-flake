{ pkgs, ... }: {
  home.username = "brian"; # REPLACE ME
  home.homeDirectory = "/Users/brian"; # REPLACE
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Brian Kung";
    userEmail = "brian.kung@backpacknetworks.com";
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    extraConfig = {
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = true; };
    };
    delta = { enable = true; };
    aliases = {
      co = "checkout";
      cleanbr =
        "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
    };
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
    initExtra =
      builtins.readFile ./zshrc + builtins.readFile ./wk-zshrc;
  };

  home.packages = [
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.libiconv
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodejs-16_x
    pkgs.nodePackages.sql-formatter
    pkgs.nodePackages_latest.mermaid-cli
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.ponysay
    pkgs.ripgrep
    pkgs.rsync
    pkgs.ruby_3_1
    pkgs.tree
    pkgs.wget
    pkgs.zbar
  ];
}