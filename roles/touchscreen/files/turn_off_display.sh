#!/bin/bash
# Forces HDMI display off using xset

export DISPLAY=:0

if ! command -v xset &>/dev/null; then
  echo "xset not found. Is x11-xserver-utils installed?" >&2
  exit 1
fi

xset dpms force off || {
  echo "Failed to turn off display." >&2
  exit 1
}
