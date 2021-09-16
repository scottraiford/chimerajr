#!/bin/sh

[ -e /tmp/gestures ] && rm /tmp/gestures
mkfifo -m a=rw /tmp/gestures

# Monitor gesture sensor for human imput
# Gestures are sent to the FIFO pipe
python3 gesture-sensor.py > /tmp/gestures &

# Monitor the FIFO pipe
# Commands are sent to berryc
su chimerajr -c "sh dispatcher.sh" &

while [ true ]; do; sleep 1; done
