#!/usr/bin/bash

# Install git
pacman -S git

# Retrieve latest scripts for Chimera Jr.
cd /tmp
git clone https://github.com/scottraiford/chimerajr.git

# Execute system-level configuration
cd chimerajr
bash ./system.sh
