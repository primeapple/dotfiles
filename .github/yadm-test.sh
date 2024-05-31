#!/bin/bash

set -eu

echo "## TEST: Cloning the dotfiles via YADM ##"
yadm clone --no-bootstrap https://github.com/primeapple/dotfiles
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

# echo "## TEST: fish is the default shell"
# if [ $(basename "$SHELL") != "fish" ]; then
#   echo "Error: fish is not the default shell."
#   exit 1
# fi
# echo "## DONE"

###############################################################################

echo "## TEST: fisher is installed"
if ! fish -c "fisher --version" >/dev/null 2>&1; then
  echo "Error: fisher is not installed."
  exit 1
fi
echo "## DONE"

###############################################################################

echo "## TEST: pacman installed specified applications"
apps=("nvim" "bat" "eza")
for app in "${apps[@]}"; do
  if ! command -v "$app"; then
    echo "Error: App $app was not installed by pacman."
    exit 1
  fi
done
echo "## DONE"

###############################################################################

echo "## TEST: xdg config dirs are created"
directories=("documents" "downloads" "music")
for directory in "${directories[@]}"; do
  if ! [ -d "$directory" ]; then
    echo "Error: Directory $directory was not created by xdg-config-dirs."
    exit 1
  fi
done
echo "## DONE"
