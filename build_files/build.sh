#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
#dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

## Install packages
dnf5 -y install @base-x @fonts @hardware-support \
  gdm \
  gnome-session \
  gnome-shell \
  gnome-control-center \
  gnome-software \
  nautilus \
  gnome-terminal \
  gnome-text-editor \
  file-roller \
  gnome-disk-utility \
  gnome-system-monitor \
  NetworkManager-bluetooth \
  pipewire \
  wireplumber \
  xdg-desktop-portal-gnome \
  scx-manager

## Remove packages
#dnf5 -y remove 

# Create Flatpak list
cat << 'EOF' > /usr/share/rakuos/flatpaks.list
# RakuOS KDE default apps
org.mozilla.firefox
org.gnome.Calculator
org.gnome.Calendar
org.gnome.Evince
org.gnome.Loupe
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
EOF

## Enable Services
systemctl enable gdm.service