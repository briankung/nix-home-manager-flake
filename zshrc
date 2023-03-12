# Enable Cargo
. "$HOME/.cargo/env"

# This was added for jsonresume to work
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`
export PATH="$HOME/.flutter/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/tools:$HOME/Library/Android/sdk/platform-tools:${PATH}"
# Erlang's rebar3
# export PATH="/Users/brian/.cache/rebar3/bin:$PATH"

alias gs="git status"
alias gd="git diff"
alias gdc="git diff --staged"
alias ga="git add"
alias gap="git add -p"
alias gl="git log"
alias gc="git commit"
alias wk="cd ~/Code"
alias dl="cd ~/Downloads"

