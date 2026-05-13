#!/bin/bash
set -e
# Install gh CLI
curl -fsSL https://cli.github.com/packages/rpm/gh-cli.repo -o /etc/yum.repos.d/gh-cli.repo 2>/dev/null
dnf install -y gh 2>&1 | tail -3 || echo "gh install failed"
echo "Ready"
