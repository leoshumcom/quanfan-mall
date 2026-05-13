#!/bin/bash
sshpass -p "Qq141516@" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@47.82.100.97 bash -s << 'REMOTE'
  echo "=== Search mysql-server ==="
  dnf search mysql-server 2>/dev/null | head -20
  echo "=== Search mariadb ==="
  dnf search mariadb 2>/dev/null | head -20
  echo "=== Search nginx ==="
  dnf search nginx 2>/dev/null | head -20
  echo "=== Search httpd ==="
  dnf search httpd 2>/dev/null | head -5
REMOTE
