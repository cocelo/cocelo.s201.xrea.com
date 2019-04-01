+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Unbound"
date = "2009-11-03T15:00:50Z"
+++


# インストール  {#r4ef9e4a}

```
# cd /usr/ports/dns/unbound
# make install clean
```

# 設定  {#h9f10df2}

```
# vi /usr/local/etc/unbound/unbound.conf
```


```
server:
	verbosity: 1
	hide-identity: yes
	hide-version: yes
	interface: 192.168.1.201
	do-ip6: no
	access-control: 127.0.0.0/8 allow
	access-control: 192.168.1.0/24 allow
	local-zone: "1.168.192.in-addr.arpa." transparent
stub-zone:
	name: "example.com."
	stub-addr: 192.168.1.200
stub-zone:
	name: "1.168.192.in-addr.arpa."
	stub-addr: 192.168.1.200
```


```
# unbound-checkconf /usr/local/etc/unbound/unbound.conf
unbound-checkconf: no errors in /usr/local/etc/unbound/unbound.conf
```


```
# printf '\n# unbound\nunbound_enable="YES"\n' >> /etc/rc.conf
```

# 起動  {#b3b3d7f3}

```
# /usr/local/etc/rc.d/unbound start
```
