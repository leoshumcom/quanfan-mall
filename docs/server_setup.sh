#!/bin/bash
# Server setup script - run via sshpass from WSL
SSH_TARGET="root@47.82.100.97"
SSH_PASS="Qq141516@"
SSH_OPTS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

run_remote() {
    sshpass -p "$SSH_PASS" ssh $SSH_OPTS "$SSH_TARGET" "$@"
}

echo "=== Current State ==="
run_remote "hostname; uptime"

echo ""
echo "=== Installing MySQL Server ==="
run_remote "dnf install -y mysql-server 2>&1 | grep -E 'Complete|Nothing to do|Error'" 

echo ""
echo "=== Installing Redis ==="
run_remote "dnf install -y redis 2>&1 | grep -E 'Complete|Nothing to do|Error'"

echo ""
echo "=== Installing Nginx ==="
run_remote "dnf install -y nginx 2>&1 | grep -E 'Complete|Nothing to do|Error'"

echo ""
echo "=== Verifying Installations ==="
run_remote "mysqld --version 2>/dev/null; redis-server --version 2>/dev/null; nginx -v 2>&1"

echo ""
echo "=== Starting Services ==="
run_remote "systemctl start mysqld 2>&1; systemctl enable mysqld 2>&1"
run_remote "systemctl start redis 2>&1; systemctl enable redis 2>&1"
run_remote "systemctl start nginx 2>&1; systemctl enable nginx 2>&1"

echo ""
echo "=== MySQL Secure Setup ==="
run_remote "mysqladmin -u root password 'Qq141516@' 2>/dev/null; mysql -u root -p'Qq141516@' -e \"CREATE DATABASE IF NOT EXISTS quanfan_mall DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci; SHOW DATABASES;\" 2>&1"

echo ""
echo "=== DONE ==="
