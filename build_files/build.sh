#!/bin/bash

set -ouex pipefail

FEDORA_VERSION=$(rpm -E %fedora)

## Install packages
dnf5.real -y install @fonts @hardware-support \
  adw-gtk3-theme \
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
  rakuos-software-gtk \
  rakuos-welcome-gtk \
  scx-manager \
  systemd-oomd-defaults \
  wireplumber \
  xdg-desktop-portal \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  xdg-user-dirs-gtk

## Remove packages
dnf5.real -y remove gnome-software-rpm-ostree gnome-tour gnome-extensions-app

## Compile GSettings schemas (picks up zz-rakuos-gnome.gschema.override)
glib-compile-schemas /usr/share/glib-2.0/schemas/

## Enable Services
systemctl enable gdm.service
