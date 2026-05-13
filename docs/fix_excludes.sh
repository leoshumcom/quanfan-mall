#!/bin/bash
set -e
sed -i 's/^exclude=.*/exclude=/' /etc/dnf/dnf.conf
sed -i 's/^exclude=.*/exclude=/' /etc/yum.conf
dnf clean all 2>&1 | tail -1
dnf install -y nginx 2>&1 | tail -5
systemctl start nginx
systemctl enable nginx
echo "DB setup..."
mysql -e "CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;" 2>&1
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Qq141516@'; FLUSH PRIVILEGES;" 2>&1
echo "Verify:"
nginx -v 2>&1
systemctl status nginx --no-pager -l | grep Active
echo "DONE"
