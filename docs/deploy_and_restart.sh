#!/bin/bash
set -e
cd /opt/quanfan-mall
rm -rf .git
tar -xf /tmp/quanfan-mall.tar --no-same-owner
cd backend
mvn clean package -DskipTests -q 2>&1 | tail -3
echo "=== JAR ready ==="
kill $(lsof -ti:8080 2>/dev/null) 2>/dev/null || true
sleep 1
export DB_PASSWORD="Qq141516@"
nohup java -jar target/quanfan-mall-1.0.0.jar --server.port=8080 > /var/log/quanfan-mall.log 2>&1 &
echo "PID: $!"
sleep 6
curl -s -m 3 http://localhost:8080/api/health 2>&1 || echo "NOT YET"
echo ""
echo "=== DEPLOYED ==="
