#!/bin/bash

# Neo Purple Theme Setup Script
echo "🟣 Setting up Neo Purple Theme..."

# Create GTK config directories
mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0

# Backup existing gtk.css if it exists
if [ -f ~/.config/gtk-3.0/gtk.css ]; then
    mv ~/.config/gtk-3.0/gtk.css ~/.config/gtk-3.0/gtk.css.backup
    echo "📦 Backed up existing GTK-3.0 theme"
fi

if [ -f ~/.config/gtk-4.0/gtk.css ]; then
    mv ~/.config/gtk-4.0/gtk.css ~/.config/gtk-4.0/gtk.css.backup
    echo "📦 Backed up existing GTK-4.0 theme"
fi

# Create the Neo Purple GTK theme
cat > ~/.config/gtk-3.0/gtk.css << 'EOF'
/* Neo Purple GTK Theme - Cyberpunk Inspired (Matching Wofi) */

/* Global window styling */
window {
    background-color: rgba(12, 0, 18, 0.85);
    color: #bb00ff;
    font-family: "JetBrains Mono", monospace;
}

/* Main backgrounds */
.background {
    background: linear-gradient(135deg, 
        rgba(12, 0, 18, 0.85) 0%, 
        rgba(20, 0, 30, 0.85) 50%, 
        rgba(12, 0, 18, 0.85) 100%);
}

/* Headers and titlebars */
headerbar,
.titlebar {
    background: linear-gradient(90deg, 
        rgba(40, 0, 60, 0.9) 0%, 
        rgba(60, 0, 80, 0.9) 100%);
    border: 2px solid #bb00ff;
    border-radius: 12px 12px 0 0;
    box-shadow: 0 0 15px rgba(187, 0, 255, 0.4);
    color: #bb00ff;
    text-shadow: 0 0 5px rgba(153, 0, 204, 0.8);
}

/* Buttons */
button {
    background: linear-gradient(100deg, 
        rgba(40, 0, 60, 0.6) 0%, 
        rgba(60, 0, 80, 0.6) 100%);
    border: 2px solid #bb00ff;
    border-radius: 10px;
    color: #bb00ff;
    padding: 8px 16px;
    transition: all 0.2s ease;
    text-shadow: 0 0 3px rgba(153, 0, 204, 0.6);
}

button:hover {
    background: linear-gradient(100deg, #bb00ff 0%, #9900cc 100%);
    box-shadow: 0 0 10px rgba(187, 0, 255, 0.5);
    color: #ffffff;
}

button:active {
    background: linear-gradient(100deg, #9900cc 0%, #bb00ff 100%);
    transform: scale(0.98);
}

/* Entry fields */
entry {
    background-color: rgba(40, 0, 60, 0.6);
    border: 2px solid #bb00ff;
    border-radius: 10px;
    color: #ffffff;
    padding: 8px 16px;
    box-shadow: inset 0 0 6px rgba(187, 0, 255, 0.4);
    transition: all 0.2s ease;
}

entry:focus {
    border: 2px solid #ff36e3;
    background-color: rgba(60, 0, 80, 0.7);
    box-shadow: inset 0 0 10px rgba(255, 54, 227, 0.5);
}

/* THUNAR SPECIFIC */
.thunar {
    background: linear-gradient(135deg, 
        rgba(8, 0, 14, 0.95) 0%, 
        rgba(15, 0, 25, 0.95) 50%, 
        rgba(8, 0, 14, 0.95) 100%);
    border-radius: 16px;
    border: 2px solid #bb00ff;
    box-shadow: 0 0 20px rgba(187, 0, 255, 0.6);
}

/* Top Menu Bar (File, Edit, View) fixes */
.thunar menubar,
menubar {
    background: linear-gradient(90deg, 
        rgba(40, 0, 60, 0.95) 0%, 
        rgba(60, 0, 80, 0.95) 100%);
    padding: 4px;
    border-bottom: 2px solid #bb00ff;
    box-shadow: 0 0 10px rgba(187, 0, 255, 0.4);
}

.thunar menubar > menuitem,
menubar > menuitem {
    margin: 0 4px;
    padding: 6px 10px;
    border-radius: 8px;
    color: #bb00ff;
    font-weight: 600;
    text-shadow: 0 0 4px rgba(187, 0, 255, 0.5);
}

.thunar menubar > menuitem:hover,
menubar > menuitem:hover {
    background: rgba(187, 0, 255, 0.3);
    box-shadow: 0 0 8px rgba(187, 0, 255, 0.4);
}

.thunar .view,
.thunar iconview,
.thunar treeview {
    background: rgba(12, 0, 18, 0.7);
    color: #bb00ff;
    border-radius: 12px;
    text-shadow: 0 0 3px rgba(153, 0, 204, 0.6);
    font-weight: 600;
    font-size: 1.05em;
}

/* File name truncation for long names */
.thunar .filename-label,
.thunar .file-name,
.thunar .name-cell {
    max-width: 160px;  /* Adjust as needed */
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}

/* Show full name when hovering or active */
.thunar .filename-label:hover,
.thunar .file-name:hover,
.thunar .name-cell:hover,
.thunar .view:selected .filename-label,
.thunar .view:selected .file-name,
.thunar .view:selected .name-cell,
.thunar iconview:selected .filename-label,
.thunar treeview:selected .filename-label {
    max-width: none;
    white-space: normal;
    overflow: visible;
}

.thunar .sidebar {
    background: rgba(25, 0, 40, 0.75);
    border-right: 2px solid #bb00ff;
    border-radius: 12px 0 0 12px;
}

.thunar .sidebar label {
    font-weight: 600;
    font-size: 1.05em;
    text-shadow: 0 0 4px rgba(187, 0, 255, 0.6);
}

.thunar .view:selected,
.thunar iconview:selected,
.thunar treeview:selected {
    background: linear-gradient(100deg, #bb00ff 0%, #9900cc 100%);
    color: #ffffff;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(187, 0, 255, 0.5);
    font-weight: 700;
}

.thunar .view:hover,
.thunar iconview:hover,
.thunar treeview:hover {
    background: rgba(40, 0, 60, 0.5);
    border-radius: 8px;
    transition: all 0.15s ease;
}

/* File labels and names specific styling */
.thunar label,
.file-label,
.filename-label,
.name-label {
    font-weight: 600;
    text-shadow: 0 0 4px rgba(187, 0, 255, 0.5);
    letter-spacing: 0.03em;
}

/* Menus */
menu {
    background: rgba(12, 0, 18, 0.95);
    border: 2px solid #bb00ff;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(187, 0, 255, 0.6);
    color: #bb00ff;
}

menuitem {
    padding: 8px;
    margin: 4px 0;
    border-radius: 8px;
    background-color: rgba(40, 0, 60, 0.3);
    transition: all 0.15s ease;
}

menuitem:hover {
    background: linear-gradient(100deg, #bb00ff 0%, #9900cc 100%);
    color: #ffffff;
    box-shadow: 0 0 10px rgba(187, 0, 255, 0.5);
}

/* Scrollbars */
scrollbar {
    background: rgba(20, 0, 30, 0.8);
    border-radius: 10px;
    min-width: 10px;
    min-height: 10px;
}

scrollbar slider {
    background: linear-gradient(90deg, 
        rgba(187, 0, 255, 0.6) 0%, 
        rgba(127, 0, 255, 0.6) 100%);
    border-radius: 10px;
    border: 1px solid #bb00ff;
    min-width: 8px;
    min-height: 8px;
}

scrollbar slider:hover {
    background: linear-gradient(90deg, 
        rgba(187, 0, 255, 0.8) 0%, 
        rgba(127, 0, 255, 0.8) 100%);
}

/* Tooltips */
tooltip {
    background: rgba(40, 0, 60, 0.9);
    border: 2px solid #bb00ff;
    border-radius: 8px;
    color: #bb00ff;
    text-shadow: 0 0 3px rgba(153, 0, 204, 0.6);
}

/* Text selection */
*:selected {
    background: linear-gradient(100deg, #bb00ff 0%, #9900cc 100%);
    color: #ffffff;
}

/* System Tray / Panel Fixes */
.panel,
#panel,
.xfce4-panel,
.mate-panel,
.gnome-panel {
    background-color: rgba(12, 0, 18, 0.9);
    border-top: 2px solid #bb00ff;
    padding: 2px;
}

.panel button,
#panel button,
.xfce4-panel button,
.mate-panel button,
.gnome-panel button {
    min-height: 24px;
    min-width: 24px;
    padding: 2px;
    margin: 1px;
    border-radius: 6px;
    background: transparent;
    border: 1px solid transparent;
}

.panel button:hover,
#panel button:hover,
.xfce4-panel button:hover,
.mate-panel button:hover,
.gnome-panel button:hover {
    background: rgba(187, 0, 255, 0.3);
    border: 1px solid #bb00ff;
}

/* Status Icons / Tray Icons */
.status-icon,
.system-tray-icon,
.tray-icon,
.status-notifier-item,
.indicator-item {
    -gtk-icon-transform: scale(0.85);
    padding: 2px;
    color: #bb00ff;
}
EOF

# Copy to GTK-4.0 as well
cp ~/.config/gtk-3.0/gtk.css ~/.config/gtk-4.0/gtk.css

# Set basic GTK settings
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono 10'
gsettings set org.gnome.desktop.interface document-font-name 'JetBrains Mono 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 10'

# Apply Thunar-specific settings
mkdir -p ~/.config/Thunar
cat > ~/.config/Thunar/thunarrc << 'EOF'
[Configuration]
LastShowHidden=FALSE
LastSeparatorPosition=170
LastSortColumn=THUNAR_COLUMN_NAME
LastSortOrder=GTK_SORT_ASCENDING
ShortcutsIconSize=THUNAR_ICON_SIZE_SMALLER
ShortcutsIconEmblems=TRUE
TreeIconSize=THUNAR_ICON_SIZE_SMALLER
SmallIconSize=THUNAR_ICON_SIZE_SMALL
ThumbnailMode=THUNAR_THUMBNAIL_MODE_ALWAYS
ThumbnailSize=THUNAR_THUMBNAIL_SIZE_NORMAL
EOF

echo "✅ Neo Purple theme installed!"
echo "🔄 Restarting applications..."

# Restart applications to apply theme
killall thunar 2>/dev/null
killall waybar 2>/dev/null

# Wait a moment then restart
sleep 1
waybar &
disown

echo "🟣 Neo Purple theme setup complete!"
echo "📝 Your Thunar and system tray now match your Wofi theme"
echo "🔧 To undo: mv ~/.config/gtk-3.0/gtk.css.backup ~/.config/gtk-3.0/gtk.css"