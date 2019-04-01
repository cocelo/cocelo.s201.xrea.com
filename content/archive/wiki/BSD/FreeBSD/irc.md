+++
title = "[PukiWiki:wiki] BSD/FreeBSD/irc"
date = "2008-12-10T09:33:20Z"
+++

# 目次  {#bb11a643}


# はじめに  {#t1838614}
IRC とかここ何年か使ってなかったけど、ここにきて IRC の便利さを知った。

ので、身内で使う事を前提にした IRC サーバ作りをしてみる。

wide 系とかと接続したいって場合はもっと煮詰めないとダメかも。

# split-mode ident での確認を無くすパッチ  {#zbcb4842}
まずパッチを **/root/patch** にでもダウンロードしてください。

# 実は IAUTH も無効にしちゃってるけどこれは起動時のフラグに **-s** を付ければ無効に出来る。

# ただ起動スクリプトがお粗末なのでソース側から無効にしちゃえというお話。


```
# fetch http://cocelo.s201.xrea.com/patch/irc-server-2.11.1p1.patch

```

次に portupgrade を導入してる方なら下記のように BEFOREBUILD でパッチを当てるのがオススメ。


```
  BEFOREBUILD = {
	'irc/irc' => 'cp /root/patch/irc-server-2.11.1p1.patch /usr/ports/irc/irc/files/patch-support::config.h.dist',
  }

```

ただし将来このパッチ名が被らないとも限らないのでその場合は適当に名前を変更しておく。

# インストール  {#ce2847ff}
まずはサーバのインストール。


```
# portinstall irc/irc

```

普通にインストールは終了する。

# 設定  {#d9105f63}

設定ファイルのコピー。


```
# cp /usr/local/etc/ircd/ircd.motd /usr/local/etc/ircd/ircd.motd.example
# chmod 644 /usr/local/etc/ircd/ircd.motd
# cp /usr/local/etc/ircd/ircd.conf.example /usr/local/etc/ircd/ircd.conf
# chmod 644 /usr/local/etc/ircd/ircd.conf

```

## ircd.conf  {#t87105b6}
ここでは必要最低限の設定しか書いていません。

各項目の意味を知りたい場合はインストール時に付属しているサンプル設定ファイルを参照すること。


```
# vi /usr/local/etc/ircd/ircd.conf

```

192.168.0.0/16 と *.jp 以外は接続出来ないので注意。


```
# M:<Server NAME>:<YOUR Internet IP#>:<Geographic Location>:<Port>:<SID>:
M:irc.clx.ath.cx::Japan:6667:392C:

# A:<Your Name/Location>:<Your E-Mail Addr>:<other info>::<network name>:
A:Cocelo Style:IRC <irc@clx.ath.cx>:Cocelo Style IRC Server::CSnet:

# P:<YOUR Internet IP#>:<*>::<Port>:<Flags>
P::::6667::

# For SERVER CLASSES, the fields are:
# Y:<Class>:<Ping Frequencys>:<Connect freq>:<Max Links>:<SendQ>::
Y:2:90:300:0:20000000::

# For CLIENT CLASSES, the fields are:
# Y:<Class>:<Ping Frequency>::<Max Links>:<SendQ>:<Local Limit>:<Global Limit>:
Y:12:90::100:512000:::
Y:13:90::100:512000:2.1:32.1:

# I:<TARGET Host Addr>:<Password>:<TARGET Hosts NAME>:<Port>:<Class>:<Flags>:
I:*@192.168.0.0/16::::12::
I:::*@*.jp::13::

```

サーバオペーレーターやローカルオペレーターが欲しいという場合は **O,o** を設定する。

## ircd.motd  {#kcc0e476}
告知や利用規約みたいのを書いておくらしい。


```
# vi /usr/local/etc/ircd/ircd.motd

Welcome to Cocelo Style !!!

```

# 起動  {#yd4f88b3}
ircd.sh を見てみたらあまりにも酷くてふいた。

セキュリティが気になる方は自分で書いた方がいいかも。


```
# /usr/local/etc/rc.d/ircd.sh start

```

# リンク  {#qeda30d9}

- [IRC users in Japan Web Site](http://www.ircnet.jp/ "IRC users in Japan Web Site")
- [IRCd \(Server Software\)](http://www.xseed.jp/irc/ircd/ "IRCd \(Server Software\)")
- [ircd.conf読解講座](http://www.tokio.ne.jp/~rankuma/ircdconf.html "ircd.conf読解講座")
