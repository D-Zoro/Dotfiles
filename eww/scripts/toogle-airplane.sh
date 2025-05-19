#!/bin/bash
# ~/.config/eww/scripts/toggle-airplane.sh

if nmcli radio all | grep -q "disabled"; then
    nmcli radio all on
    bluetoothctl power on
else
    nmcli radio all off
    bluetoothctl power off
fi