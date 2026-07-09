#!/usr/bin/env bash
set -euo pipefail

_error_handler() {
    local status=$?
    echo >&2 "$0: Error on line $1: $2"
    exit $status
}
trap '_error_handler "$LINENO" "$BASH_COMMAND"' ERR

### Install nix in multi-user mode (macOS)
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --yes

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    echo "Sourcing nix-daemon"
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

### Verify nix is working
nix --version

### Run home-manager switch using the flake
nix run home-manager/master -- switch --flake "$HOME/.config/home-manager#toni" --impure
