+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Japanese/lv"
date = "2008-10-16T04:12:08Z"
+++


# lv について  {#a61059eb}
FreeBSD 付属のページャ less ( or more ) では日本語表示が出来ないので、 lv をインストールします。
lv は UTF-8 の表示にも対応しているので、環境変数 LANG が ja_JP.UTF-8 の場合には重宝するかと思います。

# インストール  {#s8e96a09}
sudo でインストールします。


```
% sudo portinstall japanese/less
% rehash

```

# 設定  {#h1cb03a7}
ユーザーの環境変数 PAGER を lv に置き換えます。


```
% vi ~/.cshrc

alias less lv

setenv	PAGER	lv

```

root の環境変数 PAGER を lv に置き換えます。


```
% sudo vi /root/.cshrc

alias less	lv

setenv	PAGER	lv

```

最後に新しくユーザーを作る際にもこの設定が有効になるようにします。


```
% sudo vi /usr/share/skel/dot.cshrc

alias less	lv

setenv	PAGER	lv
```

