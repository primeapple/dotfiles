#!/bin/bash

### Docker, see https://docs.docker.com/engine/install/debian/
sudo apt remove "$(dpkg --get-selections docker.io docker-compose docker-doc podman-docker containerd runc | cut -f1)"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

docker_packages=(
    "containerd.io"
    "docker-buildx-plugin"
    "docker-ce"
    "docker-ce-cli"
    "docker-compose-plugin"
)

base_packages=(
    "fish"
    "openssh-client"
    "tree-sitter-cli"
    "unzip"
    "xdg-user-dirs"
    "zip"
)

sudo apt update
sudo apt install --assume-yes "${base_packages[@]}" "${docker_packages[@]}"
