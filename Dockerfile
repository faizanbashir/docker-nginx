FROM faizanbashir/alpine:3.7
LABEL MAINTAINER="Faizan Bashir <faizan.ibn.bashir@gmail.com>"

RUN apk --update add nginx && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    mkdir /etc/nginx/sites-enabled/ && \
    mkdir -p /etc/letsencrypt/webrootauth && \
    rm -rf /var/www/* && \
    touch /var/www/favicon.ico && \
    rm -rf /var/cache/apk/*

# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/sites-enabled/default.conf
COPY index.html /var/www/index.html

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]