#!/bin/bash

# Script to ensure TypeScript Language Server is installed
# This will be run at Hyprland startup

# Check if TypeScript Language Server is installed
if ! command -v typescript-language-server &> /dev/null; then
    notify-send "Installing TypeScript Language Server" "This might take a moment..." -i dialog-information
    
    # Install typescript-language-server via npm
    npm install -g typescript typescript-language-server
    
    # Check if the installation was successful
    if command -v typescript-language-server &> /dev/null; then
        notify-send "TypeScript Language Server installed" "Installation complete! Neovim LSP should now work properly." -i dialog-information
    else
        notify-send "Installation Failed" "Could not install TypeScript Language Server. Please install it manually." -i dialog-error
    fi
fi

# Check for other common LSP servers
if ! command -v pyright &> /dev/null; then
    notify-send "LSP Info" "Consider installing Pyright for Python: npm install -g pyright" -i dialog-information
fi

# Ensure Mason LSP directory exists
mkdir -p ~/.local/share/nvim/mason/bin

# Update PATH in the current session
if [[ ":$PATH:" != *":$HOME/.local/share/nvim/mason/bin:"* ]]; then
    export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
fi

# Update .bashrc to include Mason bin path if it's not already there
if ! grep -q "nvim/mason/bin" ~/.bashrc; then
    echo 'export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"' >> ~/.bashrc
    notify-send "PATH Updated" "Added Mason bin directory to PATH in .bashrc" -i dialog-information
fi

exit 0