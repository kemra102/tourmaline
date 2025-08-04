#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket

# Enable install to /opt
echo "Creating symlinks to fix packages that install to /opt"
# Create symlink for /opt to /var/opt since it is not created in the image yet
mkdir -p "/var/opt"
ln -fs "/var/opt"  "/opt"

# Create symlinks for each directory specified
OPTFIX=(Mullvad\ VPN)
for OPTPKG in "${OPTFIX[@]}"; do
    OPTPKG="${OPTPKG%\"}"
    OPTPKG="${OPTPKG#\"}"
    mkdir -p "/usr/lib/opt/${OPTPKG}"
    ln -fs "/usr/lib/opt/${OPTPKG}" "/var/opt/${OPTPKG}"
    echo "Created symlinks for ${OPTPKG}"
done


# Install simple packages
dnf5 -y install k3b flac ptyxis solaar zsh


# Remove simple packages
# dnf5 -y remove firefox firefox-langpacks


# Install Atuin
ATUIN_VERSION='18.8.0'
ATUIN_FILE_NAME="atuin-x86_64-unknown-linux-gnu" # without file extension
TMP_DIR=$(mktemp -d)

curl -sL "https://github.com/atuinsh/atuin/releases/download/v${ATUIN_VERSION}/${ATUIN_FILE_NAME}.tar.gz" --output - | tar -xzf - -C "$TMP_DIR"

cp "${TMP_DIR}/${ATUIN_FILE_NAME}/atuin" /usr/bin/

# Shell completions no longer included in release tarball
# So generate them now
/usr/bin/atuin gen-completions --shell zsh --out-dir /usr/share/zsh/site-functions/

rm -rf "$TMP_DIR"


# Disable Discover notifier as we automate updates in the background
if [[ -f /etc/xdg/autostart/org.kde.discover.notifier.desktop ]]; then
    rm -f /etc/xdg/autostart/org.kde.discover.notifier.desktop
fi


# Install Mullvad VPN
dnf5 -y config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
dnf5 -y install mullvad-vpn
systemctl enable mullvad-daemon.service


# Install Starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/bin


# Install VSCode
dnf5 -y config-manager addrepo --from-repofile=https://packages.microsoft.com/yumrepos/vscode/config.repo
dnf5 -y install code


# Install YADM
curl -fLo /usr/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /usr/bin/yadm
