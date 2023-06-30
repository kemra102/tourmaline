#!/usr/bin/bash

ln -s /var/opt/Mullvad\ VPN /opt/Mullvad\ VPN

filename='mullvad.rpm'
curl -L https://mullvad.net/download/app/rpm/latest -o "$filename"
rpm-ostree install -y "$filename"
rm -f "$filename"
