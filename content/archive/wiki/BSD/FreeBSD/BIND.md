+++
title = "[PukiWiki:wiki] BSD/FreeBSD/BIND"
date = "2008-12-10T09:33:18Z"
+++

# BIND Memo  {#q4c2a7a0}


## 不要ファイルの削除  {#t35c3ea7}

```
# cd /etc/namedb/
# rm -fr PROTO.localhost* make-localhost named.root rndc.key

```

## root DNS サーバリストの取得  {#hc759fe9}

```
# dig @A.ROOT-SERVERS.NET. > /etc/namedb/named.root

```

## rndc の設定  {#u07ff76c}

```
# rndc-confgen -a
# cat /etc/namedb/rndc.key > /etc/namedb/rndc.conf
# cat /etc/namedb/rndc.key > /etc/namedb/named.conf
# rm /etc/namedb/rndc.key
# vi /etc/namedb/rndc.conf

key "rndc-key" {
	algorithm hmac-md5;
	secret "md5";
};

options {
	default-key "rndc-key";
	default-server 127.0.0.1;
	default-port 953;
};

Server 127.0.0.1 {
	key "rndc-key";
};

# chmod 400 /etc/namedb/rndc.conf
# chmod 600 /etc/namedb/named.conf
# chown bind:wheel /etc/namedb/named.conf

```

## 内向き DNS  {#y54fbf77}

### named.conf  {#s4788ac1}

```
# vi /etc/namedb/named.conf

key "rndc-key" {
	algorithm hmac-md5;
	secret "md5";
};

acl localnet {
	127.0.0.1;
	192.168.1.0/24;
};

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

```

### 正引きのゾーン設定  {#p2515336}

```
# vi /etc/namedb/master/clx.ath.cx

$TTL	1D

@	IN	SOA	ns.clx.ath.cx.	root.ns.clx.ath.cx. (
	2007062701
	3H
	1H
	1W
	1D )

		IN	NS	ns.clx.ath.cx.

		IN	MX 10	smtp.clx.ath.cx.

@ 		IN	A	192.168.1.100
gw		IN	A	192.168.1.1
s1		IN	A	192.168.1.100

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

### 逆引きのゾーン設定  {#s38163b1}

```
# vi /etc/namedb/master/1.168.192.in-addr.arpa

$TTL	1D

@	IN	SOA	ns.clx.ath.cx.	root.ns.clx.ath.cx. (
	2007062701
	3H
	1H
	1W
	1D )

		IN	NS	ns.clx.ath.cx.

1		IN	PTR	gw.clx.ath.cx.
100		IN	PTR	s1.clx.ath.cx.

```

## Logging  {#qb24a934}

```
# vi /etc/namedb/named.conf

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

## 設定ファイルの確認  {#ub31c80a}

```
# named-checkconf /etc/namedb/named.conf
# named-checkzone clx.ath.cx /etc/namedb/master/clx.ath.cx
# named-checkzone 1.168.192.in-addr.arpa /etc/namedb/master/1.168.192.in-addr.arpa

```

問題が無かったら起動。


```
# vi /etc/rc.conf

named_enable="YES"

# /etc/rc.d/named start

```

## 動作確認  {#j93d99e6}
messages の確認。

```
# cat /var/log/messages | grep named
Jun 27 07:20:48 server named[69213]: starting BIND 9.3.3 -t /var/named -u bind
Jun 27 07:20:48 server named[69213]: command channel listening on 127.0.0.1#953
Jun 27 07:20:48 server named[69213]: running

```

LISTEN しているかどうか。

```
# netstat -a | grep .domain
tcp4       0      0  localhost.domain       *.*                    LISTEN
tcp4       0      0  s1.domain              *.*                    LISTEN
udp4       0      0  localhost.domain       *.*
udp4       0      0  s1.domain              *.*
# netstat -a | grep rndc
tcp4       0      0  s1.rndc                *.*                    LISTEN

```

dig で DNS を引けるかどうか。

```
# dig @127.0.0.1 -x 127.0.0.1
# dig @127.0.0.1 localhost
# dig @127.0.0.1 -x 192.168.1.100
# dig @127.0.0.1 s1.clx.ath.cx
# dig @127.0.0.1 yahoo.co.jp
# dig @127.0.0.1 google.co.jp

```

## 名前解決に BIND を使用する  {#t83a57be}


```
# vi /etc/resolv.conf

nameserver	127.0.0.1
```

