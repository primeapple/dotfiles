#!/bin/bash

set -euo pipefail

_error_handler() {
    local status=$?
    echo >&2 "$0: Error on line $1: $2"
    exit $status
}
trap '_error_handler "$LINENO" "$BASH_COMMAND"' ERR

OS=$(uname -s)

echo "## TEST: Cloning the dotfiles via YADM ##"
BRANCH="${BRANCH:-main}"
cd "$HOME"
yadm clone --no-bootstrap -b "$BRANCH" https://github.com/primeapple/dotfiles
yadm checkout "$HOME"
echo "## DONE"

###############################################################################

echo "## TEST: Checking if required directories and files exist"
directories=(".config/nvim" ".config/fish")
files=(".profile" ".vimrc")

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "Error: Directory $dir does not exist."
    exit 1
  fi
done

for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Error: File $file does not exist."
    exit 1
  fi
done
echo "## DONE"

###############################################################################

echo "## TEST: Executing bootstrap"
yadm bootstrap
echo "## DONE"

###############################################################################

echo "## TEST: README.md and LICENSE and .github/ should not be checked out"
if [ -f "README.md" ]; then
  echo "Error: README.md should not be checked out."
  exit 1
fi

if [ -f "LICENSE" ]; then
  echo "Error: LICENSE should not be checked out."
  exit 1
fi

if [ -d ".github" ]; then
  echo "Error: .github/ should not be checked out."
  exit 1
fi
echo "## DONE"

###############################################################################

echo "## TEST: package manager installed specified applications"
apps=("docker" "unzip" "zip")
for app in "${apps[@]}"; do
    if ! command -v "$app" > /dev/null 2>&1; then
        echo "Error: App $app was not installed by package manager"
        exit 1
    fi
done
echo "## DONE"

###############################################################################

echo "## TEST: nix installed specified applications via home-manager"
apps=("nix" "home-manager" "nvim" "bat" "eza")
for app in "${apps[@]}"; do
  if ! fish -c "command -v $app"; then
    echo "Error: App $app , installed by nix, is not yet available for fish."
    exit 1
  fi
done
echo "## DONE"

###############################################################################

echo "## TEST: xdg config dirs are created"
directories=("documents" "downloads" "music")
for directory in "${directories[@]}"; do
  if ! [ -d "$HOME/$directory" ]; then
    echo "Error: Directory $directory was not created by xdg-config-dirs."
    exit 1
  fi
done
echo "## DONE"

###############################################################################

echo "## TEST: SSH key is generated"
if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo "Error: SSH private key ~/.ssh/id_ed25519 does not exist."
    exit 1
fi

if [ ! -f ~/.ssh/id_ed25519.pub ]; then
    echo "Error: SSH public key ~/.ssh/id_ed25519.pub does not exist."
    exit 1
fi

if ! ssh-keygen -l -f ~/.ssh/id_ed25519.pub > /dev/null 2>&1; then
    echo "Error: SSH key is invalid."
    exit 1
fi
echo "## DONE"

###############################################################################

echo "## TEST: yadm status returns nothing"
yadm_status=$(yadm status --porcelain)
if [[ -n "$yadm_status" ]]; then
    echo "Error: yadm status is not clean:"
    echo "$yadm_status"
    yadm diff
    exit 1
fi
echo "## DONE"
