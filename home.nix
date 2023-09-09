{ pkgs, ... }: {
  home.username = "brian";
  home.homeDirectory = "/Users/brian";
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

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
      clear = "!git reset . && git co . && git sweep";
      cleanbr =
        "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
      sweep = "clean -fd";
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = builtins.readFile ./zshrc;
    shellAliases = {
      glow = "cat";

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
      ggf = "git-grep-files"; # Alias to a custom function in zshrc

      # miscellaneous
      html-formatter =
        "tidy -indent --indent-spaces 2 -quiet --show-body-only yes";
      qr = "qrencode -m 2 -t utf8";
      emoji =
        "curl -s 'http://www.unicode.org/Public/emoji/1.0/emoji-data.txt' | rg -v '^#' | rg '\\((.)\\)' -or '$1' | shuf -n1 | tr -d '\\n'";
      readme = "glow -p $(fd -d1 readme\\.md)";
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
    config = { theme = "Monokai Extended"; };
  };

  # This is going to be deprecated and throw an error the next time nix flake update is run
  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
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
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
    pkgs.coreutils
    pkgs.dua
    pkgs.fd
    pkgs.ffmpeg_5-full
    pkgs.fortune
    pkgs.glow
    pkgs.gnused
    pkgs.html-tidy
    pkgs.htop
    pkgs.hyperfine
    pkgs.imagemagick
    pkgs.just
    pkgs.libiconv
    pkgs.mediainfo
    pkgs.nil
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodePackages.sql-formatter
    pkgs.ripgrep
    pkgs.rsync
    pkgs.sccache
    pkgs.schemaspy
    pkgs.shellcheck
    pkgs.sqlcipher # for Signal desktop db
    pkgs.tree
    pkgs.wget
    pkgs.qrencode
    pkgs.zbar # bar code reader
  ];
}
