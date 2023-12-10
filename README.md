# Docker PHP-FPM 8.3 & Nginx 1.25 on Alpine Linux
Example PHP-FPM 8.3 & Nginx 1.25 container image for Docker, built on [Alpine Linux](https://www.alpinelinux.org/).

Repository: https://github.com/bitscoid/nginx-php-lite

* Built on the lightweight and secure Alpine Linux distribution
* Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
* Very small Docker image size (+/-40MB)
* Uses PHP 8.3 for the best performance, low CPU usage & memory footprint
* Optimized for 100 concurrent users
* Optimized to only use resources when there's traffic (by using PHP-FPM's `on-demand` process manager)
* The services Nginx, PHP-FPM and supervisord run under a non-privileged user (nobody) to make it more secure
* The logs of all the services are redirected to the output of the Docker container (visible with `docker logs -f <container name>`)

[![Docker Pulls](https://img.shields.io/docker/pulls/bitscoid/nginx-php-lite.svg)](https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/)
![nginx 1.25](https://img.shields.io/badge/nginx-1.25-brightgreen.svg)
![php 8.3](https://img.shields.io/badge/php-8.3-brightgreen.svg)
![License MIT](https://img.shields.io/badge/license-MIT-blue.svg)

## [![Banten IT Solutions](https://bits.co.id/wp-content/uploads/Logo.png)](https://bits.co.id)
I can help you with [Web & App Development, Containerization, Kubernetes, Monitoring, Infrastructure as Code.](https://bits.co.id).

## Goal of this project
The goal of this container image is to provide an example for running Nginx and PHP-FPM in a container which follows
the best practices and is easy to understand and modify to your needs.

## Usage

Start the Docker container:

    docker run -p 80:80 bitscoid/nginx-php-lite

See the PHP info on http://localhost

Or mount your own code to be served by PHP-FPM & Nginx

    docker run -p 80:80 -v ~/app:/var/www/bits bitscoid/nginx-php-lite

## Configuration
In nginx and php directory you'll find the default configuration files for Nginx, PHP and PHP-FPM.
If you want to extend or customize that you can do so by mounting a configuration file in the correct folder;

Nginx Configuration:

    docker run -v "./server/nginx/nginx.conf:/etc/nginx/http.d/default.conf" bitscoid/nginx-php-lite

Nginx Default Site:

    docker run -v "./server/nginx/http.d/default.conf:/etc/nginx/http.d/default.conf" bitscoid/nginx-php-lite

PHP Configuration:

    docker run -v "./server/php/php.ini:/usr/local/etc/php/php.ini" bitscoid/nginx-php-lite

PHP-FPM Configuration:

    docker run -v "./server/php/www.conf:/usr/local/etc/php-fpm.d/www.conf" bitscoid/nginx-php-lite

## Documentation and examples
To modify this container to your specific needs please see the following examples;

* [Adding xdebug support](https://github.com/bitscoid/nginx-php-lite/blob/master/docs/xdebug.md)
* [Adding composer](https://github.com/bitscoid/nginx-php-lite/blob/master/docs/composer.md)