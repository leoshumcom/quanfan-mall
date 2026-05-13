#!/bin/bash
set -e
cd /opt/quanfan-mall/backend
echo "=== Clean Build ==="
rm -rf target
mvn clean package -DskipTests -q 2>&1 | tail -5
echo "=== JAR Size ==="
ls -lh target/*.jar 2>/dev/null | head -2
echo "=== Kill old ==="
kill $(lsof -ti:8080 2>/dev/null) 2>/dev/null || true
sleep 1
echo "=== Start ==="
export DB_PASSWORD="Qq141516@"
nohup java -jar target/quanfan-mall-1.0.0.jar --server.port=8080 > /var/log/quanfan-mall.log 2>&1 &
echo "PID: $!"
sleep 10
echo "=== Log ==="
tail -15 /var/log/quanfan-mall.log
