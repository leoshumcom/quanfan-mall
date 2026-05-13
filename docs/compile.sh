#!/bin/bash
set -e
rm -rf /opt/quanfan-mall
mkdir -p /opt/quanfan-mall
cd /opt/quanfan-mall
tar -xf /tmp/quanfan-mall.tar
cd backend
echo "=== MAVEN COMPILE ==="
mvn clean compile -q 2>&1 | tail -10
echo "=== BUILD EXIT: $? ==="
ls -la target/classes/ 2>/dev/null | head -5
echo "=== DONE ==="
