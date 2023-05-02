#!/usr/bin/env bash

# Enable starship COPR repo
AUTHOR='atim'
REPONAME='starship'
RELEASE=$(rpm -E %fedora)

curl -fsSL "https://copr.fedorainfracloud.org/coprs/${AUTHOR}/${REPONAME}/repo/fedora-${RELEASE}/${AUTHOR}-${REPONAME}-fedora-.repo" | sudo tee "/etc/yum.repos.d/${AUTHOR}-${REPONAME}.repo"
rpm-ostree install starship
