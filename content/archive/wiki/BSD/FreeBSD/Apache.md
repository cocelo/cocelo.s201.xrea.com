+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Apache"
date = "2008-12-10T09:33:18Z"
+++

# Apache Memo  {#t860a5de}


## Link  {#re8ec2f0}
[FreeBSD Notes - apache20からapache22のportに移行した](http://www.xdelta.net/blog/FreeBSD/2006/05/04/p183 "FreeBSD Notes - apache20からapache22のportに移行した")

## Memo  {#sd7e3ccf}
-Cronolog ディレクトリを月日別に掘って分割出来たりする。

[Cronolog](http://cronolog.org/ "Cronolog")

[sysutils/cronolog](http://www.freebsd.org/cgi/cvsweb.cgi/ports/sysutils/cronolog/ "sysutils/cronolog")

-Visitors ログ解析。かなり高速らしい。

[Visitors - fast web log analyzer](http://www.hping.org/visitors/ "Visitors - fast web log analyzer")

[www/visitors](http://www.freebsd.org/cgi/cvsweb.cgi/ports/www/visitors/ "www/visitors")

## First Step  {#uf46b9c2}
事前に [Kernel](/archive/wiki/BSD/FreeBSD/Kernel/ "Kernel") と [pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") の設定をしておくこと。

## Install  {#caf54958}

```
# portinstall converters/libiconv
# portinstall devel/apr
# portinstall www/apache22
# rehash

# vi /etc/rc.conf

apache22_enable="YES"
apache22_http_accept_enable="YES"

# /usr/local/etc/rc.d/apache22 start

```

## Setting  {#g338a5c3}
オリジナルの設定ファイルをコピーする。

```
# cp -R /usr/local/etc/apache22 /usr/local/etc/apache22.orig
```

差分を取る。

```
# diff -urN /usr/local/etc/apache22.orig /usr/local/etc/apache22 > test.diff
```

