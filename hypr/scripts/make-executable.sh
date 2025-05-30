#!/bin/bash

# Make the LSP installation script executable
chmod +x ~/.config/hypr/scripts/ensure-lsp.sh

# Run the script to immediately install TypeScript Language Server
~/.config/hypr/scripts/ensure-lsp.sh

echo "Script permissions set and LSP installation initiated."