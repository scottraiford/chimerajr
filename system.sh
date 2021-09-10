#!/usr/bin/bash
echo "Updating base system"
pacman -Syu

# Install podman with Docker compatibility
echo "Install Podman"
pacman -S --noconfirm podman podman-docker
systemctl enable --now podman.socket

# Configure podman to support docker.io registry
patch -N /etc/containers/registries.conf data/configs/registries.conf.patch

# Create container storage
mkdir -p /srv/containers
mkdir /srv/containers/portainer_data

# Hash admin password
hashed=$(podman run --rm httpd:2.4-alpine htpasswd -nbB admin $PORTAINER_ADMIN_PASSWORD | cut -d ":" -f 2)

# Install Portainer
podman run -d -p 9000:9000 --privileged --name=portainer --restart=always -v /run/podman/podman.sock:/var/run/docker.sock:Z -v /srv/containers/portainer_data:/data portainer/portainer-ce --admin-password=$hashed

# Install host X server
pacman -S --noconfirm xorg-server
