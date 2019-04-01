+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Apache/PHP"
date = "2008-12-10T09:33:18Z"
+++

# PHP Memo  {#x847036d}


## First Step  {#j8fe927f}
[pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") の設定を済ましておく。

[Apache](/archive/wiki/BSD/FreeBSD/Apache/ "Apache") をインストールしておく。

## Install  {#dd3072c2}

```
# portinstall lang/php5
# portinstall lang/php5-extensions
# rehash

# cp /usr/local/etc/php.ini-recommended /usr/local/etc/php.ini

```

## Setting  {#o72ce6ad}

```
# vi /usr/local/etc/apache22/httpd.conf

DirectoryIndex index.html index.htm index.cgi index.php
AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
```

