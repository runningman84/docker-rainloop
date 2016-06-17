Rainloop Webmail
============

Introduction
----
This docker image installs Rainloop Webmail on Ubuntu Xenial.

A documentation can be found here:
http://www.rainloop.net/


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

Finally
----
You can integrate rainloop with my cgate docker image in order to have a nice webmail interface. A tutorial will be published soon.
