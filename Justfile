HOSTNAME := `scutil --get LocalHostName`

# List some information about the Justfile recipes
default:
    #!/usr/bin/env sh
    if command -v glow >/dev/null 2>&1; then
        glow README.md
    else
        cat README.md
    fi
    just --list --color never

# Initial setup for a new system. Most likely to break due to lack of use. Also
# probably won't have just available, but eh
setup:
    nix run.#homeConfigurations.{{ HOSTNAME }}.activationPackage

# For updating packages, e.g. when Atuin complains about being out of date
update:
    nix flake update .

# Reload after configuration changes
reload:
    home-manager switch --flake .#{{ HOSTNAME }}

# Run the nix garbage collector to save space
gc:
    nix-store --gc