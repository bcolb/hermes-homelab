#!/bin/bash
# Step 3 — Pull Local Models
# Pulls Ollama models for use with Hermes Agent.
# Safe to re-run — ollama pull skips models already present.
#
# All three models are pulled for experimentation on this dev server.
# For a leaner install, comment out models you don't need.

set -euo pipefail

echo "[3/7] Pulling Ollama models..."

# Primary — strong tool-calling support, recommended for Hermes Agent
ollama pull qwen2.5:7b

# Available for experimentation — NOTE: hermes3 models lack tool-calling
# capabilities and are not suitable as the default model for Hermes Agent
ollama pull hermes3:8b
ollama pull hermes3:3b

echo "  Models available:"
ollama list
echo "[3/7] Model pull complete."
