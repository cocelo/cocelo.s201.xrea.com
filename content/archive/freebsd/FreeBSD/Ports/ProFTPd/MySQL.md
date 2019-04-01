+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/ProFTPd/MySQL"
date = "2008-10-20T08:41:29Z"
+++

# MySQL でアカウント管理  {#z6c2bf67}
proftpd では MySQL でアカウント管理する事が可能です。 ( 該当オプションを有効にした場合 )
ここではその解説を行います。
なお、前提として proftpd は WITH_MYSQL 付きでインストール済み、初期設定も完了済みとします。

# テーブルの作成  {#hc5a44c5}
まずは MySQL にログインします。

```
# mysql -u root -p

```

次に proftpd 用のデータベースを作成します。

```
mysql> CREATE DATABASE proftpd;

```

次に先ほど作成したデータベースのテーブル情報を定義します。

```
mysql> USE proftpd;

mysql> CREATE TABLE groups (
    ->     groupname VARCHAR(30) NOT NULL ,
    ->     gid SMALLINT(5) UNSIGNED NOT NULL DEFAULT 1000,
    ->     members varchar(255) default NULL,
    ->     PRIMARY KEY ( groupname ),
    ->     UNIQUE KEY gid (gid)
    -> );

mysql> CREATE TABLE users (
    ->     userid varchar(30) NOT NULL,
    ->     password varchar(30) NOT NULL,
    ->     uid SMALLINT(5) UNSIGNED NOT NULL DEFAULT 1000,
    ->     gid SMALLINT(5) UNSIGNED NOT NULL DEFAULT 1000,
    ->     homedir varchar(255) default NULL,
    ->     shell varchar(255) default '/bin/true',
    ->     PRIMARY KEY (userid),
    ->     UNIQUE KEY uid (uid)
    -> );
```

次に ProFTPd 自身が使用するアカウントを作成します。
**proftpd@localhost** が **ユーザ名@ホスト** で、 **IDENTIFIED BY 'proftpd' ** が **IDENTIFIED BY 'パスワード' ** になります。

```
mysql> GRANT SELECT ON proftpd.* TO proftpd@localhost IDENTIFIED BY 'proftpd';

```

最後にテーブル情報を同期して MySQL の前準備は終了です。


```
mysql> FLUSH PRIVILEGES;

```

# ProFTPd の設定  {#b46b9293}
MySQL の設定が済んだら、 ProFTPd の設定を行いましょう。
以下のような文を追記します。


```
# vi /usr/local/etc/proftpd.conf

```


```
<IfModule mod_sql_mysql.c>
   SQLAuthenticate      users
   SQLConnectInfo       proftpd@localhost:3306 proftpd proftpd
   SQLAuthTypes         Crypt
   SQLUserInfo          users userid password uid gid homedir shell
   SQLGroupInfo         groups groupname gid members
   AuthOrder            mod_sql.c
</IfModule>
```

編集したら ProFTPd を再起動しましょう。


```
# /usr/local/etc/rc.d/proftpd restart

```

# ユーザとグループの追加  {#oc99c089}
ProFTPd が正常に起動できたらユーザとグループの追加を行ってみましょう。
まずは MySQL にログインします。


```
# mysql -u root -p proftpd

```

グループの追加方法は下記の通りです。


```
mysql> INSERT INTO groups VALUES ('ftpusers',1000,'');

```

| ftpusers | グループ名 |
| 1000 | gid |

ユーザの追加方法は下記の通りです。


```
mysql> INSERT INTO users VALUES ('testuser',encrypt('testpass'),1000,1000,'/home/testuser','/usr/sbin/nologin');

```

| testuser | ユーザ名 |
| testpass | ユーザのパスワード |
| 1000 | uid |
| 1000 | gid |
| /home/testuser | ホームディレクトリ |
| /bin/true | ユーザのシェル |

# ユーザの削除  {#aacc319a}
今度はユーザ情報の削除を行ってみましょう。
まずは MySQL にログインします。

```
# mysql -u root -p proftpd

```

次に現在のユーザ情報を確認してみましょう。

```
mysql> SELECT * FROM users;
+----------+---------------+------+------+----------------+-------------------+
| userid   | password      | uid  | gid  | homedir        | shell             |
+----------+---------------+------+------+----------------+-------------------+
| testuser | ************* | 1000 | 1000 | /home/testuser | /usr/sbin/nologin |
| hoge     | ************* | 1001 | 1001 | /home/hoge     | /usr/sbin/nologin |
+----------+---------------+------+------+----------------+-------------------+
```

先ほど追加したユーザ ( testuser ) を削除してみます。

```
mysql> DELETE FROM users WHERE userid='testuser';

```

最後にユーザ情報を確認してみましょう。

```
mysql> SELECT * FROM users;
+----------+---------------+------+------+----------------+-------------------+
| userid   | password      | uid  | gid  | homedir        | shell             |
+----------+---------------+------+------+----------------+-------------------+
| hoge     | ************* | 1001 | 1001 | /home/hoge     | /usr/sbin/nologin |
+----------+---------------+------+------+----------------+-------------------+
```

# リンク  {#hd04b5fd}
[proftpd + mysql + ssl - PukiWiki](http://www.tukizakura.org/wiki/index.php?proftpd%20%2B%20mysql%20%2B%20ssl "proftpd + mysql + ssl - PukiWiki")
