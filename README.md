# Hermes Homelab

Guided installation scripts for setup and configuration of a linux server (Ubuntu) for running [Hermes Agent](https://hermes-agent.nousresearch.com/) and testing at-home/hobbyist AI development. Not hardware specific, but developed to target a HP ProDesk 600 G2.

## Overview

This repository contains scripts to setup local AI models/LLMs and run [Hermes Agent (repo)](https://github.com/nousresearch/hermes-agent). It's driven by a main installation script (install.sh).

## Usage

### Install directly from the target machine

Open up the terminal. Run the following to clone this repository:

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

## Related Projects

- [Hermes Agent](https://github.com/nousresearch/hermes-agent)
- [Converting an HP ProDesk 600 G2 (Proxmox) to Ubuntu Desktop](https://gist.github.com/bcolb/a201e1bb66e167cb1f2ca62b83c16a5a)

## License 

MIT

## Author

Brice Colbert

