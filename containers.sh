#!/bin/bash

# Build container images
podman build containers/berry/ -t berry

# Make storage locations for containers that need them
mkdir /srv/containers/portainer_data

# Run Portainer
podman run -d -p 9000:9000 --privileged --name=portainer --restart=always -v /run/podman/podman.sock:/var/run/docker.sock:Z -v /srv/containers/portainer_data:/data portainer/portainer-ce --admin-password=$hashed

# Run Berry
podman run --name berry --restart always -v /home/chimerajr:/home/chimerajr -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY berry

# Create systemd unit files to rebuild containers on startup
pushd /usr/lib/systemd/system/
podman generate systemd -n --new -f portainer
podman generate systemd -n --new -f berry
systemctl daemon-reload
systemctl enable --now container-portainer.service
systemctl enable --now container-berry.service
popd
