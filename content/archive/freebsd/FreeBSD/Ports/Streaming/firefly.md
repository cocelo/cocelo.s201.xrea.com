+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Streaming/firefly"
date = "2008-12-05T19:13:38Z"
+++


# インストール  {#c177e66b}


```
$ sudo portinstall audio/firefly
$ sudo cp /usr/local/etc/mt-daapd.conf.sample /usr/local/etc/mt-daapd.conf
$ sudo chown daapd:daapd /usr/local/etc/mt-daapd.conf
$ sudo chmod 644 /usr/local/etc/mt-daapd.conf
$ sudo printf "\n# firefly\nfirefly_enable=\"YES\"" >> /etc/rc.conf
$ sudo mkdir -p /usr/local/var/db/firefly
$ sudo chown daapd:daapd /usr/local/var/db/firefly
$ sudo printf "/var/log/mt-daapd.log\t\t\t644  7\t   *\t@T00  J     /var/run/mt-daapd.pid\n" >> /etc/newsyslog.conf
```

# 設定  {#b6630527}


```
$ sudoedit /usr/local/etc/mt-daapd.conf
```


```
admin_pw = password ( 管理者パスワードの設定 )

mp3_dir = /mnt/mp3  ( mp3ファイルが置いてあるディレクトリを指定 )
```

# 起動  {#d57920b2}


```
$ sudo /usr/local/etc/rc.d/mt-daapd start
```

# mp3の曲情報が文字化けする時  {#r8374e1a}
iTunesでファイルを取り込み、IDタグをv2.4に変換すれば文字化けが解消される。
