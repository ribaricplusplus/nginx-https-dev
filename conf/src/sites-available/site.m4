include(init.m4) dnl
server {
        listen 8080 ssl http2;
        root /var/www/html;
        [[index]] [[index]].php [[index]].html;
        [[include]] snippets/self-signed.conf;
        [[include]] snippets/ssl-params.conf;
}

