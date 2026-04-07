#!/bin/bash
# Step 6 — Configure Hermes Agent
# Sets the model provider, base URL, and default model.
# If OPENROUTER_API_KEY is set in config/secrets.env, configures OpenRouter.
# Otherwise falls back to local Ollama.
# Safe to re-run — hermes config set overwrites existing values.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECRETS_FILE="$SCRIPT_DIR/../config/secrets.env"

echo "[6/7] Configuring Hermes Agent..."

if ! command -v hermes &>/dev/null; then
    echo "ERROR: hermes command not found. Ensure script 04 completed successfully." >&2
    exit 1
fi

if [[ -f "$SECRETS_FILE" ]]; then
    source "$SECRETS_FILE"
fi

if [[ -n "${OPENROUTER_API_KEY:-}" ]]; then
    hermes config set model.provider openrouter
    hermes config set model.default qwen/qwen-2.5-72b-instruct

    echo "  Hermes configured to use OpenRouter."
    echo "  Provider: openrouter"
    echo "  Model:    qwen/qwen-2.5-72b-instruct"
else
    hermes config set model.provider custom
    hermes config set model.base_url http://localhost:11434/v1
    hermes config set model.default qwen2.5:7b
    hermes config set model.timeout 600

    echo "  Hermes configured to use local Ollama endpoint."
    echo "  Provider: custom"
    echo "  Base URL: http://localhost:11434/v1"
    echo "  Model:    qwen2.5:7b"
    echo "  Timeout:  600s (accommodates slow CPU inference)"
fi

echo "[6/7] Hermes configuration complete."
