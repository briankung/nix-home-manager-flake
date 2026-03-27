{ pkgs, ... }: {
  home.username = "brian";
  home.homeDirectory = "/Users/brian";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    ignores = [ "*~" ".DS_Store" ".direnv" ".env" ".rgignore" ];
    settings = {
      user.name = "Brian Kung";
      user.email = "github@briankung.xyz";
      init = { defaultBranch = "main"; };
      pull = { ff = "only"; };
      push = { autoSetupRemote = true; };
      alias = {
        co = "checkout";
        clear = "!git reset . && git co . && git sweep";
        cleanbr =
          "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
        sweep = "clean -fd";
      };
    };
  };

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ./zshrc;
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
      yolo = "claude --dangerously-skip-permissions";
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        extraOptions = {
          IgnoreUnknown = "UseKeychain";
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
        };
        identityFile = "~/.ssh/id_ed25519";
      };

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

  home.packages = [
    # Fonts
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.meslo-lg

    # Nix dev tools
    pkgs.nil
    pkgs.nixfmt
    pkgs.nix-bash-completions

    # Shell utilities
    pkgs.coreutils
    pkgs.fd
    pkgs.gnused
    pkgs.htop
    pkgs.hyperfine
    pkgs.just
    pkgs.ripgrep
    pkgs.rsync
    pkgs.tree
    pkgs.watchexec
    pkgs.wget

    # Data / databases
    pkgs.csvlens
    pkgs.nodePackages.sql-formatter
    pkgs.postgresql
    pkgs.qsv
    pkgs.schemaspy
    pkgs.sqlcipher # for Signal desktop db

    # Media / documents
    pkgs.dua
    pkgs.exiftool
    pkgs.ffmpeg_7-full
    pkgs.ghostscript
    pkgs.imagemagick
    pkgs.mediainfo
    pkgs.poppler-utils

    # Security
    pkgs.git-crypt
    pkgs.gitleaks

    # Misc
    pkgs.adguardian
    pkgs.fortune
    pkgs.glow
    pkgs.html-tidy
    pkgs.libiconv
    pkgs.qrencode
    pkgs.sccache
    pkgs.shellcheck
    pkgs.zbar # bar code reader
  ];
}
