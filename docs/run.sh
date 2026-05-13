#!/bin/bash
set -e
cd /opt/quanfan-mall/backend
echo "=== PACKAGE ==="
mvn package -DskipTests -q 2>&1 | tail -10
echo "=== JAR ==="
ls -la target/*.jar 2>/dev/null | head -3
echo "=== RUN ==="
export DB_PASSWORD="Qq141516@"
export REDIS_HOST="localhost"
nohup java -jar target/quanfan-mall-1.0.0.jar --server.port=8080 > /var/log/quanfan-mall.log 2>&1 &
echo "PID: $!"
sleep 5
tail -5 /var/log/quanfan-mall.log
echo "=== DEPLOYED ==="
