# Enable Cargo
. "$HOME/.cargo/env"

if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

if command -v bat >/dev/null 2>&1; then
    eval "alias cat=bat"
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init - zsh)"
fi

if command -v sccache >/dev/null 2>&1; then
    export RUSTC_WRAPPER="$(command -v sccache)";
fi

# Enable starship
## Taken from https://stackoverflow.com/a/677212/1042144
if command -v starship >/dev/null 2>&1; then
    source <(starship init zsh --print-full-init)
fi

function gclo() {
    local URI="$1";
    local REPO=$(echo "$URI" | rg 'github\.com[:/](.+)\.git' -or '$1');
    git clone "git@github.com:$REPO" "$REPO";
}

# For Syncthing, which is installed via the GitHub release and configured to
# sync $HOME/Sync across all machines
function sync-local() {
    local FILE="$1";
    cp "$FILE" $HOME/Sync
}

function code-fzf() {
    # Set to default value if no argument provided
    local DIR="${1:-$HOME/Code}"
    code $(fd -td . $DIR | fzf)
}

function yt-dlp-playlist() {
  yt-dlp --all-subs -o "%(playlist)s [%(playlist_id)s]/%(playlist_index)s - %(title).150s - [%(id)s].%(ext)s" "$1";
}

# Search git for log entries with a certain input and then display all the files
# that were touched in those commits
git-grep-files() {
    if [ "$#" -lt 1 ]; then
        echo "Search git for log entries with a certain input and then display all the files that were touched in those commits"
        echo "No git grep regex supplied, exiting"
        return 0
    fi

    git log \
        -E \
        --grep=$1 \
        --pretty=format:'%h' |
        xargs \
        -I{} \
        git show --pretty="" --name-only {} |
        sort |
        uniq
}

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
