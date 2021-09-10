#!/usr/bin/bash

# Enable writing on the root filesystem
rw

# Install git
# Git already exists in base image
# pacman -S git

# Retrieve latest scripts for Chimera Jr.
cd /root
git clone https://github.com/scottraiford/chimerajr.git

# Execute system-level configuration
cd chimerajr
bash ./system.sh
