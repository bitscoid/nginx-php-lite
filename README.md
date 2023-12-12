<div>
  <div align="center">
    <a href="https://bits.co.id">
      <img
        alt="Banten IT Solutions"
        src="https://bits.co.id/wp-content/uploads/Logo.png"
        width="150">
    </a>
  </div>

  <h1 align="center">Docker PHP-FPM 8.3 & Nginx 1.25 on Alpine Linux</h1>

  <h4 align="center">
    Lightweight & optimized <a href="https://www.docker.com/blog/how-to-rapidly-build-multi-architecture-images-with-buildx/">Multi-Arch Docker Images</a> (<code>x86_64</code>/<code>arm</code>/<code>arm64</code>) for <a href="http://nginx.org/en/CHANGES">Nginx 1.25.3</a> & <a href="https://www.php.net/manual/en/install.fpm.php">PHP-FPM</a> <a href="https://www.php.net/ChangeLog-8.php#PHP_8_3">8.3</a>) with essential extensions on top of latest Alpine Linux.
  </h4>

  <div align="center">
    <a href="https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/" title="MariaDB Lite"><img src="https://img.shields.io/docker/pulls/bantenitsolutions/nginx-php-lite.svg"></a> 
    <a href="https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/" title="Docker Image Version (tag latest semver)"><img src="https://img.shields.io/docker/v/bantenitsolutions/nginx-php-lite/4.0"></a> 
    <a href="https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/tags" title="Docker Image Size (tag)"><img src="https://img.shields.io/docker/image-size/bantenitsolutions/nginx-php-lite/4.0"></a> 
    <a href="https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/" title="Nginx 1.25.3"><img src="https://img.shields.io/badge/nginx-1.25.3-brightgreen.svg"></a> 
    <a href="https://hub.docker.com/r/bantenitsolutions/nginx-php-lite/" title="PHP 8.3"><img src="https://img.shields.io/badge/php-8.3-brightgreen.svg"></a> 
    <a href="https://github.com/bitscoid/nginx-php-lite/actions/workflows/build.yml" title="Docker Test Image"><img src="https://github.com/bitscoid/nginx-php-lite/actions/workflows/build.yml/badge.svg?branch=master"></a> 
    <a href="https://bits.co.id" title="License MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a> 
  </div>
</div>


## Description

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

## [![Banten IT Solutions](https://bits.co.id/wp-content/uploads/Logo.png)](https://bits.co.id)
I can help you with [Web & App Development, Containerization, Kubernetes, Monitoring, Infrastructure as Code.](https://bits.co.id).

## Goal of this project
The goal of this container image is to provide an example for running Nginx and PHP-FPM in a container which follows
the best practices and is easy to understand and modify to your needs.

## Usage

Start the Docker container:

    docker run -p 80:80 bantenitsolutions/nginx-php-lite

See the PHP info on http://localhost

Or mount your own code to be served by PHP-FPM & Nginx

    docker run -p 80:80 -v ~/app:/var/www/bits bantenitsolutions/nginx-php-lite

## Configuration
In nginx and php directory you'll find the default configuration files for Nginx, PHP and PHP-FPM.
If you want to extend or customize that you can do so by mounting a configuration file in the correct folder;

Nginx Configuration:

    docker run -v "./server/nginx/nginx.conf:/etc/nginx/http.d/default.conf" bantenitsolutions/nginx-php-lite

Nginx Default Site:

    docker run -v "./server/nginx/http.d/default.conf:/etc/nginx/http.d/default.conf" bantenitsolutions/nginx-php-lite

PHP Configuration:

    docker run -v "./server/php/php.ini:/usr/local/etc/php/php.ini" bantenitsolutions/nginx-php-lite

PHP-FPM Configuration:

    docker run -v "./server/php/www.conf:/usr/local/etc/php-fpm.d/www.conf" bantenitsolutions/nginx-php-lite

## Documentation
Add extra PHP modules

You may use this image as the base image to build your own. For example, to add mongodb module:
Create a Dockerfile

    FROM bantenitsolutions/nginx-php-lite
    RUN apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
        && apk add --no-cache --update --virtual .all-deps $PHP_MODULE_DEPS \
        && pecl install mongodb \
        && docker-php-ext-enable mongodb \
        && rm -rf /tmp/pear \
        && apk del .all-deps .phpize-deps \
        && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

Build Image

    docker build -t my-nginx-php-lite .

To modify this container to your specific needs please see the following examples;

* [Adding xdebug support](https://github.com/bitscoid/nginx-php-lite/blob/master/docs/xdebug.md)
* [Adding composer](https://github.com/bitscoid/nginx-php-lite/blob/master/docs/composer.md)
