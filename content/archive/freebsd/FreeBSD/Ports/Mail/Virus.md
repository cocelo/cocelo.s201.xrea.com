+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail/Virus"
date = "2008-10-16T04:12:09Z"
+++


# アンチウイルスソフトの導入  {#ie79b228}
Clam AV を使用した、アンチウイルスソフトの導入を行います。

# インストール  {#h09415c2}
ウィルス定義ファイルを自動更新する freshclam も同時にインストールされます。


```
% sudo portinstall security/clamav

```

# ファイルを編集出来るようにする  {#y666c7c1}
権限が足りなくて編集出来ないので、下記のようにして編集出来るようにする。


```
% sudo chmod 644 /usr/local/etc/clamd.conf

```

# ログの出力に日時を追加する  {#wb023600}
標準ではログに日時が出力されないので、日時を出力するように設定を行う。


```
% sudo vi /usr/local/etc/clamd.conf

# Log time with each message.
# Default: no
LogTime yes

```

# Clam AV と freshclam の自動起動の設定  {#o39628cf}
Clam AV と freshclam の自動起動の設定を行います。


```
% sudo vi /etc/rc.conf

```

# Clam AV と freshclam を起動する  {#t2f5d0f8}
Clam AV と freshclam を起動します。


```
% sudo /usr/local/etc/rc.d/clamav-clamd start
% sudo /usr/local/etc/rc.d/clamav-freshclam start

```

# amavisd-new のインストール  {#s99fe2f0}


```
% sudo portinstall security/amavisd-new

```

# ファイルを編集出来るようにする  {#id046d15}


```
% sudo chmod 644 /usr/local/etc/amavisd.conf

```

# amavisd.conf を編集する  {#v2707d97}


```
% sudo vi /usr/local/etc/amavisd.conf

```

ドメイン名

```
# $mydomain = 'example.com';   # a convenient default for other settings
$mydomain = 'clx.ath.cx';   # a convenient default for other settings

```

ホスト名

```
# $myhostname = 'host.example.com';  # must be a fully-qualified domain name!
$myhostname = 's1.clx.ath.cx';  # must be a fully-qualified domain name!

```

通知先

```
# $virus_admin               = "virusalert\@$mydomain";  # notifications recip.
$virus_admin               = 'root@$mydomain';  # notifications recip.

```

spam 検出時の通知先

```
$spam_admin   = 'root@$mydomain';
```

文字コード

```
$hdr_encoding = 'iso-2022-jp';
$bdy_encoding = 'iso-2022-jp';

```

[こちら](http://www.crimson-snow.net/hmsvr/bsd/maild/clamav.html "こちら")をご参照ください。

```
$notify_method  = 'smtp:[127.0.0.1]:10025';
$forward_method = 'smtp:[127.0.0.1]:10025';  # set to undef with milter!

$final_virus_destiny      = D_DISCARD;
$final_banned_destiny     = D_BOUNCE;
$final_spam_destiny       = D_BOUNCE;
$final_bad_header_destiny = D_PASS;

$warnvirussender  = 0;
$warnspamsender   = 0;
$warnbannedsender = 0;
$warnbadhsender   = 0;

```

# Clam AV と実行ユーザーを合わせる  {#g20b4d5b}


```
% sudo vi /usr/local/etc/clamd.conf

User vscan

% sudo chown -R vscan:vscan /var/run/clamav

```

# amavisd-net の自動起動  {#t0909b42}


```
% sudo vi /etc/rc.conf

amavisd_enable="YES"

```

# amavisd-net の起動  {#z522e2c6}


```
% sudo /usr/local/etc/rc.d/amavisd start

```

# Postfix の設定  {#b2239511}


```
% sudo vi /usr/local/etc/postfix/main.cf

content_filter = smtp-amavis:[127.0.0.1]:10024

% sudo vi /usr/local/etc/postfix/master.cf

smtp-amavis unix - - n - 2 smtp
	-o smtp_data_done_timeout=1200
	-o disable_dns_lookups=yes

127.0.0.1:10025 inet n - n - - smtpd
	-o content_filter=
	-o local_recipient_maps=
	-o relay_recipient_maps=
	-o smtpd_restriction_classes=
	-o smtpd_client_restrictions=
	-o smtpd_helo_restrictions=
	-o smtpd_sender_restrictions=
	-o smtpd_recipient_restrictions=permit_mynetworks,reject
	-o mynetworks=127.0.0.0/8
	-o strict_rfc821_envelopes=yes

```

# Postfix のリロード  {#h9200113}


```
% sudo /usr/local/sbin/postfix reload
```

