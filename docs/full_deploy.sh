#!/bin/bash
set -e
rm -rf /opt/quanfan-mall
mkdir -p /opt/quanfan-mall
cd /opt/quanfan-mall
tar -xf /tmp/quanfan-mall.tar
cd backend
echo "=== Build ==="
mvn clean package -DskipTests -q 2>&1 | tail -5
echo "=== JAR ==="
ls -lh target/*.jar | head -2
echo "=== Start ==="
kill $(lsof -ti:8080 2>/dev/null) 2>/dev/null || true
sleep 1
export DB_PASSWORD="Qq141516@"
nohup java -jar target/quanfan-mall-1.0.0.jar --server.port=8080 > /var/log/quanfan-mall.log 2>&1 &
echo "PID: $!"
sleep 10
echo "=== Status ==="
if lsof -ti:8080 &>/dev/null; then
  echo "RUNNING on port 8080"
  tail -5 /var/log/quanfan-mall.log
else
  echo "FAILED"
  tail -20 /var/log/quanfan-mall.log
fi
