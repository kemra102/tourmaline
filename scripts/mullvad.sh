#!/usr/bin/bash

set -x

mkdir -p /var/opt/Mullvad\ VPN

ls -l /opt
ls -ld /opt
ls -l /var

filename='mullvad.rpm'
curl -L https://mullvad.net/download/app/rpm/latest -o "$filename"
rpm-ostree install -y "$filename"
rm -f "$filename"
