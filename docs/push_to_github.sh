#!/bin/bash
# Run on the server: push to GitHub
set -e
cd /tmp/quanfan-mall
git remote add origin https://github.com/leoshumcom/quanfan-mall.git
git push -u origin main 2>&1
echo "PUSH_DONE"
