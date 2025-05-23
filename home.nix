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
      # Directory navigation helpers
      dl = "cd ~/Downloads";
      play-nix = "cd ~/.config/nix";
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
      st = "git stash";
      gsl = "git stash list";
      pop = "git stash pop";
      gcane = "git commit --amend --no-edit";

      # miscellaneous
      html-formatter =
        "tidy -indent --indent-spaces 2 -quiet --show-body-only yes";
      qr = "qrencode -m 2 -t utf8";
      emoji =
        "curl -s 'http://www.unicode.org/Public/emoji/1.0/emoji-data.txt' | rg -v '^#' | rg '\\((.)\\)' -or '$1' | shuf -n1 | tr -d '\\n' | pbcopy";
      readme = "glow $(fd -d1 readme\\.md)";
      ## Open modified files
      mod = "code .  && code $(git status --porcelain | awk '{print $2}')";
      shuo = "say -v TingTing";

      go = "cd $(fd --exclude Library -td . ~/ | fzf)";
      cri = "crystal i";
    };
  };

  programs.ssh = {
    enable = false;

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
      IgnoreUnknown = "UseKeychain";
      AddKeysToAgent = "yes";
      UseKeychain = "yes";
      IdentityFile = "~/.ssh/id_ed25519";
    };
  };

  programs.bat = {
    enable = true;
    config = { theme = "Monokai Extended"; };
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
    pkgs.adguardian
    pkgs.coreutils
    pkgs.csvlens
    pkgs.dua
    pkgs.exiftool
    pkgs.fd
    pkgs.ffmpeg_7-full
    pkgs.fortune
    pkgs.ghostscript
    pkgs.git-crypt
    pkgs.gitleaks
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
    pkgs.nixfmt-classic
    pkgs.nodePackages.sql-formatter
    pkgs.poppler_utils
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.rsync
    pkgs.sccache
    pkgs.schemaspy
    pkgs.shellcheck
    pkgs.sqlcipher # for Signal desktop db
    pkgs.tree
    pkgs.watchexec
    pkgs.wget
    pkgs.qrencode
    pkgs.xsv
    pkgs.zbar # bar code reader
  ];
}
