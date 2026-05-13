#!/bin/bash
# Run: sshpass -p 'Qq141516@' ssh root@47.82.100.97 'bash -s' < setup2.sh

set -e

echo "=== 1. OS Info ==="
cat /etc/os-release | head -3
uptime

echo "=== 2. Install LNMP stack ==="
# MariaDB
dnf install -y mariadb-server 2>&1 | tail -3

# Nginx
dnf install -y nginx 2>&1 | tail -3

echo "=== 3. Start services ==="
systemctl start mariadb 2>&1
systemctl start redis 2>&1
systemctl start nginx 2>&1
systemctl enable mariadb
systemctl enable redis
systemctl enable nginx

echo "=== 4. Create DB ==="
mysql -e "CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Qq141516@'; FLUSH PRIVILEGES;"

echo "=== 5. Verify ==="
echo "MariaDB: $(mysql --version)"
echo "Redis: $(redis-server --version)"
echo "Nginx: $(nginx -v 2>&1)"
echo "Java: $(java -version 2>&1 | head -1)"
echo "Node: $(node -v)"
echo "Git: $(git --version)"

echo "=== DONE ==="
