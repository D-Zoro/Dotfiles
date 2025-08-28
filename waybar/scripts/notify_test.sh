#!/usr/bin/env bash
# notify_test.sh - Send a test notification to verify your center works
# Requirements: libnotify (notify-send)

summary="Neo-Cyber Test"
body="If you can read this, your notification daemon is working."

notify-send -a "Waybar" -u low -i dialog-information "$summary" "$body"
