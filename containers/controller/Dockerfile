FROM berry
MAINTAINER Scott Raiford

# Working in /usr/src/controller as root
WORKDIR /usr/src/controller
USER root

# Install dependencies
RUN apk add libx11-dev libxft-dev libxinerama-dev git make gcc libc-dev py3-pip python3-dev linux-headers python3 i2c-tools xprop xrandr xset 
RUN pip install smbus
RUN apk del libx11-dev libxft-dev libxinerama-dev git make gcc libc-dev py3-pip python3-dev linux-headers

# Include scripts in this directory
COPY . .

# Run startup script
ENTRYPOINT ["/bin/sh", "startup.sh"]
