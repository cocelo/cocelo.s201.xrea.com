+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/PHP"
date = "2008-10-16T04:12:07Z"
+++


# Apache で PHP を使う  {#he2ae05d}
最近 LAMP という言葉を目にするかと思います。
LAMP とは Linux + Apache + MySQL + PHP の略称で、最近のスタンダードな構成となっています。

# PHP のインストール  {#k058e220}
まずは PHP のインストールからです。


```
# cd /usr/ports/graphics/gd
# make -DBATCH WITH_ICONV=yes install clean

# cd /usr/ports/graphics/ImageMagick
# make WITHOUT_X11=yes install clean

# cd /usr/ports/lang/php5
# make -DBATCH WITH_APACHE=yes WITH_MULTIBYTE=yes WITHOUT_IPV6=yes \
? WITHOUT_SUHOSIN=yes WITH_MAILHEAD=yes WITH_DISCARD=yes \
? WITH_REDIRECT=yes install clean

# cd /usr/ports/lang/php5-extensions
# make -DBATCH WITH_BCMATH=yes WITH_BZ2=yes WITH_CALENDAR=yes \
? WITH_CURL=yes WITH_EXIF=yes WITH_FILEINFO=yes WITH_FTP=yes \
? WITH_GD=yes WITH_GETTEXT=yes WITH_IMAP=yes WITH_LDAP=yes \
? WITH_MBSTRING=yes WITH_MCRYPT=yes WITH_MHASH=yes \
? WITH_MYSQL=yes WITH_OPENSSL=yes WITH_SOAP=yes WITH_SOCKETS=yes \
? WITH_XSL=yes WITH_ZIP=yes WITH_ZLIB=yes \
? install clean

# cp /usr/local/etc/php.ini-recommended /usr/local/etc/php.ini

```

# 基本的な設定  {#o023b27b}
まずは Apache で PHP を使えるように httpd.conf に下記の内容を記述します。


```
# vi /usr/local/etc/apache22/httpd.conf

    #AddType text/html .shtml
    #AddOutputFilter INCLUDES .shtml

    AddType application/x-httpd-php .php
    AddType application/x-httpd-php-source .phps

# /usr/local/etc/rc.d/apache22 restart

```

# 動作確認  {#ncfda746}
PHP が動いているかどうか、下記のファイルを /usr/local/www/apache22/data に保存します。


```
# vi /usr/local/www/apache22/data/info.php

<?php phpinfo() ?>

```

そして Web ブラウザなどでアクセスして、 PHP の情報ページが表示されれば成功です。
