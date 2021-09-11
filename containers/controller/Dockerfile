FROM berry
MAINTAINER Scott Raiford

# Working in /usr/src/controller as root
WORKDIR /usr/src/controller
USER root

# Install dependencies
RUN apk add python3 py3-pip i2c-tools xprop xrandr python3-dev linux-headers
RUN pip install smbus

# Include scripts in this directory
COPY . .

# Run startup script
ENTRYPOINT ["/bin/sh", "startup.sh"]
