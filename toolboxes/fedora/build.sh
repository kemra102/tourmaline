#!/usr/bin/env bash

set -euo pipefail

echo 'Updating RPM packages to latest...'
dnf update -y

echo 'Install additional RPM packages...'
dnf install -y vim-enhanced zsh

echo 'Installing Visual Studio Code...'
cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
dnf install -y code

echo 'Installing Starship prompt...'
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/bin

echo 'Cleanup...'
dnf clean all
