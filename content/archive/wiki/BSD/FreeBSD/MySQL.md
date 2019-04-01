+++
title = "[PukiWiki:wiki] BSD/FreeBSD/MySQL"
date = "2008-12-10T09:33:19Z"
+++

# 目次  {#yc76eab9}


# インストール  {#z22fbfc9}

```
# portinstall databases/mysql50-server

Remember to run mysql_upgrade (with the optional --datadir=<dbdir> flag)
the first time you start the MySQL server after an upgrade from an
earlier version.

```

# データベース初期化  {#q4eab5e4}

```
# /usr/local/bin/mysql_install_db

Installing MySQL system tables...
OK
Filling help tables...
OK

To start mysqld at boot time you have to copy
support-files/mysql.server to the right place for your system

PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
To do so, start the server, then issue the following commands:
/usr/local/bin/mysqladmin -u root password 'new-password'
/usr/local/bin/mysqladmin -u root -h server.clx.ath.cx password 'new-password'
See the manual for more instructions.
You can start the MySQL daemon with:
cd /usr/local ; /usr/local/bin/mysqld_safe &

You can test the MySQL daemon with mysql-test-run.pl
cd mysql-test ; perl mysql-test-run.pl

Please report any problems with the /usr/local/bin/mysqlbug script!

The latest information about MySQL is available on the web at
http://www.mysql.com
Support MySQL by buying support/licenses at http://shop.mysql.com

# chown -R mysql:mysql /var/db/mysql

```

# my.cnf のコピー  {#la1753e9}
サーバ搭載メモリの容量で設定ファイルを選択する。

- my-small.cnf
    -  64M 以下
- my-medium.cnf
    -  128M
- my-large.cnf
    -  512M
- my-huge.cnf
    -  1G-2G


```
# cp /usr/local/share/mysql/my-large.cnf /etc/my.cnf

```

レプリケーションを使わない場合は log-bin を無効にする。


```
# vi /etc/my.cnf

#log-bin=mysql-bin

```

もしくは expire_logs_days を設定して、バイナリログのローテーションをする。


```
# vi /etc/my.cnf

expire_logs_days=7

```

# 自動起動の設定  {#de7d765c}

```
# vi /etc/rc.conf

mysql_enable="YES"

```

# 起動  {#td653ab2}

```
# /usr/local/etc/rc.d/mysql-server start

```

# root のパスワード設定  {#u1b6df49}

```
# mysqladmin -u root password 'PASSWORD'
# mysqladmin -u root -h s1.clx.ath.cx password 'PASSWORD'

```

# @local.domain を削除する場合  {#o1f7645a}

```
# mysql -u root -p
Enter password: ********

mysql> SELECT User, Host FROM mysql.user;
+----------+--------------+
| User     | Host         |
+----------+--------------+
|          | 192.168.0.20 |
| root     | 192.168.0.20 |
|          | localhost    |
| root     | localhost    |
+----------+--------------+
5 rows in set (0.01 sec)

mysql> DELETE FROM mysql.user WHERE USER LIKE 'root'
    -> AND HOST LIKE '192.168.0.20';

mysql> FLUSH PRIVILEGES;

mysql> SELECT User, Host FROM mysql.user;
+----------+--------------+
| User     | Host         |
+----------+--------------+
|          | 192.168.0.20 |
|          | localhost    |
| root     | localhost    |
+----------+--------------+
4 rows in set (0.01 sec)

mysql> DELETE FROM mysql.user WHERE HOST LIKE '192.168.0.20';

mysql> FLUSH PRIVILEGES;

mysql> SELECT User, Host FROM mysql.user;
+----------+--------------+
| User     | Host         |
+----------+--------------+
|          | localhost    |
| root     | localhost    |
+----------+--------------+
4 rows in set (0.01 sec)

mysql> DELETE FROM mysql.user WHERE USER LIKE ''
    -> AND HOST LIKE 'localhost';

mysql> FLUSH PRIVILEGES;

mysql> SELECT User, Host FROM mysql.user;
+----------+--------------+
| User     | Host         |
+----------+--------------+
| root     | localhost    |
+----------+--------------+
4 rows in set (0.01 sec)

```

# SSL 証明書の利用  {#zd3d2b64}

```
# cd /usr/local/share/mysql

```

以下の内容をopenssl.shなどの名前で保存、実行。

&ref(openssl.txt);


```
# cd openssl
# chown mysql server-key.pem
# chmod 600 server-key.pem
# cp my.cnf /etc/

# vi /etc/my.cnf

[client]
default-character-set = utf8
[mysqld]
default-character-set = utf8
[mysql]
default-character-set = utf8
[mysqldump]
default-character-set = utf8

```

# Link  {#vbcebf18}
[MySQL + OpenSSL 続き：どうでもいいブログ - AOLダイアリー](http://diary.jp.aol.com/fud9ay8dyeh/38.html "MySQL + OpenSSL 続き：どうでもいいブログ - AOLダイアリー")

[MySQL AB :: MySQL 5.0 Reference Manual :: 5.9.7.4 Setting Up SSL Certificates for MySQL](http://dev.mysql.com/doc/refman/5.0/en/secure-create-certs.html "MySQL AB :: MySQL 5.0 Reference Manual :: 5.9.7.4 Setting Up SSL Certificates for MySQL")
