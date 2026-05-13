#!/bin/bash
set -e
echo "=== Server Info ==="
hostname
cat /etc/os-release | head -3

echo "=== Package Managers ==="
which dnf || echo "no dnf"
which yum || echo "no yum"
which microdnf || echo "no microdnf"

echo "=== Install MariaDB ==="
dnf install -y mariadb-server 2>&1 | tail -5

echo "=== Install Nginx ==="
dnf install -y nginx 2>&1 | tail -5

echo "=== Start Services ==="
systemctl start mariadb 2>&1 || systemctl start mysql 2>&1 || echo "DB start failed"
systemctl start redis 2>&1
systemctl start nginx 2>&1
systemctl enable redis 2>&1

echo "=== Version Check ==="
mysql --version 2>/dev/null || echo "no mysql"
redis-server --version 2>/dev/null || echo "no redis"
nginx -v 2>&1 || echo "no nginx"
