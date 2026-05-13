#!/bin/bash
set -e
ssh-keygen -t ed25519 -f /root/.ssh/github_deploy -N "" -C "quanfan-mall-deploy" 2>&1 | tail -1
cat /root/.ssh/github_deploy.pub
