FROM berry
MAINTAINER Scott Raiford

# Working in /usr/src/controller
WORKDIR /usr/src/controller

# Install dependencies
RUN apk add python3 py3-pip i2c-tools xprop xrandr

# Include scripts in this directory
COPY . .

# Run startup script
ENTRYPOINT ["startup.sh"]
