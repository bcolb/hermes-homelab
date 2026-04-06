#!/bin/bash
# Hermes Homelab Install Script
# Author: Brice Colbert
# Run: bash install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Hermes Homelab Installation"
echo ""

bash "$SCRIPT_DIR/scripts/01_system_baseline.sh"
bash "$SCRIPT_DIR/scripts/02_install_ollama.sh"
bash "$SCRIPT_DIR/scripts/03_pull_models.sh"
bash "$SCRIPT_DIR/scripts/04_install_hermes.sh"

# Ensure hermes is in PATH for remaining steps without requiring a shell reload
export PATH="$HOME/.local/bin:$PATH"

bash "$SCRIPT_DIR/scripts/05_configure_secrets.sh"
bash "$SCRIPT_DIR/scripts/06_configure_hermes.sh"
bash "$SCRIPT_DIR/scripts/07_install_services.sh"
