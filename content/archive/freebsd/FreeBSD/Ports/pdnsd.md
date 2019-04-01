+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/pdnsd"
date = "2008-10-17T23:19:03Z"
+++

# pdnsd で DNS キャッシュサーバの構築  {#mf058a98}
BIND は度々セキュリティーホールが見つかる ( ユーザ数が多いのである意味必然かもしれませんが ) し、 djbdns は設定に難があるし･･･と DNS ( キャッシュ ) サーバの導入に躊躇していた方はこの pdnsd で解決できるかもしれません。
また、本記事は jail 環境下での構築例になります。

# pdnsd のインストール  {#t8cb03c4}
ports からインストールします。


```
# cd /usr/ports/dns/pdnsd/
# make -DBATCH WITHOUT_IPV6=yes install clean
# chmod 644 /usr/local/etc/pdnsd.conf

```

# 基本的な設定  {#tcfd00ec}


```
# vi /usr/local/etc/pdnsd.conf

```


```
global {
        perm_cache=2048;
        cache_dir="/var/db/pdnsd";
#       pid_file = /var/run/pdnsd.pid;
        run_as="nobody";
        server_ip = jailのIP;   # Use eth0 here if you want to allow other
                                # machines on your network to query pdnsd.
        status_ctl = on;
#       paranoid=on;       # This option reduces the chance of cache poisoning
                           # but may make pdnsd less efficient, unfortunately.
        query_method=udp_tcp;
        min_ttl=15m;       # Retain cached entries at least 15 minutes.
        max_ttl=1w;        # One week.
        timeout=10;        # Global timeout option (10 seconds).
}
```

# 自動起動の設定  {#ucb96731}


```
# printf "\n# pdnsd\npdnsd_enable=yes\n" >> /etc/rc.conf

```

# 起動  {#k1fcc9f1}


```
# /usr/local/etc/rc.d/pdnsd start
```

