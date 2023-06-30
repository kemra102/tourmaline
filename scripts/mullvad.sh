#!/usr/bin/bash

filename='mullvad.rpm'
curl -L https://mullvad.net/download/app/rpm/latest -o "$filename"
dnf install -y "$filename"
rm -f "$filename"
