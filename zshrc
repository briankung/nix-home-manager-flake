# Enable Cargo
. "$HOME/.cargo/env"

# Enable starship
## Taken from https://stackoverflow.com/a/677212/1042144
if [ -x "$(command -v starship)" ]; then
    source <(starship init zsh --print-full-init)
fi

if [ -x "$(command -v atuin)" ]; then
    eval "$(atuin init zsh)"
fi

if [ -x "$(command -v sccache)" ]; then
    export RUSTC_WRAPPER="$(command -v sccache)";
fi

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
