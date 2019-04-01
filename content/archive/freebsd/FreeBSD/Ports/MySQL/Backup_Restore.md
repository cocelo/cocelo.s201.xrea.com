+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/MySQL/Backup_Restore"
date = "2008-10-17T20:01:37Z"
+++

# データベースのバックアップとリストア  {#oedf9714}
MySQL のデータベースのバックアップとリストア ( 復元 ) 方法のメモです。
バックアップ & リストアには MySQL 付属のツールを使用します。

# mysqldump  {#z1c620af}
SQLクエリの形式でバックアップします。
中身はテキストなので、メモ帳などで中身を見る事が出来ます。

## 全てのデータベースをバックアップ & リストア。  {#p782680a}

```
# mysqldump -u root -p --all-databases > dump.sql
# mysql -u root -p < dump.sql

```

## 特定のデータベースをバックアップ & リストア。  {#heb7d4ae}

```
# mysqldump -u root -p データベース名 > dump.sql
# mysql -u root -p < dump.sql
```

