+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Utility/sudo"
date = "2008-10-16T04:12:12Z"
+++


# sudo  {#k203d89a}
sudo は一般ユーザーでありながら root 権限を持ったコマンドを実行出来る優れもの。

# インストール  {#q384d713}
さくっとインストールします。


```
# portinstall security/sudo
# rehash

```

# 設定  {#i427a9a6}
sudo を使えるユーザーを管理者アカウントのみにします。


```
# visudo

# %wheel	ALL=(ALL) NOPASSWD: SETENV: ALL
%wheel	ALL=(ALL) NOPASSWD: SETENV: ALL
```

