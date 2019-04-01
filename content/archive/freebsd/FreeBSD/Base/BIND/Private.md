+++
title = "[PukiWiki:freebsd] FreeBSD/Base/BIND/Private"
date = "2008-10-16T04:12:04Z"
+++


# 内向き DNS サーバの設定  {#y54fbf77}
ここでは内向き DNS サーバの設定を行います。
マスターサーバとスレーブサーバで設定内容が違うので、自宅のネットワーク環境を確認した上でご参照ください。

# マスターサーバの設定  {#s4788ac1}
DNS のゾーン情報は全てマスターサーバで設定します。

## named.conf の設定  {#daaeecf5}
まずは named.conf の設定から行います。
rndc 関連の設定は既に済ませてあるものとして進めます。


```
# vi /etc/namedb/named.conf

acl localnet {
	127.0.0.1;
	192.168.1.0/24;
};

include "/etc/namedb/rndc.key";

controls {
	inet 127.0.0.1 port 953 allow { 127.0.0.1; } keys { "rndc-key"; };
};

options {
	directory	"/etc/namedb";
	pid-file	"/var/run/named/pid";
	dump-file	"/var/dump/named_dump.db";
	statistics-file	"/var/stats/named.stats";

	listen-on	{
		127.0.0.1;
		192.168.1.100;
	};
	listen-on-v6	{ none; };

	allow-query	{ localnet; };
	allow-transfer	{ localnet; };
	allow-recursion	{ localnet; };

	forwarders {
		202.224.32.1;
		202.224.32.2;
	};

	version		"unknown";
};

zone "." {
	type hint;
	file "named.root";
};

zone "clx.ath.cx" {
	type master;
	file "master/clx.ath.cx";
};

zone "1.168.192.in-addr.arpa" {
	type master;
	file "master/1.168.192.in-addr.arpa";
};

logging {
	channel default_log {
		file "/var/log/named.log" versions 7 size 10m;
		severity info;
		print-time yes;
		print-category yes;
	};
	category default { default_log; };
};

```

## 正引きのゾーン設定  {#p2515336}
正引きのゾーン設定です。


```
# vi /etc/namedb/master/clx.ath.cx

$TTL	1D

@	IN	SOA	ns.clx.ath.cx.	root.ns.clx.ath.cx. (
	2007100101
	3H
	1H
	1W
	1D )

		IN	NS	ns.clx.ath.cx.

		IN	MX 10	smtp.clx.ath.cx.

@ 		IN	A	192.168.1.100
gw		IN	A	192.168.1.1
s1		IN	A	192.168.1.100
s2		IN	A	192.168.1.100

ns		IN	A	192.168.1.100
www		IN	A	192.168.1.100
smtp		IN	A	192.168.1.100
mail		IN	A	192.168.1.100
ftp		IN	A	192.168.1.100
ntp		IN	A	192.168.1.100
ldap		IN	A	192.168.1.100

svn		IN	A	192.168.1.100
cvs		IN	A	192.168.1.100

dev		IN	A	192.168.1.100
stat		IN	A	192.168.1.100

```

## 逆引きのゾーン設定  {#s38163b1}
逆引きのゾーン設定です。


```
# vi /etc/namedb/master/1.168.192.in-addr.arpa

$TTL	1D

@	IN	SOA	ns.clx.ath.cx.	root.ns.clx.ath.cx. (
	2007100101
	3H
	1H
	1W
	1D )

		IN	NS	ns.clx.ath.cx.

1		IN	PTR	gw.clx.ath.cx.
100		IN	PTR	s1.clx.ath.cx.
101		IN	PTR	s1.clx.ath.cx.

```

# スレーブサーバの設定  {#p3de32a8}
マスターサーバからゾーン転送により、マスターサーバの複製を行う手法でスレーブサーバを構築します。

## named.conf の設定  {#daaeecf5}
まずは named.conf の設定から行います。
rndc 関連の設定は既に済ませてあるものとして進めます。


```
# vi /etc/namedb/named.conf

acl localnet {
	127.0.0.1;
	192.168.1.0/24;
};

include "/etc/namedb/rndc.key";

controls {
	inet 127.0.0.1 port 953 allow { 127.0.0.1; } keys { "rndc-key"; };
};

options {
	directory	"/etc/namedb";
	pid-file	"/var/run/named/pid";
	dump-file	"/var/dump/named_dump.db";
	statistics-file	"/var/stats/named.stats";

	listen-on	{
		127.0.0.1;
		192.168.1.100;
	};
	listen-on-v6	{ none; };

	allow-query	{ localnet; };
	allow-transfer	{ localnet; };
	allow-recursion	{ localnet; };

	forwarders {
		202.224.32.1;
		202.224.32.2;
	};

	version		"unknown";
};

zone "." {
	type hint;
	file "named.root";
};

zone "clx.ath.cx" {
	type slave;
	masters {
		192.168.1.100;
	};
	file "slave/clx.ath.cx";
};

zone "1.168.192.in-addr.arpa" {
	type slave;
	masters {
		192.168.1.100;
	};
	file "slave/clx.ath.cx";
};

logging {
	channel default_log {
		file "/var/log/named.log" versions 7 size 10m;
		severity info;
		print-time yes;
		print-category yes;
	};
	category default { default_log; };
};

```

# 設定ファイルの確認  {#ub31c80a}
設定ファイルに記述ミスがないかどうかチェックします。


```
# named-checkconf /etc/namedb/named.conf
# named-checkzone clx.ath.cx /etc/namedb/master/clx.ath.cx
zone clx.ath.cx/IN: loaded serial 2007101001
OK
# named-checkzone 1.168.192.in-addr.arpa /etc/namedb/master/1.168.192.in-addr.arpa
zone 1.168.192.in-addr.arpa/IN: loaded serial 2007100101
OK

```

# 再起動  {#h270df97}
問題がなければ再起動します。


```
# /etc/rc.d/named restart

```

# 動作確認  {#j93d99e6}
ちゃんと起動しているか、動作確認をします。


```
# cat /var/log/messages | grep named
Jun 27 07:20:48 server named[69213]: starting BIND 9.3.3 -t /var/named -u bind
Jun 27 07:20:48 server named[69213]: command channel listening on 127.0.0.1#953
Jun 27 07:20:48 server named[69213]: running

```

LISTEN しているかどうか確認します。


```
# netstat -a | grep .domain
tcp4       0      0  localhost.domain       *.*                    LISTEN
tcp4       0      0  s1.domain              *.*                    LISTEN
udp4       0      0  localhost.domain       *.*
udp4       0      0  s1.domain              *.*
# netstat -a | grep rndc
tcp4       0      0  s1.rndc                *.*                    LISTEN

```

dig で DNS を引けるかどうか確認します。


```
# dig @127.0.0.1 -x 127.0.0.1
# dig @127.0.0.1 localhost
# dig @127.0.0.1 -x 192.168.1.100
# dig @127.0.0.1 s1.clx.ath.cx
# dig @127.0.0.1 yahoo.co.jp
# dig @127.0.0.1 google.co.jp

```

# 名前解決に BIND を使用する  {#t83a57be}
全て問題なければ名前解決でBIND を使うように resolv.conf を書き換えます。


```
# vi /etc/resolv.conf

nameserver	127.0.0.1
```

