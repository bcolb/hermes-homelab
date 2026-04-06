#!/bin/bash
# Hermes Homelab Install Script
# Author: Brice Colbert
# Run: bash install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Hermes Homelab Installation"
echo ""

bash "$SCRIPT_DIR/scripts/01_system_baseline.sh"
