#!/bin/sh

[ -e /tmp/gestures ] && rm /tmp/gestures
mkfifo -m a=rw /tmp/gestures

# Monitor gesture sensor for human imput
# Gestures are sent to the FIFO pipe
python3 gesture-sensor.py > /tmp/gestures &

# Monitor the FIFO pipe
# Commands are sent to berryc
while true; do
  if read -r line ; then
    # This will be smarter in the future... but for now, this should work.
    berryc cycle_focus
  fi
done < /tmp/gestures
