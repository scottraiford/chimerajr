#!/usr/bin/bash
echo "Updating base system"
pacman -Syu

# Install podman
echo "Install Podman"
pacman -S --noconfirm podman
