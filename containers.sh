#!/bin/bash

# Build container images
echo "Building images"
podman build containers/berry/ -t berry
podman build containers/controller/ -t controller

# Make storage locations for containers that need them
mkdir /srv/containers/portainer_data

# Run Portainer
echo "Running Portainer..."
podman run -d -p 9000:9000 --privileged --name=portainer -v /run/podman/podman.sock:/var/run/docker.sock:Z -v /srv/containers/portainer_data:/data portainer/portainer-ce --admin-password=$hashed

# Run Berry
echo "Running Berry..."
podman run -d --name berry -v /home/chimerajr:/home/chimerajr -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY berry

# Run Controller
echo "Running Controller..."
podman run -d --name controller -v /home/chimerajr:/home/chimerajr -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY controller

# Create systemd unit files to rebuild containers on startup
echo "Creating unit files..."
pushd /usr/lib/systemd/system/
podman generate systemd -n --new -f portainer
podman generate systemd -n --new -f berry
podman generate systemd -n --new -f controller
popd

echo "Reloading and enabling systemd..."
systemctl daemon-reload
systemctl enable --now container-portainer.service
systemctl enable --now container-berry.service
systemctl enable --now container-controller.service
