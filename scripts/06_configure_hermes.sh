#!/bin/bash
# Step 6 — Configure Hermes Agent
# Sets the model provider, base URL, and default model.
# Safe to re-run — hermes config set overwrites existing values.

set -euo pipefail

echo "[6/7] Configuring Hermes Agent..."

if ! command -v hermes &>/dev/null; then
    echo "ERROR: hermes command not found. Ensure script 04 completed successfully." >&2
    exit 1
fi

hermes config set model.provider custom
hermes config set model.base_url http://localhost:11434/v1
hermes config set model.default hermes3:8b

echo "  Hermes configured to use local Ollama endpoint."
echo "  Provider: custom"
echo "  Base URL: http://localhost:11434/v1"
echo "  Model:    hermes3:8b"
echo "[6/7] Hermes configuration complete."
