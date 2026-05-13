#!/bin/bash
set -e
dnf install -y maven 2>&1 | tail -5
echo "Maven:"
mvn --version 2>&1 | head -2
echo "=== ALL READY ==="
