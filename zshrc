# Enable Cargo
. "$HOME/.cargo/env"

# Enable starship
source <(/Users/brian/.nix-profile/bin/starship init zsh --print-full-init)

# Git aliases
alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gdc="git diff --staged"
alias ga="git add"
alias gp="git push"
alias gap="git add -p"
alias gl="git log"
alias gc="git commit"
alias dl="cd ~/Downloads"
alias play-nix="cd ~/.config/nixpkgs"
alias wk="cd ~/Code"

# Nix $PATH hackery, see:
# https://github.com/DeterminateSystems/nix-installer/issues/327

NIX_BIN_PATHS="/Users/brian/.nix-profile/bin:/nix/var/nix/profiles/default/bin"
export PATH="$NIX_BIN_PATHS:$PATH"
