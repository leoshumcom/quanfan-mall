#!/bin/bash
set -e
cd /tmp
rm -rf /opt/quanfan-mall 2>/dev/null
mkdir -p /opt/quanfan-mall
tar -xf /tmp/quanfan-mall.tar -C /opt/quanfan-mall
cd /opt/quanfan-mall/backend

echo "=== Compiling Backend ==="
mvn clean compile -q 2>&1 | tail -10
echo "=== COMPILE DONE ==="
