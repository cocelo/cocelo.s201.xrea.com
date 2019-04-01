+++
title = "[PukiWiki:wiki] BSD/FreeBSD/daemontools/cvs"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#s6f97564}

# CVS サーバの構築  {#va1cfb84}
FreeBSD で標準で使える CVS をサーバとして動かすメモ。

## 前提  {#zff6e748}
- inetd 経由ではなく、 **daemontools + tcpserver** で起動
- **daemontools** はすでにインストール済み

## アクセス方法  {#x33d5a1c}
- 内部アクセス
    -  **tcpserver** でプライベートネットワーク内のアクセスのみ許可
- 外部アクセス
    -  SSH を使用

# サービス名の確認  {#ncba1ab0}
**/etc/services** でサービス名とポートを関連付けられているかどうか確認します。


```
# grep cvspserver /etc/services
cvspserver	2401/tcp   #CVS network server
cvspserver	2401/udp   #CVS network server

```

# ユーザの作成  {#xfc56826}
CVS サーバのグループとユーザを作成します。


```
# pw groupadd -n cvsps
# pw useradd -n cvsps -c "CVS network server" -d /nonexistent -g cvsps -h - -s /sbin/nologin
# pw useradd -n cvspslog -c "CVS network server logging" -d /nonexistent -g cvsps -h - -s /sbin/nologin

```

# リポジトリの作成  {#y37a1156}
リポジトリを格納するディレクトリの作成と初期設定を行います。


```
# mkdir -p /usr/local/var/cvsroot
# cvs -d /usr/local/var/cvsroot init
# chmod g+w /usr/local/var/cvsroot
# chgrp -R cvsps /usr/local/var/cvsroot

```

# 起動ディレクトリの作成  {#p35ddc16}
**/usr/local/var/cvs** 以下に必要ディレクトリとファイルを作成します。


```
# mkdir -p /usr/local/var/cvspserver/log/main
# touch /usr/local/var/cvspserver/log/status
# chown cvspslog:cvsps /usr/local/var/cvspserver/log/status
# chown cvspslog:cvsps /usr/local/var/cvspserver/log/main
# chmod +t /usr/local/var/cvspserver

```

# アクセス権限の設定  {#vc9bdfd7}
**passwd** ファイルを用いる事によって、リポジトリにアクセス権限を設定できます。

**passwd** ファイルを作成するには、 Apache をインストールする時に付属している **htpasswd** で作成する事ができます。

初回作成時には **-c** オプションを付けて実行します。

```
# htpasswd -c /usr/local/var/cvsroot/CVSROOT/passwd ユーザ名

```

次回以降は **-c** 付けないで実行します。

```
# htpasswd /usr/local/var/cvsroot/CVSROOT/passwd ユーザ名

```

ユーザを作成したら、リポジトリを操作するユーザと関連付ける為 **passwd** ファイルを編集します。

今回は **cvsps** ユーザを作成したので **ユーザ名:パスワード:cvsps** のように、 **:cvsps** を追記します。


```
# vi /usr/local/var/cvsroot/CVSROOT/passwd

user:pass:cvsps
anonymous::cvsps

```

また、 anonymous ユーザは読み取り専用でチェックアウトできるようにします。


```
# vi /usr/local/var/cvsroot/CVSROOT/readers

anonymous

```

# アクセス制御データベースの作成  {#z5e89739}
**tcpserver** 経由でプライベートネットワーク内のアクセスのみ許可する場合に必要となるのがアクセス制御データベースです。

アクセス制御データベースを作成するには **tcprules** を使用します。

下記の設定は **127.0.0.1** と **192.168.1.0/24** のアクセスは許可し、それ以外からのアクセスは拒否する設定になります。


```
# mkdir -p /usr/local/etc/tcpserver/cvspserver
# cd /usr/local/etc/tcpserver/cvspserver
# vi rules

192.168.1.:allow
127.0.0.1:allow
:deny

# tcprules cvspserver.cdb cvspserver.tmp < rules

```

# シェルスクリプトの作成  {#ta82790f}
起動用シェルスクリプトを作成します。


```
# vi /usr/local/var/cvspserver/run

#!/bin/sh
ulimit -c 0
exec env - \
setuidgid cvsps \
/usr/local/bin/tcpserver -vHRD -l0 -c 10 \
	-x /usr/local/etc/tcpserver/cvspserver/cvspserver.cdb \
	0 cvspserver /usr/bin/cvs -f \
	--allow-root=/usr/local/var/cvsroot \
	pserver 2>&1

```

ログ管理用シェルスクリプトを作成します。


```
# vi /usr/local/var/cvspserver/log/run

#!/bin/sh
exec setuidgid cvspslog multilog t ./main

```

実行権限を付与します。


```
# chmod 755 /usr/local/var/cvspserver/run
# chmod 755 /usr/local/var/cvspserver/log/run

```

# CVS サーバの起動  {#xd57358b}
シンボリックリンクを張ります。


```
# ln -s /usr/local/var/cvspserver /var/service/.

```

**svcstat** で CVS サーバが起動しているか確認します。


```
# svstat /var/service/cvspserver
/var/service/cvspserver: up (pid 577) 131 seconds
# svstat /var/service/cvspserver/log
/var/service/cvspserver/log: up (pid 580) 149 seconds

```

ps で CVS サーバが起動しているか確認します。


```
# ps -auxww | grep cvs

root     67452  0.0  0.0  1324   500  ??  I    11:14PM   0:00.00 supervise cvspserver
cvsps    67454  0.0  0.1  3064   760  ??  I    11:14PM   0:00.01 tcpserver -vHRD -l0 -c 10 -x /usr/local/etc/tcpserver/cvspserver/cvspserver.cdb 0 cvspserver cvs -f --allow-root=/usr/local/var/cvsroot pserver
cvspslog 67455  0.0  0.0  1332   500  ??  I    11:14PM   0:00.00 multilog t ./main

```

# チェックアウトとコミット  {#ecd6af8b}
CVS リポジトリからチェックアウト、ファイルを編集してコミットしてみます。


```
# mkdir work && cd work
# setenv CVSROOT :pserver:ユーザ名@localhost:/usr/local/var/cvsroot
# cvs login
# cvs co .
# cat CVSROOT/config | sed -e s/#SystemAuth=no/SystemAuth=no/ > CVSROOT/config.tmp
# mv CVSROOT/config.tmp CVSROOT/config
# cvs ci -m "Disable system authentication"
# cvs logout

```

# anonymous でチェックアウト  {#o910f21f}
anonymous でチェックアウトしてみます。


```
# setenv CVSROOT :pserver:anonymous@localhost:/usr/local/var/cvsroot
# cvs login
# cvs co .
# cvs logout

```

# ログの確認  {#r0a9859b}
ログファイルをチェックしてみます。


```
# cat /var/service/cvspserver/log/main/current | tai64nlocal

```

# リンク  {#odbaf52e}
- [freeBSD\(とLinux\)雑記:cvsサーバ構築 - livedoor Blog（ブログ）](http://blog.livedoor.jp/tuzzy92/archives/51282640.html "freeBSD\(とLinux\)雑記:cvsサーバ構築 - livedoor Blog（ブログ）")
- [モデルプロジェクトレポジトリ作成メモ](http://www.gfd-dennou.org/library/dcmodel/doc/TEBIKI.dcmodel-cvsroot.htm "モデルプロジェクトレポジトリ作成メモ")
- [Computing Memo of 2004/05/29](http://www.gentei.org/~yuuji/rec/pc/memo/2004/05/29/ "Computing Memo of 2004/05/29")
