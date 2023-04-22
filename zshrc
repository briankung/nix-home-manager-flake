# Enable Cargo
. "$HOME/.cargo/env"

# Enable starship
## Taken from https://stackoverflow.com/a/677212/1042144
if [ -x "$(command -v starship)" ]; then
    source <(starship init zsh --print-full-init)
fi

if [ -x "$(command -v atuin)" ]; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if [ -x "$(command -v sccache)" ]; then
    export RUSTC_WRAPPER="$(command -v sccache)";
fi

if [ -x "$(command -v direnv)" ]; then
    eval "$(direnv hook zsh)"
fi

function gclo() {
    local URI="$1";
    local REPO=$(echo "$URI" | rg 'github\.com[:/](.+)\.git' -or '$1');
    git clone "git@github.com:$REPO" "$REPO";
}

# For Syncthing, which is installed via the GitHub release and configured to
# sync $HOME/Sync across all machines
function sync-local() {
    local file="$1";
    mv "$file" $HOME/Sync
}

function yt-dlp-playlist() {
  yt-dlp --all-subs -o "%(playlist)s [%(playlist_id)s]/%(playlist_index)s - %(title).150s - [%(id)s].%(ext)s" "$1";
}

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
