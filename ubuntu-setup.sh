#!/bin/bash

# This script sets up a fresh Ubuntu installation with common development tools.
# It should be run on a fresh install, by a user with sudo privileges.

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. System Update
echo "--- Updating system packages ---"
sudo apt-get update -y

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
    python3-venv \
    nodejs \
    npm

# 3. Configure Git
echo "--- Configuring Git ---"
git config --global user.email "emil.stahl@icloud.com"
git config --global user.name "Emil Ståhl"

# 4. Configure Git Alias
echo "--- Adding 'gac' git alias to .bashrc ---"
cat <<'EOF' >> ~/.bashrc

# Custom function for git add and commit
gac() {
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git add . && git commit -m "$1"
    else
        echo "Not a Git repository"
    fi
}
EOF

# 5. Verify Node.js and npm installation
echo "--- Verifying Node.js and npm installation ---"
node --version
npm --version

echo ""
echo "--- Setup complete! ---"
echo "Please restart your terminal for the changes to take effect."

