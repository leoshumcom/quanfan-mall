#!/bin/bash
# Fix excludes and install nginx + maven
set -e

echo "=== Remove excludes ==="
sed -i 's/exclude = .*/exclude = /' /etc/dnf/dnf.conf
grep exclude /etc/dnf/dnf.conf

echo "=== Install nginx ==="
dnf install -y nginx 2>&1 | tail -5

echo "=== Start nginx ==="
systemctl start nginx
systemctl enable nginx
systemctl status nginx --no-pager -l | grep Active

echo "=== Install maven ==="
dnf install -y maven 2>&1 | tail -5

echo "=== Create DB ==="
mysql -e "CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Qq141516@'; FLUSH PRIVILEGES;"

echo "=== Final check ==="
nginx -v 2>&1
mvn --version 2>&1 | head -1
echo "=== DONE ==="
