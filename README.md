Rainloop Webmail
============

[![](https://images.microbadger.com/badges/version/runningman84/rainloop.svg)](https://hub.docker.com/r/runningman84/rainloop "Click to view the image on Docker Hub")
[![](https://images.microbadger.com/badges/image/runningman84/rainloop.svg)](https://hub.docker.com/r/runningman84/rainloop "Click to view the image on Docker Hub")
[![](https://img.shields.io/docker/stars/runningman84/rainloop.svg)](https://hub.docker.com/r/runningman84/rainloop "Click to view the image on Docker Hub")
[![](https://img.shields.io/docker/pulls/runningman84/rainloop.svg)](https://hub.docker.com/r/runningman84/rainloop "Click to view the image on Docker Hub")

Introduction
----
This docker image installs Rainloop Webmail on Ubuntu Xenial.

A documentation can be found here:
[http://www.rainloop.net/](http://www.rainloop.net/)


Install
----

```sh
docker pull runningman84/rainloop
```

Running
----

```sh
docker run -d -P -p 80:80 runningman84/rainloop
```

The container can be configured using these ENVIRONMENT variables:

Key | Description | Default
------------ | ------------- | -------------
APACHE_MIN_CHILDS | Apache MPM Prefork StartServers | 5
APACHE_MAX_CHILDS | Apache MPM Prefork MaxRequestWorkers | 50
APACHE_MIN_CHILDS_SPARE | Apache MPM Prefork MinSpareServers | 5
APACHE_MAX_CHILDS_SPARE | Apache MPM Prefork MaxSpareServers | 10
APACHE_SERVER_NAME | Apache ServerName | rainloop.loc
APACHE_SERVER_ADMIN | Apache ServerAdmin | webmaster@rainloop.loc
PHP_MAX_POST_SIZE | PHP post_max_size (should outmatch PHP_MAX_UPLOAD_SIZE) | 20M
PHP_MAX_UPLOAD_SIZE | PHP upload_max_filesize | 8M
PHP_MAX_UPLOADS | PHP max_file_uploads | 20
PHP_MAX_EXECUTION_ZIME | PHP max_execution_time | 30
RAINLOOP_ADMIN_LOGIN | Rainloop admin user | admin
RAINLOOP_ADMIN_PASSWORD | Rainloop admin password | 12345

To access admin panel, use URL of the following kind: http://product_installation_URL/?admin

Finally
----
You can integrate rainloop with my cgate docker image in order to have a nice webmail interface:


```
rainloop:
  image: runningman84/rainloop
  mem_limit: 256m
  depends_on:
    - cgate
  ports:
    - 80:80
  environment:
    - APACHE_SERVER_NAME=webmail.example.com
cgate:
  image: runningman84/cgate
  links:
    - spamd:spamd
  ports:
    - 25:25
    - 143:143
    - 8100:8100
    - 9100:9100
    - 8010:8010
    - 9010:9010
  environment:
    - CGPAV_SPAMASSASIN_HOST=spamd
    - MAILSERVER_DOMAIN=example.com
    - MAILSERVER_HOSTNAME=mail.example.com
    - HELPER_THREADS=1
spamd:
  image: runningman84/spamd
```
