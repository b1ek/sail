FROM alpine:3.17
LABEL maintainer="blek! <me@blek.codes>"

USER root

WORKDIR /var/www/html

# update
RUN apk update

# create nginx user and grounp
RUN addgroup -g 101 -S nginx && \
    adduser -S -D -H -u 101 -h /var/www/nginx -G nginx -g nginx nginx

# some script dependencies
RUN apk add --no-cache \
    jq curl wget ncurses

# nginx with php
RUN apk add --no-cache \
    nginx \
    php81 php81-fpm \
    php81-bcmath php81-ctype php81-curl php81-dom php81-fileinfo php81-json php81-mbstring \
    php81-openssl php81-pdo php81-tokenizer php81-xml php81-xmlwriter php81-session \
    composer

# base laravel project
COPY base /var/www/html
RUN composer install

# configs
COPY nginx.conf /etc/nginx

# But it works!™
RUN \
    sed -i '17ipid = /run/php/pid' /etc/php81/php-fpm.conf && \
    sed -i '37ilisten = /run/php/sock' /etc/php81/php-fpm.d/www.conf && \
    sed -i '49ilisten.owner = nginx' /etc/php81/php-fpm.d/www.conf && \
    sed -i '50ilisten.group = nginx' /etc/php81/php-fpm.d/www.conf && \
    sed -i '51ilisten.mode = 0660' /etc/php81/php-fpm.d/www.conf

# make directories
RUN \
    mkdir /run/php && \
    mkdir /etc/nginx/log && \
    touch /var/log/nginx/error.log && \
    touch /var/log/nginx/access.log

# give storage permissions to nginx
RUN \
    chown -R nobody:nobody storage && \
    chmod -R 775 storage

COPY docker-entrypoint.sh /
COPY entrypoint /docker-entrypoint.d
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
