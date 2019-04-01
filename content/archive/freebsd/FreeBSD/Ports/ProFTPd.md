+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/ProFTPd"
date = "2009-10-16T20:50:40Z"
+++


# ProFTPd で FTP サーバの構築  {#o28ba9b5}
サイトを運営していると FTP を使ってファイルのアップロードを行いたい場合があると思います。
出先で SSH が使えれば SSH over FTP を使えば良いのですが、必ずしも使える環境ではないと思います。
そういった時の為に FTP サーバを用意しておいて、必要に応じて使い分けましょう。

# インストール  {#qedc9950}
まずは ProFTPd のインストールです。


```
# make WITH_LDAP=yes WITH_LDAP_TLS=yes WITH_MYSQL=yes \
? WITH_OPENSSL=yes WITH_QUOTA=yes WITH_CTRLS=yes \
? WITH_WRAP_SQL=yes WITHOUT_RADIUS=yes WITH_BAN=yes \
? WITH_NLS=yes WITH_DIGEST=yes WITHOUT_RADIUS=yes \
? install clean

```

# 設定ファイルの編集  {#a1aef9f3}
設定ファイルを編集します。
各項目の意味等はマニュアルなどをご参照ください。


```
% sudo vi /usr/local/etc/proftpd.conf

```


```
ServerIdent		off
ServerName		"FTP Server"
ServerType		standalone
DefaultServer		on
ScoreboardFile		/var/run/proftpd/proftpd.scoreboard
Port			21
#MasqueradeAddress	ftp.example.com
PassivePorts		9010 9039
Umask			022
MaxInstances		30
CommandBufferSize	512
User			nobody
Group			nogroup
RootLogin		off
RequireValidShell	off
DefaultRoot		~ !wheel
AllowOverwrite		on
AllowRetrieveRestart	on
DeleteAbortedStores	on
ListOptions		"-la"
UseReverseDNS		off
IdentLookups		off
TimesGMT		off
TimeoutIdle		600
TimeoutLogin		300
TimeoutNoTransfer	600
TimeoutSession		none
TimeoutStalled		600

#TransferRate		RETR 10.0:1048576 group !wheel

MaxClientsPerHost	1
MaxHostsPerUser	1

<Limit SITE_CHMOD>
   DenyAll
</Limit>

LogFormat allinfo "%t :  %u (%a [%h]) : [%s], %T, %m (%f)"
LogFormat write "%t : %u : %F (%a)"
LogFormat read "%t : %u : %F (%a)"
LogFormat auth "%t : %u (%a [%h])"
ExtendedLog /var/log/proftpd/all.log ALL allinfo
ExtendedLog /var/log/proftpd/write.log WRITE write
ExtendedLog /var/log/proftpd/read.log  READ read
ExtendedLog /var/log/proftpd/auth.log AUTH auth
```

# 設定ファイルのチェック  {#yb6dc910}
設定ファイルに不備がないか、チェックします。


```
% sudo proftpd -t -c /usr/local/etc/proftpd.conf

```

# ログディレクトリの作成  {#w97ca537}
ログ格納ディレクトリを作成します。


```
% sudo mkdir /var/log/proftpd

```

# ログローテーション  {#hc693b9e}
ログローテーションの設定を行います。


```
% sudo sh -c 'printf "/var/log/proftpd/all.log\t\t644  7\t   *\t@T00  J     /var/run/proftpd.pid\n" >> /etc/newsyslog.conf'
% sudo sh -c 'printf "/var/log/proftpd/auth.log\t\t644  7\t   *\t@T00  J     /var/run/proftpd.pid\n" >> /etc/newsyslog.conf'
% sudo sh -c 'printf "/var/log/proftpd/read.log\t\t644  7\t   *\t@T00  J     /var/run/proftpd.pid\n" >> /etc/newsyslog.conf'
% sudo sh -c 'printf "/var/log/proftpd/write.log\t\t644  7\t   *\t@T00  J     /var/run/proftpd.pid\n" >> /etc/newsyslog.conf'

```

# 自動起動の設定  {#if1832dc}
FreeBSD 起動時に自動的に立ち上がるように設定します。


```
% sudo sh -c "printf '\n# ProFTPd\nproftpd_enable="YES"\n' >> /etc/rc.conf"

```

# 起動  {#i243ce75}
ProFTPd を起動します。


```
% sudo /usr/local/etc/rc.d/proftpd start

```

# リンク  {#xc62b4e4}
- [The ProFTPD Project](http://www.proftpd.org/ "The ProFTPD Project")
- [FTPサーバ\(ProFTPD\)の構築](http://www.aconus.com/~oyaji/ftp/proftpd_rpm.htm "FTPサーバ\(ProFTPD\)の構築")
- [セキュアFTPサーバの構築\(ProFTPD+SSL/TLS\)](http://www.aconus.com/~oyaji/ftp/proftpd_ssl_rpm.htm "セキュアFTPサーバの構築\(ProFTPD+SSL/TLS\)")
- [バーチャルFTPサーバの構築](http://www.aconus.com/~oyaji/ftp/proftpd_virtual.htm "バーチャルFTPサーバの構築")
