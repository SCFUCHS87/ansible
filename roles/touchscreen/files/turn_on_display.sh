#!/bin/bash
# turn_on_display.sh - Force HDMI display on using xset
# Used by systemd and udev when touchscreen input is detected

export DISPLAY=:0

if ! command -v xset &>/dev/null; then
  echo "xset not found. Is x11-xserver-utils installed?" >&2
  exit 1
fi

xset dpms force on || {
  echo "Failed to turn on display using xset" >&2
  exit 1
}
