#!/usr/bin/env bash
# battery_pct.sh - Example battery script for Waybar custom module (JSON)
# Reads from /sys/class/power_supply/BAT*/
set -euo pipefail

bat_dir=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1 || true)
if [[ -z "${bat_dir}" ]]; then
  echo '{"text":"󰂎 n/a","class":"unknown","tooltip":"No battery detected"}'
  exit 0
fi

cap=$(<"${bat_dir}/capacity")
stat=$(<"${bat_dir}/status")

icon="󰁺"
if (( cap >= 95 )); then icon="󰁹";
elif (( cap >= 80 )); then icon="󰂂";
elif (( cap >= 60 )); then icon="󰂀";
elif (( cap >= 40 )); then icon="󰁾";
elif (( cap >= 20 )); then icon="󰁼";
else icon="󰁺"; fi

cls=""
[[ "$stat" == "Charging" ]] && cls="charging"
if (( cap <= 30 )); then cls="warning"; fi
if (( cap <= 15 )); then cls="critical"; fi

text="${icon} ${cap}%"
[[ "$stat" == "Charging" ]] && text="󰂄 ${cap}%"

tooltip="Battery: ${cap}%\nStatus: ${stat}\nDevice: $(basename "$bat_dir")"

jq -cn --arg t "$text" --arg c "$cls" --arg tt "$tooltip" '{text:$t, class:$c, tooltip:$tt}' 2>/dev/null || \
  printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$cls" "$tooltip"
