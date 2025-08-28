#!/usr/bin/env bash
# mpris_status.sh - Outputs current media status via playerctl for Waybar (JSON)
# Requirements: playerctl, awk, sed
set -euo pipefail

icon_paused=""
icon_playing=""
icon_stopped=""

# Determine status; if no players, print stopped
status=$(playerctl status -s 2>/dev/null || true)
if [[ -z "${status}" ]]; then
  printf '{"text":"%s","class":"stopped","tooltip":"No player"}\n' " —"
  exit 0
fi

artist=$(playerctl metadata artist 2>/dev/null || true)
title=$(playerctl metadata title 2>/dev/null || true)
album=$(playerctl metadata album 2>/dev/null || true)

truncate() { local s="$1"; local n="$2"; [[ ${#s} -le $n ]] && printf '%s' "$s" || printf '%s…' "${s:0:n}"; }

show_title=$(truncate "${title:-Unknown Title}" 40)
show_artist=$(truncate "${artist:-Unknown Artist}" 30)

case "$status" in
  Playing) icon="$icon_playing"; cls="playing";;
  Paused) icon="$icon_paused"; cls="paused";;
  *) icon="$icon_stopped"; cls="stopped";;
 esac

text="$icon ${show_artist} - ${show_title}"
tooltip="${artist:-Unknown Artist} — ${title:-Unknown Title}\nAlbum: ${album:-Unknown}"

jq -cn --arg t "$text" --arg c "$cls" --arg tt "$tooltip" '{text:$t, class:$c, tooltip:$tt}' 2>/dev/null || \
  printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' "$text" "$cls" "$tooltip"
