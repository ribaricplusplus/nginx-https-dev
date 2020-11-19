include(init.m4) dnl
user  www-data;
worker_processes  auto;

error_log  /var/log/nginx/error.log;
pid        /run/nginx.pid;


events {
    worker_connections  1024;
}


http {
    [[include]]       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;
    proxy_read_timeout M_TIMEOUT;
    proxy_connect_timeout M_TIMEOUT;
    proxy_send_timeout M_TIMEOUT;
    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;
    client_max_body_size 512M;

    [[include]] /etc/nginx/conf.d/*.conf;
    [[include]] /etc/nginx/sites-enabled/*;
}
