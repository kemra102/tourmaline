#!/usr/bin/env bash

mkdir -p /usr/local/bin
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/local/bin
