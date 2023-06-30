#!/usr/bin/bash

set -x

mkdir -p /var/opt

filename='mullvad.rpm'
curl -L https://mullvad.net/download/app/rpm/latest -o "$filename"
rpm-ostree install -y "$filename"
rm -f "$filename"

mv /var/opt/Mullvad\ VPN /usr/lib/
echo 'L "/opt/Mullvad VPN" - - - - "../../usr/lib/Mullvad VPN"' > /usr/lib/tmpfiles.d/mullvad-vpn.conf
