#!/bin/bash
if nmcli radio wifi | grep -q "enabled"; then
    echo "on"
else
    echo "off"
fi
