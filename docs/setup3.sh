#!/bin/bash
set -e

echo "=== Install Nginx (EPEL) ==="
dnf install -y epel-release 2>&1 | tail -3
dnf install -y nginx 2>&1 | tail -3

echo "=== Start all services ==="
systemctl start mariadb 2>&1
systemctl start redis 2>&1
systemctl start nginx 2>&1
systemctl enable mariadb 2>&1
systemctl enable redis 2>&1
systemctl enable nginx 2>&1

echo "=== Create DB ==="
mysql -e "CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Qq141516@'; FLUSH PRIVILEGES;"

echo "=== Install Maven ==="
dnf install -y maven 2>&1 | tail -3

echo "=== Final Verification ==="
echo "MariaDB: $(mysql --version)"
echo "Redis: $(redis-server --version 2>&1)"
nginx -v 2>&1
echo "Java: $(java -version 2>&1 | head -1)"
echo "Node: $(node -v)"
echo "Maven: $(mvn --version 2>&1 | head -1)"

echo "=== Services Status ==="
systemctl status mariadb --no-pager -l | grep Active
systemctl status redis --no-pager -l | grep Active
systemctl status nginx --no-pager -l | grep Active
echo "=== ALL DONE ==="
