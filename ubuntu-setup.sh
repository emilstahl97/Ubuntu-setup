#!/bin/bash

# This script sets up a fresh Ubuntu installation with common development tools.
# It should be run on a fresh install, by a user with sudo privileges.

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. System Update and Upgrade
echo "--- Updating and upgrading system packages ---"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

# 2. Install Core Packages
echo "--- Installing core development packages ---"
sudo apt-get install -y \
    openssh-server \
    net-tools \
    vim \
    git \
    curl \
    htop \
    tmux \
    unzip \
    python3 \
    python3-pip \
    python3-venv

# 3. Configure Git Alias
echo "--- Adding 'gac' git alias to .bashrc ---"
echo '' >> ~/.bashrc
echo '# Custom alias for git add and commit' >> ~/.bashrc
echo 'alias gac='\''function _gac() { if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then git add . && git commit -m "$1"; else echo "Not a Git repository"; fi; }; _gac'\'' >> ~/.bashrc

# 4. Install NVM (Node Version Manager) and Node.js
echo "--- Installing NVM and latest LTS Node.js ---"
export NVM_DIR="$HOME/.nvm"
# The original script had an invalid nvm version (v0.40.1), so I am using a recent stable version (v0.39.7).
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source NVM script to make nvm command available in this script execution
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install and use the latest LTS version of Node.js
nvm install --lts
nvm use --lts
nvm alias default lts

echo "--- Verifying Node.js and npm installation ---"
node --version
npm --version

echo ""
echo "--- Setup complete! ---"
echo "Please restart your terminal or run 'source ~/.bashrc' to use nvm and the new 'gac' alias."

