#!/usr/bin/env bash

set -euo pipefail

ATUIN_VERSION='17.0.1'
ATUIN_FILE_NAME="atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu" # without file extension
TMP_DIR=$(mktemp -d)

curl -sL "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/${ATUIN_FILE_NAME}.tar.gz" --output - | tar -xzf - -C "$TMP_DIR"

cp "${TMP_DIR}/${ATUIN_FILE_NAME}/atuin" /usr/bin/
cp "${TMP_DIR}/${ATUIN_FILE_NAME}/completions/atuin.bash" /usr/share/bash-completion/completions/atuin
cp "${TMP_DIR}/${ATUIN_FILE_NAME}/completions/atuin.fish" /usr/share/fish/vendor_completions.d/
cp "${TMP_DIR}/${ATUIN_FILE_NAME}/completions/_atuin" /usr/share/zsh/site-functions/

rm -rf "$TMP_DIR"
