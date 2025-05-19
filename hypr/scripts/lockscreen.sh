#!/bin/bash
# filepath: /home/neonpulse/.config/hypr/scripts/lockscreen.sh

TMPBG="/tmp/screen.png"
ARCH_LOGO="$HOME/.config/hypr/scripts/arch-neon.png" # Use a bright, high-contrast neon purple logo here
             
# Take a screenshot (no convert/blur step for speed)
grim "$TMPBG"

# Lock screen with swaylock-effects, let swaylock blur and show logo
swaylock \
    --image " $TMPBG" \
    --effect-blur 12x6 \
    --effect-vignette 0.5:0.5 \
    --indicator \
    --indicator-radius 150 \
    --indicator-thickness 22 \
    --indicator-image "$ARCH_LOGO" \
    --indicator-caps-lock \
    --ring-color bb00ffff \
    --ring-ver-color 0077ffff \
    --ring-wrong-color 990022ee \
    --key-hl-color 00ff88ff \
    --line-color 00000000 \
    --inside-color 12003acc         # Darker blue (main idle color)
    # --inside-ver-color 0077ffff \        # Neon blue (verifying)
    # --inside-wrong-color 990022ee \      # Dark red (wrong)
    # --inside-clear-color ffc800ee \      # Yellow (cleared)
    # --separator-color 00000000 \
    # --text-color ffffffff \
    # --text-caps-lock-color bb00ffff \
    # --font-size 22

rm "$TMPBG"
