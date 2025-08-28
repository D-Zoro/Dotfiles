#!/usr/bin/env bash
# net_speed.sh - Show RX/TX speed for default network interface as Waybar custom module (JSON)
# Requirements: iproute2, coreutils, awk

set -euo pipefail

# Pick default interface from routing table, fallback to first non-lo up interface
get_iface() {
  local dev
  dev=$(ip route get 1.1.1.1 2>/dev/null | awk '{for (i=1;i<=NF;i++) if ($i=="dev") print $(i+1)}' | head -n1)
  if [[ -z "${dev:-}" ]]; then
    dev=$(ls -1 /sys/class/net 2>/dev/null | grep -v '^lo$' | head -n1)
  fi
  printf '%s' "$dev"
}

human() {
  local b=$1
  local spd
  if (( b < 1024 )); then spd="${b} B/s";
  elif (( b < 1024*1024 )); then spd="$(awk -v b=$b 'BEGIN{printf "%.1f", b/1024}') KiB/s";
  elif (( b < 1024*1024*1024 )); then spd="$(awk -v b=$b 'BEGIN{printf "%.1f", b/1024/1024}') MiB/s";
  else spd="$(awk -v b=$b 'BEGIN{printf "%.2f", b/1024/1024/1024}') GiB/s"; fi
  printf '%s' "$spd"
}

iface=$(get_iface)
if [[ -z "$iface" ]] || [[ ! -r "/sys/class/net/$iface/operstate" ]]; then
  echo '{"text":"󰖪 offline","class":"disconnected","tooltip":"No active interface"}'
  exit 0
fi

state_file="/tmp/waybar-net-${iface}-${UID}.state"
now=$(date +%s)
rx_now=$(<"/sys/class/net/$iface/statistics/rx_bytes")
tx_now=$(<"/sys/class/net/$iface/statistics/tx_bytes")

if [[ -f "$state_file" ]]; then
  read -r last_ts last_rx last_tx < "$state_file" || true
else
  last_ts=$now; last_rx=$rx_now; last_tx=$tx_now
fi

echo "$now $rx_now $tx_now" > "$state_file"

dt=$(( now - last_ts ))
(( dt <= 0 )) && dt=1

rx_rate=$(( (rx_now - last_rx) / dt ))
tx_rate=$(( (tx_now - last_tx) / dt ))

rx_h=$(human "$rx_rate")
tx_h=$(human "$tx_rate")

oper=$(<"/sys/class/net/$iface/operstate")
cls="ok"
[[ "$oper" != "up" ]] && cls="degraded"

text="󰅃 ${rx_h}  󰅀 ${tx_h}"

tooltip="Interface: ${iface}\nState: ${oper}\nRX: ${rx_rate} B/s\nTX: ${tx_rate} B/s"

jq -cn --arg t "$text" --arg tt "$tooltip" --arg c "$cls" '{text:$t, tooltip:$tt, class:$c}' 2>/dev/null || \
  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' "$text" "$tooltip" "$cls"
