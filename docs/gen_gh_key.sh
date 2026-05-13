#!/bin/bash
set -e
# Generate SSH key and add to authorized_keys on server
ssh-keygen -t ed25519 -f /tmp/gh_deploy_key -N "" -C "github-deploy-key" 2>&1 | tail -1
cat /tmp/gh_deploy_key.pub
echo "KEY_GENERATED"
