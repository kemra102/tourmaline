#!/usr/bin/env bash

set -euo pipefail

ATUIN_VERSION='18.4.0'
ATUIN_FILE_NAME="atuin-x86_64-unknown-linux-gnu" # without file extension
TMP_DIR=$(mktemp -d)

curl -sL "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/${ATUIN_FILE_NAME}.tar.gz" --output - | tar -xzf - -C "$TMP_DIR"

cp "${TMP_DIR}/${ATUIN_FILE_NAME}/atuin" /usr/bin/

# Shell completions no longer included in release tarball
# So generate them now
/usr/bin/atuin gen-completions --shell zsh --out-dir /usr/share/zsh/site-functions/

rm -rf "$TMP_DIR"
