+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Visitors"
date = "2008-11-17T13:08:07Z"
+++


# Visitorsのインストール  {#z01039af}
以下のサイトで日本語化されたものが公開されています。
[Apache ログ解析 Visitors 0.7 日本語化 ver.2 | Linux | ソフトの窓](http://www.sfree.sc/linux/customizing/287.html "Apache ログ解析 Visitors 0.7 日本語化 ver.2 | Linux | ソフトの窓")


```
$ fetch http://www.sfree.sc/download/visitors_0.7-JP2.tar.gz
$ tar xvf visitors-0.7-JP2.tar.gz
$ cd visitors_0.7
$ make
$ sudo cp -a visitors /usr/local/bin
```

# VIsitorsでアクセスログを解析させてみる  {#v41d63a2}

```
$ visitors -A -m 30 /var/log/apache22/httpd_access.log -o html > /usr/local/www/apache22/data/report.html
```
