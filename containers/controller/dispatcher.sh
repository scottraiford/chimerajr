#!/bin/sh

while true; do
  if read -r line ; then
    # This will be smarter in the future... but for now, this should work.
    echo "Line is $line"
    berryc cycle_focus
  fi
done < /tmp/gestures
