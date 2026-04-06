#!/bin/bash
# Step 4 — Install Hermes Agent
# Installs Hermes Agent via the official installer (Python 3.11 via uv, Node.js v22).
# Safe to re-run — skips install if hermes is already present.
#
# NOTE: If this is a fresh install, you may need to reload your shell after
# install.sh completes before the hermes command is available:
#   source ~/.bashrc

set -euo pipefail

echo "[4/7] Installing Hermes Agent..."

if command -v hermes &>/dev/null; then
    echo "  Hermes already installed: $(hermes version)"
else
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
fi

if ! command -v hermes &>/dev/null; then
    if [[ -x "$HOME/.local/bin/hermes" ]]; then
        echo "  Hermes installed at ~/.local/bin/hermes"
        echo "  Reload your shell to use the hermes command: source ~/.bashrc"
    else
        echo "ERROR: Hermes installation failed." >&2
        exit 1
    fi
else
    echo "  $(hermes version)"
fi

echo "[4/7] Hermes Agent install complete."
