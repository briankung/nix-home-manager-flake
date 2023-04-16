{ pkgs, ... }: {
  home.username = "brian";
  home.homeDirectory = "/Users/brian";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Brian Kung";
    userEmail = "github@briankung.xyz";
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

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      # Default utils overrides
      cat = "bat";

      # Directory navigation helpers
      dl = "cd ~/Downloads";
      play-nix = "cd ~/.config/nixpkgs";
      wk = "cd $(fd . $HOME/Code --type=d --follow | fzf)";

      # Git aliases
      gs = "git status";
      gb = "git branch";
      gob = "git checkout $(git branch --format='%(refname:short)' | fzf)";
      gd = "git diff";
      gdc = "git diff --staged";
      ga = "git add";
      gp = "git push";
      gap = "git add -p";
      gl = "git log";
      gc = "git commit";

      # miscellaneous
      html-formatter = "tidy -indent --indent-spaces 2 -quiet --show-body-only yes";
    };
  };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      foundation = {
        host = "foundation";
        hostname = "foundation.local";
        user = "brian";
      };

      obsidian = {
        host = "obsidian";
        hostname = "obsidian.local";
        user = "brian";
      };

      platinum = {
        host = "platinum";
        hostname = "platinum.local";
        user = "brian";
      };
    };

    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      UseKeychain = "yes";
      IdentityFile = "~/.ssh/id_ed25519";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Monokai Extended";
    };
  };

  programs.atuin.enable = true;
  programs.direnv.enable = true;
  programs.fzf.enable = true;
  programs.helix.enable = true;
  programs.jq.enable = true;
  programs.pandoc.enable = true;
  programs.starship.enable = true;
  programs.yt-dlp.enable = true;

  home.packages = [
    pkgs.coreutils
    pkgs.dua
    pkgs.fd
    pkgs.ffmpeg_5-full
    pkgs.fortune
    pkgs.gnused
    pkgs.html-tidy
    pkgs.htop
    pkgs.hyperfine
    pkgs.imagemagick
    pkgs.libiconv
    pkgs.mediainfo
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodePackages.sql-formatter
    pkgs.nodePackages_latest.mermaid-cli
    pkgs.nodePackages_latest.typescript-language-server
    pkgs.ponysay
    pkgs.ripgrep
    pkgs.rsync
    pkgs.ruby_3_1
    pkgs.sccache
    pkgs.tree
    pkgs.wget
    pkgs.zbar
  ];
}
