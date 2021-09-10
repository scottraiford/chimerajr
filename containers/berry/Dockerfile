FROM alpine:latest
MAINTAINER Scott Raiford

# TODO: This is bad. There's something wrong with certificates in the Alpine base image.
RUN sed -i 's/https/http/g' /etc/apk/repositories
RUN apk update
RUN apk upgrade

# Source code will be in /usr/src/berry
WORKDIR /usr/src

# Install berry dependencies
# TODO: libc-dev may not be strictly necessary. Musl-dev might be all that's needed.
RUN apk add libx11-dev libxft-dev libxinerama-dev git make gcc libc-dev

# Build berry window manager
RUN git clone https://github.com/JLErvin/berry
WORKDIR /usr/src/berry
RUN make && make install

# Create nonroot user
VOLUME /home/chimerajr
RUN groupadd -g 900 chimerajr && useradd -m -d /home/chimerajr -g chimerajr -u 900 chimerajr

USER chimerajr

# Prepare connection to host X server
ENV DISPLAY=:0

# Run berry
ENTRYPOINT ["berry"]
