#!/usr/bin/bash

echo "Beginning installation of Chimera Jr. system..."

# Prompt for installation data
echo "Gathering installation data..."
if [ -z ${PORTAINER_ADMIN_PASSWORD+x} ]; then 
  read -s -P "Portainer admin password: " PORTAINER_ADMIN_PASSWORD
  export PORTAINER_ADMIN_PASSWORD
  echo
else
  echo "Portainer admin password already set"
fi

# Enable writing on the root filesystem
rw

# Install git
# Git already exists in base image
# pacman -S git

# Retrieve latest scripts for Chimera Jr.
cd /root
[ -d chimerajr ] && rm -rf chimerajr
git clone https://github.com/scottraiford/chimerajr.git

# Execute system-level configuration
cd chimerajr
bash ./system.sh
