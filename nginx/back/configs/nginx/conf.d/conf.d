server {
    listen 80;
    server_name domen.ru;
    return 301 https://$host$request_uri;
}
server {
    listen 80;
    server_name https://domen.ru;
    return 301 https://$host$request_uri;
}
server {
    listen 443 ssl;
    server_name domen..ru;
    access_log /dev/stdout;
    error_log /dev/stdout info;
    index index.php;
    root /data/public;
    ssl_certificate /etc/nginx/ssl/full.cert;
    ssl_certificate_key /etc/nginx/ssl/priv.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'TLS_AES_256_GCM_SHA384:ECDHE-ECDSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
#     location /pl_laravel_log/ {
#         alias /var/www/app/storage/logs/;
#         autoindex on;
#     }

    location / {
             try_files $uri $uri/ /index.php$is_args$args;
             #return 301 http://$host$request_uri;
        }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass domen_back_fpm:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        }
}
