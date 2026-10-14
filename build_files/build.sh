#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)

# On the staging branch (RAKUOS_STAGING=1, set via --build-arg from CI)
# install the staging os-release identity instead of the stable one, so
# staging images identify themselves as "RakuOS GNOME Staging".
RAKUOS_RELEASE_PKG="rakuos-release-gnome"
if [ "${RAKUOS_STAGING:-0}" = "1" ]; then
    RAKUOS_RELEASE_PKG="rakuos-release-gnome-staging"
fi

# Terra ships disabled by default (third-party repos are opt-in), so enable
# it here in case any packages below come from Terra; post-build.sh disables
# it again before the image is finalized.
rum config-manager --default --set-enabled terra
# RPM Fusion is disabled in the base image too; turn its default repos back
# on (the list base post-build.sh recorded). post-build.sh disables them again.
rum config-manager --default --set-enabled $(cat /usr/share/rakuos/rpmfusion-default-repos)

## Install packages
rum install -y --skip-broken --skip-unavailable adw-gtk3-theme \
  file-roller \
  fprintd-pam \
  gdm \
  gnome-backgrounds \
  gnome-bluetooth \
  gnome-calculator \
  gnome-calendar \
  gnome-control-center \
  gnome-disk-utility \
  gnome-session \
  gnome-settings-daemon \
  gnome-shell \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-blur-my-shell \
  gnome-shell-extension-dash-to-dock \
  gnome-shell-extension-no-overview \
  gnome-system-monitor \
  gnome-text-editor \
  gnome-tweaks \
  gvfs-nfs \
  ibus-mozc \
  ibus-unikey \
  loupe \
  nautilus \
  NetworkManager-adsl \
  NetworkManager-bluetooth \
  NetworkManager-openconnect-gnome \
  NetworkManager-openvpn-gnome \
  NetworkManager-ppp \
  NetworkManager-vpnc-gnome \
  NetworkManager-wwan \
  papers \
  pipewire \
  ptyxis \
  ${RAKUOS_RELEASE_PKG} \
  rakuos-software-gtk \
  rakuos-system-gtk \
  rakuos-welcome-gtk \
  systemd-oomd-defaults \
  wireplumber \
  xdg-desktop-portal \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  xdg-user-dirs-gtk

## Remove packages
rum remove -y gnome-software-rpm-ostree gnome-tour gnome-extensions-app

## Compile GSettings schemas (picks up zz-rakuos-gnome.gschema.override)
glib-compile-schemas /usr/share/glib-2.0/schemas/

## Enable Services
systemctl enable gdm.service
