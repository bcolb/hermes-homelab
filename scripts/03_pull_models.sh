#!/bin/bash
# Step 3 — Pull Local Models
# Pulls Ollama models for use with Hermes Agent.
# Safe to re-run — ollama pull skips models already present.
#
# All three models are pulled for experimentation on this dev server.
# For a leaner install, comment out models you don't need.

set -euo pipefail

echo "[3/7] Pulling Ollama models..."

# Primary — Hermes 3 8B, tuned for agentic tool calling
ollama pull nous-hermes3:8b

# Lighter alternative if memory is tight
ollama pull nous-hermes3:4b

# Alternative with strong tool-calling support
ollama pull qwen2.5:7b

echo "  Models available:"
ollama list
echo "[3/7] Model pull complete."
