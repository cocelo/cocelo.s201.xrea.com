+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/System/syslog-ng2"
date = "2008-10-23T22:07:13Z"
+++


# syslogd を syslog-ng に置き換える  {#ldddeeca}
日々ログファイルを追っているとその不便さに段々と嫌気が差してくると思います。
例えばログファイルからある特定の条件下で root 宛てにメール送信、なんてことも swatch などのツールを導入しなければいけません。
今回はそういった不満を解消してくれる syslog-ng というソフトウェアをご紹介します。

# インストール  {#gf536108}

```
% sudo portinstall sysutils/syslog-ng2

```


```
1. Create a configuration file named /usr/local/etc/syslog-ng.conf
   (a sample named syslog-ng.conf.sample has been included in
   /usr/local/etc/syslog-ng). Note that this is a change in 2.0.2
   version, previous ones put the config file in
   /usr/local/etc/syslog-ng/syslog-ng.conf, so if this is an update
   move that file in the right place

2. Configure syslog-ng to start automatically by adding the following
   to /etc/rc.conf:

        syslog_ng_enable="YES"

3. Prevent the standard FreeBSD syslogd from starting automatically by
   adding a line to the end of your /etc/rc.conf file that reads:

        syslogd_enable="NO"

4. Shut down the standard FreeBSD syslogd:

     kill `cat /var/run/syslog.pid`

5. Start syslog-ng:

     /usr/local/etc/rc.d/syslog-ng start
```

# 自動起動の設定と syslogd の無効化  {#e888fd1d}

```
% sudo vi /etc/rc.conf

```


```
# syslog-ng
syslogd_enable="NO"
syslog_ng_enable="YES"
```


```
% sudo sh -c 'kill `cat /var/run/syslog.pid`'

```

# 設定ファイルのコピー  {#pf54b62c}

```
% sudo cp /usr/local/etc/syslog-ng/syslog-ng.conf.sample /usr/local/etc/syslog-ng.conf

```

# syslog-ng の起動  {#k2bd8867}

```
% sudo /usr/local/etc/rc.d/syslog-ng start

```

# リンク  {#c8d27ba0}
[FreeBSD/syslog-ng - PukiWiki Plus!](http://matsui.homeunix.com/index.php?FreeBSD%2Fsyslog-ng "FreeBSD/syslog-ng - PukiWiki Plus!")
