#!/bin/bash

set -ouex pipefail

FEDORA_VERSION="${FEDORA_VERSION:-43}"

## Install packages
dnf5 -y install @fonts @hardware-support \
  gdm \
  gnome-session \
  gnome-shell \
  gnome-settings-daemon \
  gnome-backgrounds \
  gnome-control-center \
  gnome-initial-setup \
  NetworkManager-bluetooth \
  pipewire \
  wireplumber \
  xdg-desktop-portal-gnome

## Remove packages
dnf5 -y remove gnome-software-rpm-ostree

## Enable Services
systemctl enable gdm.service