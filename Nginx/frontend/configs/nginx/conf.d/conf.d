server {
    listen 80;
    server_name domen.ru;
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl;
    server_name domen.ru;
#    access_log /dev/stdout;
#    error_log /dev/stdout info;
    index index.html;
    ssl_certificate /etc/nginx/ssl/full_germes.cert;
    ssl_certificate_key /etc/nginx/ssl/priv_germes.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;

    location / {
    proxy_pass http://germes_web:8590;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
