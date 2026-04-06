# Hermes Homelab

Guided installation scripts for setup and configuration of a linux server (Ubuntu) for running [Hermes Agent](https://hermes-agent.nousresearch.com/) and testing at-home/hobbyist AI development. Not hardware specific, but developed to target a HP ProDesk 600 G2.

## Overview

This repository contains scripts to setup local AI models/LLMs and run [Hermes Agent (repo)](https://github.com/nousresearch/hermes-agent). It's driven by a main installation script (install.sh).

The install script runs the following steps:

1. **System baseline** — update Ubuntu, install git and curl
2. **Install Ollama** — local model inference server, runs as a systemd service on port 11434
3. **Pull models** — downloads hermes3:8b, hermes3:3b, and qwen2.5:7b
4. **Install Hermes Agent** — installs Python 3.11 (via uv), Node.js v22, and the `hermes` CLI

After the script completes, a one-time setup wizard configures your model provider and agent settings.

## Usage

### Install directly from the target machine

Open up the terminal. 

Git is a prerequisite, install it first

```sudo apt install -y git```

Run the following to clone this repository

```git clone https://github.com/bcolb/hermes-homelab```

Navigate to the hermes-homelab folder

```cd hermes-homelab```

Execute the installation script

```bash install.sh```

You will be prompted to enter your sudo password which is required for system installations.

### Install via SSH

To install remotely you'll first need to configure ssh access to the target machine. You will need to have a username, password, IP address, and admin access to the remote linux machine you're targeting for install. You can check that you have these by ssh'ing into the target machine, example command:

```ssh username@10.0.0.xxx```

Once you've confirmed you can ssh in, setup your SSH key

```ssh-copy-id username@10.0.0.xxx```

Optionally add the machine to your ssh config (~/.ssh/config)

```
Host hermes_box
    HostName 10.0.0.XXX
    User username
    IdentityFile ~/.ssh/id_ed25519
    ServerAliveInterval 60
    ServerAliveCountMax 3
```

Then ssh into the target machine (hermes_box in our example)

```
ssh hermes_box
```

Now you can execute the same steps as if you had local access from the section above (clone the repo, cd into hermes-homelab, execute the install.sh script)

## Post-Install Setup

After `install.sh` completes, reload your shell so the `hermes` command is available:

```bash
source ~/.bashrc
```

Then run the setup wizard:

```bash
hermes model
```

### Recommended wizard settings for this setup

**Inference Provider**
- Select **Custom endpoint**
- Base URL: `http://localhost:11434/v1`
- API key: `ollama` (literal string — Ollama doesn't require a real key)
- Model: `qwen2.5:7b`

To verify Ollama is reachable before entering the URL:
```bash
curl http://localhost:11434
# Expected: Ollama is running
```

**Terminal backend** — keep Local (default)

**Agent settings**
- Max iterations: 60 (default)
- Tool progress: `all` (recommended for dev use — shows every tool call)
- Compression threshold: 0.5 (default)
- Session reset: Inactivity + daily at 4 AM (default)

**Messaging platforms** — skip all (can be configured later with `hermes gateway setup`)

**Tools** — keep defaults

**Browser automation** — select Local Browser (free, no API key)

**Image generation / TTS / Web search** — skip or keep defaults

### Verify the install

```bash
hermes doctor    # checks all dependencies and config
hermes           # starts interactive chat
```

### Switching models later

To change your model or provider without re-running the full wizard:

```bash
hermes model
```

Available local models (pulled in step 3):
- `qwen2.5:7b` — primary, strong tool-calling support (recommended)
- `hermes3:8b` — available for experimentation, but lacks tool-calling capabilities required by Hermes Agent
- `hermes3:3b` — same caveat as above, lighter weight

### Adding API fallback (optional)

For tasks where the local model isn't sufficient, add an API key to `~/.hermes/.env`:

```bash
echo 'OPENROUTER_API_KEY=your-key-here' >> ~/.hermes/.env
```

## Related Projects

- [Hermes Agent](https://github.com/nousresearch/hermes-agent)
- [Converting an HP ProDesk 600 G2 (Proxmox) to Ubuntu Desktop](https://gist.github.com/bcolb/a201e1bb66e167cb1f2ca62b83c16a5a)

## License 

MIT

## Author

Brice Colbert

