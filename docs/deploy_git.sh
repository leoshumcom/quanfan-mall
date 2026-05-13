#!/bin/bash
set -e

# Setup git on server and push to GitHub
mkdir -p /opt/quanfan-mall
cd /opt/quanfan-mall
git init
git config user.email "leoshumcom@github.com"
git config user.name "leoshumcom"

# Add GitHub as known host
mkdir -p ~/.ssh
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts 2>/dev/null

# Config SSH to use deploy key
cat > ~/.ssh/config << 'SSHCONF'
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/github_deploy
SSHCONF

# Test connection
ssh -T git@github.com 2>&1 | head -2
echo "GIT_READY"
