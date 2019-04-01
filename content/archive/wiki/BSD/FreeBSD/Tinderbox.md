+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Tinderbox"
date = "2009-10-16T23:09:47Z"
+++


# はじめに  {#md772e5a}
7-STABLE での Tinderbox 構築メモ。
目標としては現行RELEASE、STABLE、CURRENT ( 任意 ) での主要 Ports Collection の package 化。
Lighttpd + FastCGI + MySQL の構成を前提。

# インストール  {#d217cc5e}

## portinstall を使用する場合  {#g25a6980}


```
$ sudo portinstall ports-mgmt/tinderbox
```


```
===============================================================================
ports-mgmt/tinderbox is now installed, but it requires some additional setup.
****************************************************
Please do read: /usr/local/tinderbox/scripts/README
****************************************************

The following walkthrough is the webserver setup:
- In your Apache configuration add the following lines:

  Alias /tb/logs/ "/usr/local/tinderbox/logs/"
  Alias /tb/packages/ "/usr/local/tinderbox/packages/"
  Alias /tb/errors/ "/usr/local/tinderbox/errors/"
  Alias /tb/ "/usr/local/tinderbox/scripts/webui/"
  <Directory "/usr/local/tinderbox/">
      Order allow,deny
      Allow from all
  </Directory>

- In your Lighttpd configuration:

Turn on "mod_alias" and add the following lines:

alias.url = (	"/tb/logs/" => "/usr/local/tinderbox/logs/",
		"/tb/packages/" => "/usr/local/tinderbox/packages/",
		"/tb/errors/" => "/usr/local/tinderbox/errors/",
		"/tb/" => "/usr/local/tinderbox/scripts/webui/" )
dir-listing.activate = "enable"

  Check your system by going to http://localhost/tb/

=============================================================================
```

## 公式 HP から tar を取得、展開する場合  {#j7c207c9}


```
$ fetch http://tinderbox.marcuscom.com/tinderbox-3.2.tar.gz
$ sudo mkdir /usr/jails/tinderbox
$ sudo tar xvf tinderbox-3.2.tar.gz -C /usr/jails/tinderbox -s '/tinderbox-3.2/scripts/'
```

# 設定  {#d56ddcb5}

## 設定ファイルのコピー  {#o1d12866}

```
$ sudo cp /usr/local/tinderbox/scripts/ds.ph.dist /usr/local/tinderbox/scripts/ds.ph
$ sudo cp /usr/local/tinderbox/scripts/tinderbox.ph.dist /usr/local/tinderbox/scripts/tinderbox.ph
$ sudo cp /usr/local/tinderbox/scripts/webui/inc_ds.php.dist /usr/local/tinderbox/scripts/webui/inc_ds.php
$ sudo cp /usr/local/tinderbox/scripts/webui/inc_tinderbox.php.dist /usr/local/tinderbox/scripts/webui/inc_tinderbox.php
```

## MySQL のデータベースとユーザの作成  {#qe224ae8}

```
$ mysql -u root -p
```


```
> CREATE DATABASE tinderbox;
> GRANT SELECT, INSERT, UPDATE, DELETE ON tinderbox.* TO tinderbox@localhost IDENTIFIED BY "password";
> FLUSH PRIVILEGES;
> exit
```

## MySQL スキーマのインポート  {#k4b17a9b}


```
$ cd /usr/local/tinderbox/scripts/sql && sudo ./genschema mysql | mysql -u root -p -h localhost tinderbox
```

## WebUI で使用するデータベースとユーザの設定  {#z8a60aaa}


```
$ sudoedit /usr/local/tinderbox/scripts/ds.ph
```


```
$DB_DRIVER       = 'mysql';
#$DB_DRIVER       = 'Pg';
$DB_HOST         = 'localhost';
$DB_NAME         = 'tinderbox';
$DB_USER         = 'tinderbox';
$DB_PASS         = 'password';
$DBI_TYPE        = 'database';

1;
```


```
$ sudoedit /usr/local/tinderbox/scripts/webui/inc_ds.php
```


```
<?php

$DB_DRIVER = 'mysql';
#$DB_DRIVER = 'pgsql';
$DB_HOST = 'localhost';
$DB_NAME = 'tinderbox';
$DB_USER = 'tinderbox';
$DB_PASS = 'password';

?>
```

## Tinderbox の設定  {#t86eef24}


```
$ sudoedit /usr/local/tinderbox/scripts/tinderbox.ph
```


```
# Configurable options
$TINDERBOX_HOST  = 'http://tinderbox.example.com';
$TINDERBOX_URI   = '/tb';
$SUBJECT         = 'Example Tinderbox:';
$SENDER          = 'tinderbox@example.com';
$SMTP_HOST       = 'mail.example.com';

# These should probably be left alone
$LOGS_URI        = $TINDERBOX_URI . '/logs';
$SHOWBUILD_URI   = $TINDERBOX_URI . '/index.php?action=list_buildports&build=';
$SHOWPORT_URI    = $TINDERBOX_URI . '/index.php?action=describe_port&id=';

1;
```


```
$ sudoedit /usr/local/tinderbox/scripts/webui/inc_tinderbox.php
```


```

<?php

# Configurable options
$tinderbox_name  = 'Example Tinderbox';
$tinderbox_title = 'Example Tinderbox';
$wwwrootdir      = dirname( __FILE__ );
$rootdir         = realpath( $wwwrootdir . '/../..' );
$protocol        = isset( $_SERVER['HTTPS'] ) ? 'https' : 'http';
$host            = $_SERVER['SERVER_NAME'];
$wwwrooturi      = $protocol . '://' . $host;
if ($_SERVER['SERVER_PORT'] != 80)
        $wwwrooturi     .= ':' . $_SERVER['SERVER_PORT'];
$wwwrooturi     .= dirname( $_SERVER['SCRIPT_NAME'] );
# Comment out the next line, and uncomment the line after it to enable
# the paefchen frontend template.
#$template_dir    = 'default';
$template_dir     = 'paefchen';

# These should probably be left alone
$pkguri          = $wwwrooturi.'/packages';
$pkgdir          = $rootdir.'/packages';
$loguri          = $wwwrooturi.'/logs';
$logdir          = $rootdir.'/logs';
$errorloguri     = $wwwrooturi.'/errors';
$errorlogdir     = $rootdir.'/errors';
$templatesdir    = $wwwrootdir.'/templates/'.$template_dir;
$templatesuri    = $wwwrooturi.'/templates/'.$template_dir;
#$with_timer     = 1;

?>
```

# 初期化  {#b6c16f4d}


```
$ sudo /usr/local/tinderbox/scripts/tc init
```


```
Enter a default cvsup host [cvsup12.FreeBSD.org]: localhost
Enter a default update type or command [CSUP]:
Default update host and type have been set.  These can be changed later by
modifying /usr/local/tinderbox/scripts/etc/env/GLOBAL.
```

# ccache を使用する場合  {#hf33a4e2}


```
$ sudo /usr/local/tinderbox/scripts/tc configCcache -e -c /var/ccache -s 2G -l /var/log/ccache.log
```

# Ports Options を設定する場合  {#j82f6312}


```
$ sudo /usr/local/tinderbox/scripts/tc configOptions -e
$ sudo /usr/local/tinderbox/scripts/tc configOptions -o /options
```

# WebUI 管理ユーザの追加  {#w4d6ea31}


```
$ sudo /usr/local/tinderbox/scripts/tc addUser -u tinderbox -e tinderbox@example.com -p password -w
$ sudo /usr/local/tinderbox/scripts/tc setWwwAdmin -u tinderbox
```

# ユーザランドの作成  {#z942725f}


```
$ sudo /usr/local/tinderbox/scripts/tc createJail -j 7-STABLE -d "FreeBSD 7-STABLE" -t RELENG_7 -u CSUP -H localhost
```

| -j | 名前 |
| -d | 簡単な説明 |
| -t | ターゲットのタグ |
| -u | CVSUP or CSUP or NONE |
| -H | cvsup サーバ |
| -m | nullfs or nfs マウントする場合は指定 |

上記はsrcツリーを新規に取得しているが、すでにあるsrcツリーを利用する場合には以下のようにする。


```
$ sudo /usr/local/tinderbox/scripts/tc createJail -j 7-STABLE -d "FreeBSD 7-STABLE" -t RELENG_7 -u NONE -m /usr/src
```

# ports ツリーの作成  {#l2f43aa2}

## cvsup で ports ツリーを取得する場合  {#ud5ecf3b}


```
$ sudo /usr/local/tinderbox/scripts/tc createPortsTree -p Ports -d "FreeBSD ports tree" -w http://www.freshports.org
```

## nfs でマウントする場合  {#kcbbd25c}


```
$ sudo /usr/local/tinderbox/scripts/tc createPortsTree -p Ports -u NONE -m server:/usr/ports -d "FreeBSD ports tree" -w http://www.freshports.org
```

## nullfs でマウントする場合  {#h5d19ce8}


```
$ sudo /usr/local/tinderbox/scripts/tc createPortsTree -p Ports -u NONE -m /usr/ports -d "FreeBSD ports tree" -w http://www.freshports.org
```

# distfiles の保存先  {#gf731229}

## nfs でマウントする場合  {#kcbbd25c}


```
$ sudo /usr/local/tinderbox/scripts/tc configDistfile -c server:/usr/ports/distfiles
```

## nullfs でマウントする場合  {#h5d19ce8}


```
$ sudo /usr/local/tinderbox/scripts/tc configDistfile -c /usr/ports/distfiles
```

# Build 環境の作成  {#p37875cc}


```
$ sudo /usr/local/tinderbox/scripts/tc createBuild -b 7-STABLE -j 7-STABLE -p FreeBSD -d "7-STABLE with FreeBSD ports tree"
```

# rc スクリプトを有効に  {#zfd64bd3}


```
$ sudoedit /etc/rc.conf
```


```
tinderd_enable="YES"
tinderd_directory="/usr/local/tinderbox/scripts"
tinderd_flags="-nullfs"
```


```
$ sudo /usr/local/etc/rc.d/tinderbox start
```

# Build Queue の追加  {#cba709d2}


```
$ sudo /usr/local/tinderbox/scripts/tc addBuildPortsQueueEntry -b 7-STABLE -d lang/perl5.8
```

# Lighttpd + FastCGI の設定  {#cfc89a6d}


```
$ sudoedit /usr/local/etc/lighttpd.conf
```


```
server.modules              = (
#                               "mod_rewrite",
#                               "mod_redirect",
                                "mod_alias",
                                "mod_access",
#                               "mod_cml",
#                               "mod_trigger_b4_dl",
#                               "mod_auth",
#                               "mod_status",
#                               "mod_setenv",
                                "mod_fastcgi",
#                               "mod_proxy",
#                               "mod_simple_vhost",
#                               "mod_evhost",
#                               "mod_userdir",
#                               "mod_cgi",
#                               "mod_compress",
#                               "mod_ssi",
#                               "mod_usertrack",
#                               "mod_expire",
#                               "mod_secdownload",
#                               "mod_rrdtool",
                                "mod_accesslog" )

<--snip-->

## virtual directory listings
dir-listing.activate       = "enable"

<--snip-->

#### fastcgi module
## read fastcgi.txt for more info
## for PHP don't forget to set cgi.fix_pathinfo = 1 in the php.ini
fastcgi.server             = ( ".php" =>
                               ( "localhost" =>
                                 (
                                   "socket" => "/var/run/fcgidsock/lighttpd.php.socket",
                                   "bin-path" => "/usr/local/bin/php-cgi"
                                 )
                               )
                            )

<--snip-->

alias.url = (	"/tb/logs/" => "/usr/local/tinderbox/logs/",
		"/tb/packages/" => "/usr/local/tinderbox/packages/",
		"/tb/errors/" => "/usr/local/tinderbox/errors/",
		"/tb/" => "/usr/local/tinderbox/scripts/webui/" )
```

# ユーザランドのアップデート  {#n2967438}


```
$ sudo ./tc makeJail -j 7-STABLE
```

# Ports ツリーのアップデート  {#xe23dcd3}


```
$ sudo ./tc updatePortsTree -p FreeBSD
```

# 参考リンク  {#z59f736a}
[Marcuscom Tinderbox](http://tinderbox.marcuscom.com/ "Marcuscom Tinderbox")
[Marcuscom Tinderbox Readme](http://tinderbox.marcuscom.com/README.html "Marcuscom Tinderbox Readme")
[Tinderbox - FreeBSD Wiki](http://wiki.freebsd.org/Tinderbox "Tinderbox - FreeBSD Wiki")
[FreeBSDのports/packagesビルドシステムtinderboxを使う - mteramotoの日記](http://d.hatena.ne.jp/mteramoto/20090517/p1 "FreeBSDのports/packagesビルドシステムtinderboxを使う - mteramotoの日記")
