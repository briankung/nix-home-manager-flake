# Enable Cargo
. "$HOME/.cargo/env"

if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh --disable-up-arrow)"
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
  yt-dlp --write-auto-subs --sub-lang en -o "%(playlist)s [%(playlist_id)s]/%(playlist_index)s - %(title).150s - [%(id)s].%(ext)s" "$1";
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

# make sure ccase is installed https://github.com/rutrum/ccase
sc() {
    if command -v ccase >/dev/null 2>&1; then
        ccase -tsnake "$*"
    else
        echo "ccase is not installed: https://github.com/rutrum/ccase"
    fi
}

# Sum a list of numbers, one per line
sum() {
    paste -s -d+ - | bc
}

# $1 is the hex key to decode the db
# $2 is the sql query to run
querySignalDb() {
    sqlcipher -json -header -readonly ~/Library/Application\ Support/Signal/sql/db.sqlite "pragma key = \"x'$1'\"; $2;" | jq
}

# For quickly switching to a linear ticket
goticket() {
    local selected=$(
      curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: $LINEAR_API_TOKEN" \
        https://api.linear.app/graphql \
        --data '{"query": "query { viewer { assignedIssues(first: 100) { nodes { identifier title state { name } priority createdAt } } } }"}' \
        | jq -r '.data.viewer.assignedIssues.nodes[] | [.identifier, .state.name, .title] | @tsv' \
        | fzf
    )

    if [[ -n "$selected" ]]; then
        local branch_name=$(echo "brian/$selected" | cut -f1)

        if git rev-parse --verify "$branch_name" >/dev/null 2>&1 || \
           git rev-parse --verify "origin/$branch_name" >/dev/null 2>&1; then
            git checkout "$branch_name"
        else
            git checkout -b "$branch_name"
        fi
    else
        return 1
    fi
}

# Activate uv if uv is initialized
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin:~/.local/bin:/Users/$(whoami)/.local/bin"
export PATH="$LOCAL_BIN_PATHS:$PATH"
