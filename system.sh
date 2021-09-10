#!/usr/bin/bash
echo "Updating base system"
pacman -Syu

# Install podman with Docker compatibility
echo "Install Podman"
pacman -S --noconfirm podman podman-docker

# Configure podman to support docker.io registry
patch -N /etc/containers/registries.conf data/configs/registries.conf.patch

# Install Portainer

# Install host X server
