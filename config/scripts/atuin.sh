#!/usr/bin/env bash

ATUIN_VERSION='17.0.1'
TMP_DIR=$(mktemp -d)

curl -s "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu.tar.gz" | tar -xzf - -C "$TMP_DIR"

cp "${TMP_DIR}/atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu/atuin" /usr/bin/
cp "${TMP_DIR}/atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu/completions/atuin.bash" /usr/share/bash-completion/completions/atuin
cp "${TMP_DIR}/atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu/completions/atuin.fish" /usr/share/fish/vendor_completions.d/
cp "${TMP_DIR}/atuin-v${ATUIN_VERSION}-x86_64-unknown-linux-gnu/completions/_atuin" /usr/share/zsh/site-functions/

rm -rf "$TMP_DIR"
