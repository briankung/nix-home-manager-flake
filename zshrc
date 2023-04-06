# Enable Cargo
. "$HOME/.cargo/env"

# Enable starship
source <(/Users/brian/.nix-profile/bin/starship init zsh --print-full-init)

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
