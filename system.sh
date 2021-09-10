#!/usr/bin/bash
echo "Updating base system"
pacman -Syu

# Install podman with Docker compatibility
echo "Install Podman"
pacman -S --noconfirm podman podman-docker
systemctl enable --now podman.socket

# Configure podman to support docker.io registry
patch -N /etc/containers/registries.conf data/configs/registries.conf.patch

# Remove any existing containers
podman kill -a
podman rm -a

# Create container storage
mkdir -p /srv/containers
mkdir /srv/containers/portainer_data

# Hash admin password
hashed=$(podman run --rm httpd:2.4-alpine htpasswd -nbB admin $PORTAINER_ADMIN_PASSWORD | cut -d ":" -f 2)

# Install Portainer
podman run -d -p 9000:9000 --privileged --name=portainer --restart=always -v /run/podman/podman.sock:/var/run/docker.sock:Z -v /srv/containers/portainer_data:/data portainer/portainer-ce --admin-password=$hashed

# Install host X server
pacman -S --noconfirm xorg-server xf86-video-fbdev

# Create X unit file
cat <<EOF > /usr/lib/systemd/system/X.service
[Unit]
Description=X window server
After=network.target network-online.target nss-lookup.target

[Service]
Type=simple
Restart=always
RestartSec=3
AmbientCapabilities=CAP_NET_RAW
ExecStart=/usr/bin/X -nocursor
TimeoutStopSec=10
KillMode=mixed
Environment=XAUTHORITY=$XAUTHORITY
User=chimerajr
Group=chimerajr

[Install]
WantedBy=multi-user.target
EOF

# Create username for containers
groupadd -g 900 chimerajr
useradd -m -d /home/chimerajr -g chimerajr -u 900 chimerajr

# Create Xauthority file suitable for container use
# $XAUTHORITY is defined in install.sh
touch $XAUTHORITY
chown chimerajr:chimerajr $XAUTHORITY

# Allow non-root and non-console users to run X
cat <<EOF > /etc/X11/Xwrapper.config
allowed_users = anybody
needs_root_rights = auto
EOF

# Enable X on startup
systemctl daemon-reload
systemctl enable --now X.service
systemctl restart X.service

# Add a key to the XAuthority file
xauth generate :0 . trusted
