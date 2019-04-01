+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/MySQL/Command"
date = "2008-11-25T17:05:47Z"
+++


# データベース/ユーザの追加  {#vd46f32e}

| データベース名 | example |
| ユーザ名 | example |
| 接続元ホスト | localhost |
| 接続先データベース | example |
| ユーザのパスワード | password |


```
$ mysql -u root -p
```


```
> CREATE DATABASE example;
> GRANT ALL ON example.* TO example@localhost IDENTIFIED BY "password";
> FLUSH PRIVILEGES;
```

権限を絞る場合は以下のようにする。


```
$ mysql -u root -p
```


```
> CREATE DATABASE example;
> GRANT SELECT, INSERT, UPDATE, DELETE ON example.* TO example@localhost IDENTIFIED BY "password";
> FLUSH PRIVILEGES;
```

[MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.1.6 CREATE DATABASE 構文](http://dev.mysql.com/doc/refman/5.1/ja/create-database.html "MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.1.6 CREATE DATABASE 構文")
[MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.5.1.3 GRANT 構文](http://dev.mysql.com/doc/refman/5.1/ja/grant.html "MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.5.1.3 GRANT 構文")

# データベース/ユーザの削除  {#pf5f30ad}


```
$ mysql -u root -p
```


```
> DROP DATABASE example;
> DROP USER example;
> FLUSH PRIVILEGES;
```

[MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.1.12 DROP DATABASE 構文](http://dev.mysql.com/doc/refman/5.1/ja/drop-database.html "MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.1.12 DROP DATABASE 構文")
[MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.5.1.2 DROP USER 構文](http://dev.mysql.com/doc/refman/5.1/ja/drop-user.html "MySQL :: MySQL 5.1 リファレンスマニュアル :: 12.5.1.2 DROP USER 構文")
