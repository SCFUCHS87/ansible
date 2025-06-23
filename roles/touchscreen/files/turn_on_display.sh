#!/bin/bash
# Forces HDMI display on using xset

export DISPLAY=:0

if ! command -v xset &>/dev/null; then
  echo "xset not found. Is x11-xserver-utils installed?" >&2
  exit 1
fi

xset dpms force on || {
  echo "Failed to turn on display." >&2
  exit 1
}
