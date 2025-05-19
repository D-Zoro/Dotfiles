#!/bin/bash
if nmcli radio all | grep -q "disabled"; then
    nmcli radio all on
    bluetoothctl power on
else
    nmcli radio all off
    bluetoothctl power off
fi
