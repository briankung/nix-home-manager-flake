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

if command -v codium >/dev/null 2>&1; then
    alias code=codium
fi

if command -v /Users/brian/.codeium/windsurf/bin/windsurf >/dev/null 2>&1; then
    alias ws=/Users/brian/.codeium/windsurf/bin/windsurf
fi

function gclo() {
    local URI="$1";
    local REPO=$(echo "$URI" | rg 'github\.com[:/](.+)(\.git)?' -or '$1');
    git clone "git@github.com:$REPO" "$REPO";
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

showtickets() {
    curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: $LINEAR_API_TOKEN" \
        https://api.linear.app/graphql \
        --data @- <<'EOF' |
{
  "query": "query {
    viewer {
      assignedIssues(first: 100) {
        nodes {
          identifier
          title
          state {
            name
          }
          estimate
          priority
          createdAt
          updatedAt
        }
      }
    }
  }"
}
EOF
        jq -r --from-file <(cat <<'JQ'
.data.viewer.assignedIssues.nodes
| sort_by(.updatedAt)
| .[]
| [
    .identifier,
    .state.name,
    (if .estimate then "✅ " + (.estimate|tostring) else "☑️ -" end),
    .title[0:50],
    .updatedAt[0:10]
  ]
| @csv
JQ
        ) |
        xsv table
}
alias shot="showtickets"

# As in "what am I working on again + maximum derp"
wat() {
    local ticket="$(git branch --show-current | rg 'brian/(.+)' -or '$1')"
    showtickets | rg $ticket
}

# For quickly switching to a linear ticket
goticket() {
    local selected=$(
      curl -s -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: $LINEAR_API_TOKEN" \
        https://api.linear.app/graphql \
        --data @- <<'EOF' |
{
  "query": "query {
    viewer {
      assignedIssues(first: 100) {
        nodes {
          identifier
          title
          state {
            name
          }
          estimate
          priority
          createdAt
          updatedAt
        }
      }
    }
  }"
}
EOF
        jq -r --from-file <(cat <<'JQ'
.data.viewer.assignedIssues.nodes
| sort_by(.updatedAt)
| .[]
| [
    .identifier,
    .state.name,
    (if .estimate then "✅ " + (.estimate|tostring) else "☑️ -" end),
    .title[0:50],
    .updatedAt[0:10]
  ]
| @tsv
JQ
        ) |
        fzf
    )

    if [[ -n "$selected" ]]; then
        local branch_name=$(echo "brian/$selected" | cut -f1)

        if git rev-parse --verify "$branch_name" >/dev/null 2>&1 || \
            git rev-parse --verify "origin/$branch_name" >/dev/null 2>&1; then
            git checkout "$branch_name"
        else
            git checkout stage
            git pull
            git checkout -b "$branch_name"
        fi
    else
        return 1
    fi
}
alias got="goticket"

pbreduce () {
  # Initialize variables
  local clipboard=""
  local separator=$'\n\n'

  # Clear clipboard to start fresh
  echo "" | pbcopy

  # Setup trap to exit gracefully
  trap "echo 'Exiting clipboard reducer'; return" INT TERM

  echo "Clipboard reducer started. Press Ctrl+C to exit."
  echo "Monitoring clipboard for changes..."

  while true; do
    current=$(pbpaste)
    if [[ "$clipboard" != "$current" && -n "$current" ]]; then
      if [[ -n "$clipboard" ]]; then
        clipboard+="$separator$current"
      else
        clipboard="$current"
      fi

      echo "$clipboard" | pbcopy
    fi
  done
}
alias pbr="pbreduce"

hardpull() {
  local head="$(git rev-parse --abbrev-ref HEAD)"
  git reset --hard "origin/$head"
}

q:() {
  ollama run "${OLLAMA_MODEL:-gemma3}" "You are a helpful assistant.\nAnswer this question.\nBe very brief.\n\n$*"
}

# Activate uv if uv is initialized
[[ -f "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

LOCAL_BIN_PATHS="/usr/local/bin:/usr/local/sbin:~/.local/bin:/Users/$(whoami)/.local/bin"

CARGO_BIN_PATH="/Users/$(whoami)/.cargo/bin"
if [[ -d $CARGO_BIN_PATH ]]; then
    LOCAL_BIN_PATHS="$LOCAL_BIN_PATHS:$CARGO_BIN_PATH"
fi

export PATH="$LOCAL_BIN_PATHS:$PATH"
