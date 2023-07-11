#!/usr/bin/env bash

set -euo pipefail

echo 'Updating RPM packages to latest...'
dnf update -y

echo 'Install additional RPM packages...'
dnf install -y vim-enhanced zsh

echo 'Installing Starship prompt...'
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/bin

echo 'Cleanup...'
dnf clean all
