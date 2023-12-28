FROM php:8.3.1-fpm-alpine3.18

LABEL Maintainer="Nurul Imam <bits.co.id>" \
    Description="Nginx & PHP-FPM v8.3 with lite extensions of Alpine Linux."

LABEL org.opencontainers.image.vendor="Nurul Imam" \
    org.opencontainers.image.url="https://github.com/bitscoid/nginx-php-lite" \
    org.opencontainers.image.source="https://github.com/bitscoid/nginx-php-lite" \
    org.opencontainers.image.title="Nginx & PHP-FPM v8.3 Alpine" \
    org.opencontainers.image.description="Nginx & PHP-FPM v8.3 with minimal extensions of Alpine Linux." \
    org.opencontainers.image.version="6.0" \
    org.opencontainers.image.documentation="https://github.com/bitscoid/nginx-php-lite"

# Install Packages
RUN apk --no-cache --update add \
  curl \
  nginx \
  supervisor \
  && docker-php-ext-install pdo_mysql \
  && rm -rf /var/cache/apk/*

# Configure PHP-FPM
RUN rm /usr/local/etc/php-fpm.conf.default && rm /usr/local/etc/php-fpm.d/www.conf.default
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
RUN sed -ie 's/memory_limit\ =\ 128M/memory_limit\ =\ 1024M/g' /usr/local/etc/php/php.ini
RUN sed -ie 's/\;date\.timezone\ =/date\.timezone\ =\ Asia\/Jakarta/g' /usr/local/etc/php/php.ini
RUN sed -ie 's/upload_max_filesize\ =\ 2M/upload_max_filesize\ =\ 64M/g' /usr/local/etc/php/php.ini
RUN sed -ie 's/post_max_size\ =\ 8M/post_max_size\ =\ 64M/g' /usr/local/etc/php/php.ini
COPY php/www.conf /usr/local/etc/php-fpm.d/www.conf

# Configure Nginx
RUN rm /etc/nginx/nginx.conf && rm /etc/nginx/http.d/default.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/http.d/default.conf /etc/nginx/http.d/default.conf

# Configure Supervisord
COPY supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup Document Root
RUN rm -rf /var/www/html && rm -rf /var/www/localhost
RUN mkdir -p /var/www/bits
COPY app/index.php /var/www/bits/index.php
WORKDIR /var/www/bits
EXPOSE 80

# Make sure files/folders run under the nobody user
RUN chown -R nobody:nobody /var/www/bits /run /var/lib/nginx /var/log/nginx

# Switch to non-root user
USER nobody

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1