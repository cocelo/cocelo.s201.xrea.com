+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Apache/PHP/eAccelerator"
date = "2008-12-10T09:33:18Z"
+++

# 目次  {#gbdec5c2}

# リンク  {#fb3dc447}
- [PHP：eAccelerator で PHP 高速化 - Y-110's Wiki](http://php.y-110.net/wiki/index.php?PHP%A1%A7eAccelerator%20%A4%C7%20PHP%20%B9%E2%C2%AE%B2%BD "PHP：eAccelerator で PHP 高速化 - Y-110's Wiki")

# インストール  {#k8718ae4}

```
# portinstall www/eaccelerator

You have installed the eaccelerator package.

Edit /usr/local/etc/php.ini and add:

zend_extension="/usr/local/lib/php/20060613/eaccelerator.so"

Then create the cache directory:

mkdir /tmp/eaccelerator
chown www /tmp/eaccelerator
chmod 0700 /tmp/eaccelerator

```

# eAccelerator の有効化  {#o2f7a448}

```
# echo "extension=eaccelerator.so" >> /usr/local/etc/php/extensions.ini

# vi /usr/local/etc/php.ini

[eaccelerator]
eaccelerator.debug = 0

# mkdir /tmp/eaccelerator
# chown www /tmp/eaccelerator
# chmod 0700 /tmp/eaccelerator

# /usr/local/etc/rc.d/apache22 restart
```

