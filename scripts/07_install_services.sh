#!/bin/bash
# Step 7 — Install Hermes Gateway Service
# Installs Hermes as a persistent user-level systemd service via hermes gateway install.
# Safe to re-run.

set -euo pipefail

echo "[7/7] Installing Hermes gateway service..."

if ! command -v hermes &>/dev/null; then
    echo "ERROR: hermes command not found. Ensure script 04 completed successfully." >&2
    exit 1
fi

hermes gateway install

if ! systemctl --user is-active --quiet hermes-gateway; then
    echo "  Service not yet active, starting..."
    systemctl --user start hermes-gateway
fi

systemctl --user status hermes-gateway --no-pager

echo "[7/7] Hermes gateway service installed and running."
echo ""
echo "  Useful commands:"
echo "    hermes                         — start interactive chat"
echo "    hermes ui                      — open web UI"
echo "    hermes gateway status          — check gateway status"
echo "    journalctl --user -u hermes-gateway -f  — view logs"
