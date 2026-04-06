#!/bin/bash
# Step 5 — Configure Secrets
# Copies secrets.env.template to secrets.env if not already present,
# then writes API keys to ~/.hermes/.env.
# Safe to re-run.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../config"
SECRETS_FILE="$CONFIG_DIR/secrets.env"
TEMPLATE_FILE="$CONFIG_DIR/secrets.env.template"
HERMES_ENV="$HOME/.hermes/.env"

echo "[5/7] Configuring secrets..."

if [[ ! -f "$SECRETS_FILE" ]]; then
    cp "$TEMPLATE_FILE" "$SECRETS_FILE"
    echo "  Created $SECRETS_FILE from template."
    echo "  Fill in your API keys in $SECRETS_FILE and re-run this script."
    exit 0
fi

source "$SECRETS_FILE"

mkdir -p "$HOME/.hermes"
touch "$HERMES_ENV"

if [[ -n "${OPENROUTER_API_KEY:-}" ]]; then
    if grep -q "OPENROUTER_API_KEY" "$HERMES_ENV"; then
        sed -i "s|OPENROUTER_API_KEY=.*|OPENROUTER_API_KEY=$OPENROUTER_API_KEY|" "$HERMES_ENV"
    else
        echo "OPENROUTER_API_KEY=$OPENROUTER_API_KEY" >> "$HERMES_ENV"
    fi
    echo "  OPENROUTER_API_KEY written to $HERMES_ENV"
else
    echo "  WARNING: OPENROUTER_API_KEY is not set in $SECRETS_FILE — skipping."
fi

echo "[5/7] Secrets configuration complete."
