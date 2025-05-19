#!/bin/bash
# filepath: /home/neonpulse/.config/eww/scripts/toggle-control-center.sh

if eww list-windows | grep -q "control_center"; then
    eww open control_center
else
eww close control_center
    # eww open control_center
fi