#!/bin/bash

# Thunar Windows Explorer-like Configuration Script for Arch Linux + Hyprland
echo "🗂️ Configuring Thunar like Windows Explorer (Arch + Hyprland)..."

# Create directories if they don't exist
mkdir -p ~/.config/Thunar
mkdir -p ~/.local/share/applications

# Install necessary packages (Arch Linux)
echo "📦 Installing archive and media support..."
sudo pacman -S --needed thunar-archive-plugin file-roller thunar-media-tags-plugin unzip p7zip xarchiver wl-clipboard

# Detect terminal (common Hyprland terminals)
TERMINAL="kitty"
if command -v alacritty &>/dev/null; then
  TERMINAL="alacritty"
elif command -v foot &>/dev/null; then
  TERMINAL="foot"
elif command -v wezterm &>/dev/null; then
  TERMINAL="wezterm"
fi

echo "🖥️ Using terminal: $TERMINAL"

# Create custom desktop entries for better file associations
echo "🔧 Creating custom application entries..."

# Neovim in Terminal
cat >~/.local/share/applications/nvim-terminal.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Neovim (Terminal)
Comment=Edit with Neovim in terminal
Exec=$TERMINAL -e nvim %f
Icon=nvim
Terminal=false
MimeType=text/plain;text/x-shellscript;application/x-shellscript;text/x-python;text/x-c;text/x-cpp;text/html;text/css;text/javascript;application/json;text/xml;
Categories=TextEditor;Development;
NoDisplay=false
EOF

# VS Code entry (if installed)
if command -v code &>/dev/null; then
  cat >~/.local/share/applications/vscode-custom.desktop <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=code %F
Icon=vscode
Terminal=false
MimeType=text/plain;text/x-shellscript;application/x-shellscript;text/x-python;text/x-c;text/x-cpp;text/html;text/css;text/javascript;application/json;text/xml;
Categories=TextEditor;Development;IDE;
NoDisplay=false
EOF
fi

# Create Thunar custom actions XML
echo "⚙️ Setting up Thunar custom actions..."

# Backup existing custom actions
if [ -f ~/.config/Thunar/uca.xml ]; then
  cp ~/.config/Thunar/uca.xml ~/.config/Thunar/uca.xml.backup
  echo "📦 Backed up existing custom actions"
fi

# Create comprehensive custom actions for Hyprland
cat >~/.config/Thunar/uca.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<actions>
<action>
	<icon>utilities-terminal</icon>
	<n>Open Terminal Here</n>
	<unique-id>1234567890123456-1</unique-id>
	<command>$TERMINAL --working-directory=%f</command>
	<description>Open terminal in current directory</description>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>

<action>
	<icon>nvim</icon>
	<n>Edit with Neovim</n>
	<unique-id>1234567890123456-2</unique-id>
	<command>$TERMINAL -e nvim %f</command>
	<description>Edit file with Neovim in terminal</description>
	<patterns>*</patterns>
	<startup-notify/>
	<text-files/>
	<other-files/>
</action>

<action>
	<icon>code</icon>
	<n>Open with VS Code</n>
	<unique-id>1234567890123456-3</unique-id>
	<command>code %f</command>
	<description>Open with Visual Studio Code</description>
	<patterns>*</patterns>
	<startup-notify/>
	<text-files/>
	<other-files/>
</action>

<action>
	<icon>package-x-generic</icon>
	<n>Extract Here</n>
	<unique-id>1234567890123456-4</unique-id>
	<command>file-roller --extract-to=%f %f</command>
	<description>Extract archive contents to current folder</description>
	<patterns>*.zip;*.rar;*.tar;*.tar.gz;*.tar.bz2;*.tar.xz;*.7z;*.gz;*.bz2</patterns>
	<startup-notify/>
	<other-files/>
</action>

<action>
	<icon>package-x-generic</icon>
	<n>Extract to New Folder</n>
	<unique-id>1234567890123456-5</unique-id>
	<command>file-roller --extract %f</command>
	<description>Extract archive with options</description>
	<patterns>*.zip;*.rar;*.tar;*.tar.gz;*.tar.bz2;*.tar.xz;*.7z;*.gz;*.bz2</patterns>
	<startup-notify/>
	<other-files/>
</action>

<action>
	<icon>applications-system</icon>
	<n>Open as Root</n>
	<unique-id>1234567890123456-6</unique-id>
	<command>sudo thunar %f</command>
	<description>Open location with root privileges</description>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>

<action>
	<icon>edit-copy</icon>
	<n>Copy Path</n>
	<unique-id>1234567890123456-7</unique-id>
	<command>echo -n %f | wl-copy</command>
	<description>Copy full path to clipboard (Wayland)</description>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
	<other-files/>
	<text-files/>
</action>

<action>
	<icon>folder</icon>
	<n>New Folder</n>
	<unique-id>1234567890123456-8</unique-id>
	<command>mkdir "%f/New Folder"</command>
	<description>Create new folder</description>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>

<action>
	<icon>image-x-generic</icon>
	<n>Open with Swappy</n>
	<unique-id>1234567890123456-9</unique-id>
	<command>swappy -f %f</command>
	<description>Edit image with Swappy</description>
	<patterns>*.png;*.jpg;*.jpeg;*.bmp;*.gif;*.webp</patterns>
	<startup-notify/>
	<other-files/>
</action>

<action>
	<icon>folder-open</icon>
	<n>Open in Ranger</n>
	<unique-id>1234567890123456-10</unique-id>
	<command>$TERMINAL -e ranger %f</command>
	<description>Open directory in Ranger file manager</description>
	<patterns>*</patterns>
	<startup-notify/>
	<directories/>
</action>
</actions>
EOF

# Set up default file associations using xdg-mime
echo "🔗 Setting up file associations..."

# Text files to Neovim
xdg-mime default nvim-terminal.desktop text/plain
xdg-mime default nvim-terminal.desktop text/x-shellscript
xdg-mime default nvim-terminal.desktop application/x-shellscript

# Archives to file-roller
xdg-mime default org.gnome.FileRoller.desktop application/zip
xdg-mime default org.gnome.FileRoller.desktop application/x-rar
xdg-mime default org.gnome.FileRoller.desktop application/x-tar
xdg-mime default org.gnome.FileRoller.desktop application/gzip

# Configure Thunar settings for Windows-like behavior
echo "⚙️ Configuring Thunar preferences..."

# Create Thunar configuration directory
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml

# Thunar configuration optimized for Hyprland
cat >~/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<channel name="thunar" version="1.0">
  <property name="default-view" type="string" value="ThunarDetailsView"/>
  <property name="last-show-hidden" type="bool" value="true"/>
  <property name="last-window-width" type="int" value="1200"/>
  <property name="last-window-height" type="int" value="800"/>
  <property name="last-separator-position" type="int" value="200"/>
  <property name="misc-single-click" type="bool" value="false"/>
  <property name="misc-text-beside-icons" type="bool" value="false"/>
  <property name="shortcuts-icon-emblems" type="bool" value="true"/>
  <property name="shortcuts-icon-size" type="string" value="THUNAR_ICON_SIZE_16"/>
  <property name="tree-icon-emblems" type="bool" value="true"/>
  <property name="tree-icon-size" type="string" value="THUNAR_ICON_SIZE_16"/>
  <property name="misc-middle-click-in-tab" type="bool" value="true"/>
  <property name="misc-tab-close-middle-click" type="bool" value="true"/>
  <property name="misc-full-path-in-title" type="bool" value="true"/>
</channel>
EOF

# Update desktop database
update-desktop-database ~/.local/share/applications/

# Optional: Install additional useful tools for Hyprland
echo "🛠️ Installing additional Hyprland-friendly tools..."
echo "   (You can skip this if you don't want them)"
read -p "Install extra tools? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  sudo pacman -S --needed ranger swappy imv mpv
fi

# Restart Thunar to apply changes
echo "🔄 Restarting Thunar..."
pkill thunar 2>/dev/null
sleep 1

echo "✅ Thunar configuration for Arch + Hyprland complete!"
echo ""
echo "🎉 Your Thunar now has Windows Explorer-like features:"
echo "   • Right-click context menu with custom actions"
echo "   • Extract archives with right-click"
echo "   • Open terminal ($TERMINAL) in current directory"
echo "   • Edit files with Neovim or VS Code"
echo "   • Copy file paths to Wayland clipboard (wl-copy)"
echo "   • Open as root option"
echo "   • Double-click navigation"
echo "   • Details view by default"
echo "   • Image editing with Swappy"
echo "   • Optional Ranger integration"
echo ""
echo "📝 Hyprland-specific features:"
echo "   • Uses Wayland clipboard (wl-copy)"
echo "   • Auto-detects your terminal ($TERMINAL)"
echo "   • Swappy for screenshot/image editing"
echo "   • Optimized for tiling window managers"
echo ""
echo "🔧 To customize further:"
echo "   • Open Thunar → Edit → Configure Custom Actions"
echo "   • Open Thunar → Edit → Preferences"
echo ""
echo "🔧 To undo: restore from ~/.config/Thunar/uca.xml.backup"
