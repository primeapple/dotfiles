#!/bin/bash
set -euo pipefail

mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "toni.mueller.web@mailbox.org" -f ~/.ssh/id_ed25519 -N ""
fi
