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

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
