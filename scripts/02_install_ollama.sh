#!/bin/bash
# Step 2 — Install Ollama
# Installs Ollama as a systemd service.
# Safe to re-run.

set -euo pipefail

echo "[2/7] Installing Ollama..."

if command -v ollama &>/dev/null; then
    echo "  Ollama already installed: $(ollama --version)"
else
    curl -fsSL https://ollama.com/install.sh | sh
fi

if ! systemctl is-active --quiet ollama; then
    echo "ERROR: Ollama service is not running." >&2
    systemctl status ollama >&2
    exit 1
fi

echo "  $(ollama --version)"
echo "[2/7] Ollama install complete."
