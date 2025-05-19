#!/bin/bash
# ~/.config/eww/scripts/toggle-wifi.sh

if nmcli radio wifi | grep -q "enabled"; then
    nmcli radio wifi off
    echo "off"
else
    nmcli radio wifi on
    echo "on"
fi