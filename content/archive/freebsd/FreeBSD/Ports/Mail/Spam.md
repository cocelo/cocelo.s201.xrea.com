+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail/Spam"
date = "2008-10-16T04:12:09Z"
+++


# スパム対策  {#h9b20102}
スパム対策に taRgrey を導入します。
taRgrey は S25R + tarpitting + greylisting の三種類のスパム判定方法を組み合わせたフィルタリング方法です。
一次フィルタに taRgrey 、二次フィルタに Procmail + SpamAssassin を採用すればかなりのスパムメールを弾けることになります。

# taRgrey について  {#jd7fd8cc}
tarRgrey を使用するに当たって、下記のサイトには目を通しておいてください。

[taRgrey - S25R + tarpitting + greylisting \(tarpit + greylist policy server\)](http://k2net.hakuba.jp/targrey/ "taRgrey - S25R + tarpitting + greylisting \(tarpit + greylist policy server\)")
[Rgrey - S25R + greylisting](http://k2net.hakuba.jp/rgrey/ "Rgrey - S25R + greylisting")
[Starpitでほぼ誤検出無く98%のスパムを排除 \(S25R+tarpittingによるスパム対策\) - モーグルとカバとパウダーの日記](http://d.hatena.ne.jp/stealthinu/20060706/p5 "Starpitでほぼ誤検出無く98%のスパムを排除 \(S25R+tarpittingによるスパム対策\) - モーグルとカバとパウダーの日記")
[阻止率99%のスパム対策方式の研究報告　――　Selective SMTP Rejection \(S25R\)方式　――](http://www.gabacho-net.jp/anti-spam/paper.html "阻止率99%のスパム対策方式の研究報告　――　Selective SMTP Rejection \(S25R\)方式　――")

# パッチについて  {#qf49f6a8}
taRgrey を使うには Postfix ( 必須ではありません ) と postgrey にパッチを当てる必要があります。
portupgrade をインストールしていればこのパッチを ports に適用することが出来ます。
今回は Postfix にはパッチを当てず、 postgrey にだけ、パッチを当てる事とします。

# パッチのダウンロード  {#sa4d851c}
ports にパッチを当てる為、パッチを[こちら](http://k2net.hakuba.jp/targrey/ "こちら")からダウンロードします。
保存場所は /root/patch 以下とし、パッチの更新等もここで行います。


```
% sudo mkdir /root/patch
% cd /root/patch
% sudo fetch http://k2net.hakuba.jp/pub/targrey-0.31-postgrey-1.32.patch

```

# postgrey インストール  {#g77171ab}
まずは postgrey のインストールからです。


```
% sudo portinstall mail/postgrey

```

パッチが当てられれば下記のように表示されます。


```
--->  Executing a pre-build command for 'mail/postgrey': cp /root/patch/targrey-0.31-postgrey-1.32.patch /usr/ports/mail/postgrey/files/patch-targrey

```

# Whitelist の取得  {#ge1585b6}
taRgrey の設定を行う前に、まずはホワイトリストの取得から行います。
[ホワイトリスト情報](http://www.gabacho-net.jp/anti-spam/white-list.html "ホワイトリスト情報")


```
% cd /usr/local/etc/postfix
% sudo fetch http://www.gabacho-net.jp/anti-spam/white-list.txt

```

# permit_client_nots25r の作成  {#kb256da5}
taRgrey の設定を行う前に、 permit_client_nots25r を作成します。
なお、これはホームページに掲載されている内容とまったく一緒のものです。


```
% sudo vi /usr/local/etc/postfix/permit_client_nots25r

/\.dip\.t-dialin\.net$/       WARN
/\.dyn\.optonline\.net$/      WARN
...(other dynamic IP FQDN pattern(not match S25R pattern))
!/(^unknown$)|(^[^\.]*[0-9][^0-9\.]+[0-9])|(^[^\.]*[0-9]{5})|(^([^\.]+\.)?[0-9][^\.]*\.[^\.]+\..+\.[a-z])|(^[^\.]*[0-9]\.[^\.]*[0-9]-[0-9])|(^[^\.]*[0-9]\.[^\.]*[0-9]\.[^\.]+\..+\.)|(^(dhcp|dialup|ppp|adsl)[^\.]*[0-9])/ OK
/./                           WARN

```

# taRgrey の設定  {#gfc59164}
次にtaRgrey の設定です。
今回はお試し導入 (?) ということで、フィルタリングルールも、ホームページで提唱されているものだけにしました。


```
% sudo vi /usr/local/etc/postfix/main.cf

#
# taRgrey - S25R + tarpitting + greylisting
#
smtpd_recipient_restrictions =
	permit_mynetworks
	permit_sasl_authenticated
	reject_unauth_destination
	check_client_access     regexp:$config_directory/white-list.txt
	check_client_access     regexp:$config_directory/permit_client_nots25r
	check_policy_service    inet:60000
	permit

smtpd_data_restrictions =
	permit_mynetworks
	permit_sasl_authenticated
	check_client_access     regexp:$config_directory/white-list.txt
	check_client_access     regexp:$config_directory/permit_client_nots25r
	check_policy_service    inet:60000
	permit

```

smtpd_recipient_restrictions は SASL を有効にした時に既に記述したと思うので、そちらは削除してください。

# postgrey の自動起動  {#ec96fda5}
postgrey の設定は、自動起動時のフラグの変更を行います。


```
% sudo vi /etc/rc.conf

postgrey_enable="YES"
postgrey_flags="--pidfile=/var/run/postgrey.pid --dbdir=/var/db/postgrey --user=postgrey --group=postgrey --daemonize --inet=127.0.0.1:60000 --tarpit=125 --targrey --retry-count=2 --delay=3600"

```

# postgrey の起動  {#z0f7b200}
まずは postgrey を起動します。


```
% sudo /usr/local/etc/rc.d/postgrey start

```

動作確認の為、 ps で確認します。


```
27499  ??  Is     0:00.01 /usr/local/sbin/postgrey --pidfile=/var/run/postgrey.pid --dbdir=/var/db/postgrey --user=postgrey --group=postgrey --daemonize --inet=127.0.0.1:60000 --tarpit=125 --targrey --retry-count=2 --delay=3600 (perl5.8.8)
27507  p0  R+     0:00.00 grep postgrey

```

# Postfix の再起動  {#w972f80e}
全て問題がなければ Postfix を再起動します。


```
% sudo /usr/local/etc/rc.d/postfix restart
```

