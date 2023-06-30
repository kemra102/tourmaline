#!/usr/bin/bash

filename='mullvad.rpm'
curl -L https://mullvad.net/download/app/rpm/latest -o "$filename"
rpm-ostree install -y "$filename"
rm -f "$filename"
