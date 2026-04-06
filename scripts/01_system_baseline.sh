#!/bin/bash
# Step 1 — System Baseline
# Updates Ubuntu and installs prerequisite packages.
# Safe to re-run.

set -euo pipefail

echo "[1/7] System baseline..."

sudo apt update
sudo apt upgrade -y
sudo apt install -y git curl tmux htop

if ! command -v git &>/dev/null; then
    echo "ERROR: git installation failed." >&2
    exit 1
fi

echo "  git $(git --version)"
echo "[1/7] System baseline complete."
