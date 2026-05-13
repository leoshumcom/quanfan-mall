#!/bin/bash
set -e
cat > /etc/nginx/conf.d/quanfan-mall.conf << 'NGINX'
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINX
nginx -t 2>&1
systemctl reload nginx 2>&1
curl -s -o /dev/null -w "HTTP %{http_code}" http://localhost/ 2>&1
echo ""
echo "NGINX_PROXY_OK"
