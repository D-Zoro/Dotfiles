#!/bin/bash
# ~/.config/eww/scripts/toggle-bluetooth.sh

if bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power off
    echo "off"
else
    bluetoothctl power on
    echo "on"
fi