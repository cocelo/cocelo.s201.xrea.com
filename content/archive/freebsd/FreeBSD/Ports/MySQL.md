+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/MySQL"
date = "2008-10-16T04:12:09Z"
+++


# MySQL について  {#k6753ff6}
MySQL は RDBMS ( リレーショナルデータベースを管理、運用するためのシステム ) の実装のひとつで、最近では LAMP ( Linux + Apache + MySQL + PHP ) と言われる程有名なオープンソースソフトウェアのひとつです。この MySQL は WordPress や XOOPS を導入する際に必要になります。

# インストール  {#f3ae9aca}
まずは早速インストールしてみましょう。


```
% sudo portinstall databases/mysql50-server

Remember to run mysql_upgrade (with the optional --datadir=<dbdir> flag)
the first time you start the MySQL server after an upgrade from an
earlier version.

```

# データベースの初期化  {#a40a640a}
インストールが終わったらデータベースの初期化を行います。
この作業を行わないと MySQL が起動できないので注意しましょう。


```
% sudo /usr/local/bin/mysql_install_db

Installing MySQL system tables...
OK
Filling help tables...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:
/usr/local/bin/mysqladmin -u root password 'new-password'
/usr/local/bin/mysqladmin -u root -h server.example.com password 'new-password'
See the manual for more instructions.
You can start the MySQL daemon with:
cd /usr/local ; /usr/local/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl
cd mysql-test ; perl mysql-test-run.pl

Please report any problems with the /usr/local/bin/mysqlbug script!

The latest information about MySQL is available on the web at
http://www.mysql.com
Support MySQL by buying support/licenses at http://shop.mysql.com

```

初期化が終わったらデータベースディレクトリを MySQL を実行するユーザにします。
通常でしたら **mysql:mysql** になります。


```
% sudo chown -R mysql:mysql /var/db/mysql

```

# 設定ファイルのコピー  {#uc9640b9}
データベースの初期化が終わったらデフォルトの設定ファイルをコピーします。
デフォルトの設定ファイルは **/usr/local/share/mysql** 以下にあります。
また、このディレクトリにはインストール時に付属しているファイル等も格納されています。

## デフォルトの設定ファイルの種類  {#v7c87b92}
デフォルトの設定ファイルはいくつかあり、サーバのメモリに応じて変わります。

| 設定ファイル | メモリ搭載量 |
| my-small.cnf | 64M 以下 |
| my-medium.cnf | 128M |
| my-large.cnf | 512M |
| my-huge.cnf | 1G-2G |
| my-innodb-heavy-4G.cnf | 4G ( InnoDB で動かす場合 ) |

## 搭載メモリ容量を調べる  {#mb8ae9e3}
ともあれ、まずはサーバのメモリ搭載量を調べてみましょう。


```
% grep memory /var/run/dmesg.boot

real memory  = 3758030848 (3583 MB)
avail memory = 3682603008 (3512 MB)
pci0: <memory, RAM> at device 0.0 (no driver attached)

```

本来ならこのコマンドを実行したサーバのメモリ搭載量は 4GB なのですが、 32bit OS はメモリ認識限界が 4GB なので若干少なく表示されています。

## 設定ファイルのコピー  {#a6c395bd}
メモリ搭載量は 4GB ですが、他に動かすソフトウェアの事を考えて、 **my-huge.cnf** をコピーします。


```
% sudo cp /usr/local/share/mysql/my-huge.cnf /etc/my.cnf
% sudo chmod 644 /etc/my.cnf

```

## レプリケーションについて  {#ja0b0de0}
MySQL はデータベースのレプリケーションという機能があります。
これはデータベースの内容をバイナリ差分として定期的に書き出し、ダンプ･リストアを容易にできます。
この機能はデフォルトで有効になっており、 **/var/db/mysql** 以下に **mysql-bin.*** として保存されます。

これは大変便利な機能なので、大抵の方は導入されていると思いますが、このバイナリログは通常ではローテーションされないので、放置しているとストレージ容量がいっぱいになり、機能が停止してしまいます。
このバイナリログをローテーションするには **expire_logs_days** を設定します。


```
% sudo /etc/my.cnf

expire_logs_days = 7

```

上記の例では七日過ぎたら古いものから順に削除する、という設定になります。

## バイナリログを無効にするには  {#ocd6c439}
レプリケーションを使う場合、バイナリログはとても重要になりますが、例えばサーバが一台しかない場合などではバイナリログは単にストレージを圧迫するだけのものになります。
バイナリログを無効にするには **log-bin** をコメントアウトします。


```
% sudo vi /etc/my.cnf

#log-bin=mysql-bin

```

# 自動起動の設定  {#bf95d12e}
FreeBSD 起動時に MySQL が自動的に立ち上がるように /etc/rc.conf を編集します。


```
% sudo vi /etc/rc.conf

mysql_enable="YES"

```

また、 jail 環境下では lo ( ループバックインターフェース ) が使用出来ないので、 jail に割り当てた IP アドレスを指定してあげる必要があります。


```
mysql_args="--bind-address=192.168.1.3"

```

# MySQL の起動  {#mce39eac}
上記までの手順で問題なければ MySQL を起動します。


```
% sudo /usr/local/etc/rc.d/mysql-server start

```

# 管理者パスワードの設定  {#ybc16d3c}
データベース初期化後の管理者パスワードは設定されていないので、管理者パスワードを設定しましょう。


```
% sudo mysqladmin -u root password 'PASSWORD'

```

コマンドの履歴が残るのはちょっと･･･という方は一度 MySQL にログインしてからパスワードを変更してください。


```
% mysql -u root
mysql> SELECT User, Host FROM mysql.user;
+------+-----------+
| User | Host      |
+------+-----------+
| root | 127.0.0.1 |
|      | db        |
| root | db        |
|      | localhost |
| root | localhost |
+------+-----------+
mysql> SET PASSWORD FOR root@localhost = password('PASSWORD');
```

次回ログイン時からは **-p** オプションをつけることによってログインできるようになります。


```
% mysql -u root -p

```

# 不要なユーザの削除  {#oc5c0461}
上記のパスワードを設定する際に、 MySQL にログインしてパスワードを変更された方は root アカウントがいくつもあったり、 User の欄が空白のアカウントがいくつかあったりと、違和感を覚えたかと思います。
これは接続元によってそれぞれ使われるアカウントが変わるので、当然と言えば当然なのですが、セキュリティ上好ましくありません。
ここではその不要ユーザの削除の仕方を説明したいと思います。

## 管理者アカウントをひとつにする  {#j3b85a27}
まずは普通に MySQL にログインします。


```
% mysql -u root -p
mysql>

```

次にユーザアカウントの状況を確認します。


```
mysql> SELECT User, Host FROM mysql.user;
+------+-----------+
| User | Host      |
+------+-----------+
| root | 127.0.0.1 |
|      | db        |
| root | db        |
|      | localhost |
| root | localhost |
+------+-----------+
```

この場合では root アカウントが三つ、無名 ( 匿名 ) アカウントが二つとなっています。
この root アカウントの **localhost 以外** を削除してみましょう。


```
mysql> DELETE FROM mysql.user WHERE USER LIKE 'root'
    -> AND HOST LIKE 'db';
mysql> DELETE FROM mysql.user WHERE USER LIKE 'root'
    -> AND HOST LIKE '127.0.0.1';
```

次にユーザ情報をテーブルと同期させます。


```
mysql> FLUSH PRIVILEGES;

```

最後にテーブル状況を確認してみましょう。


```
mysql> SELECT User, Host FROM mysql.user;
+------+-------------+
| User | Host        |
+------+-------------+
|      | db          |
|      | localhost   |
| root | localhost   |
+------+-------------+
```

## 無名 ( 匿名 ) ユーザの削除  {#ue8916e8}
デフォルトではホストごとに無名 ( 匿名 ) ユーザが登録されています。
与えられている権限も最小なので、問題ないのですが、やはりセキュリティを考えて、削除してみることにしましょう。


```
mysql> DELETE FROM mysql.user WHERE USER LIKE '';
mysql> FLUSH PRIVILEGES;
mysql> SELECT User, Host FROM mysql.user;
+------+-------------+
| User | Host        |
+------+-------------+
| root | localhost   |
+------+-------------+
```

# リンク  {#o2185061}
[MySQLのレプリケーションの設定](http://paranoid.dip.jp/kaworu/2008-03-20-1.html "MySQLのレプリケーションの設定")
[MySQLのバイナリログを自動削除する設定](http://paranoid.dip.jp/kaworu/2008-03-20-2.html "MySQLのバイナリログを自動削除する設定")
