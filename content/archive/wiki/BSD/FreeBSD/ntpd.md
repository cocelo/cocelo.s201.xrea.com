+++
title = "[PukiWiki:wiki] BSD/FreeBSD/ntpd"
date = "2008-12-10T09:33:20Z"
+++


# はじめに  {#yf883f35}
通常、サーバは放置していると時間が徐々に狂ってきてしまいます。

時間が狂うと様々な弊害が起きるので、なるべくこの作業は行いましょう。

# NTP サーバの選択  {#hd6b4629}
まずはどこのサーバと時刻を同期するのか決めます。

問い合わせ NTP サーバの優先順位としては、下記の一覧のような優先順位とします。

- プロバイダの NTP サーバ
- [インターネットマルチフィード株式会社 \( mfeed \)](http://www.jst.mfeed.ad.jp/ "インターネットマルチフィード株式会社 \( mfeed \)")
- プライベートネットワーク内の NTP サーバ

利用しているプロバイダが NTP サーバを提供しているかどうかは下記のリンクをご覧下さい。

- [プロバイダ別 NTPサーバリスト \(公式アナウンスあり\) - wiki@nothing](http://wiki.nothing.sh/page/NTP/%A5%D7%A5%ED%A5%D0%A5%A4%A5%C0%A1%A6%B5%A1%B4%D8%CA%CC#f083ff73 "プロバイダ別 NTPサーバリスト \(公式アナウンスあり\) - wiki@nothing")
- [プロバイダ別 NTPサーバリスト \(公式アナウンスなし\) - wiki@nothing](http://wiki.nothing.sh/page/NTP/%A5%D7%A5%ED%A5%D0%A5%A4%A5%C0%A1%A6%B5%A1%B4%D8%CA%CC#h026287f "プロバイダ別 NTPサーバリスト \(公式アナウンスなし\) - wiki@nothing")

プロバイダが NTP サーバを提供していない場合は [mfeed](http://www.jst.mfeed.ad.jp/ "mfeed") 、プライベートネットワーク内の NTP サーバを指定します。

残りの選択肢としては [NICT](http://www2.nict.go.jp/w/w114/stsi/PubNtp/ "NICT") も良いかと思います。

## 優先順位の考え方  {#r99255b4}
なぜ上記のような優先順位なのか。

少し突っ込んだ話をすると、 NTP サーバはなるべくネットワーク的に近いサーバを指定するのが一番良い選択だからです。

- プロバイダ提供の NTP サーバ
    -  ISP 内で完結する
- [mfeed](http://www.jst.mfeed.ad.jp/ "mfeed")
    -  多くのプロバイダと直接接続されている為、プロバイダ提供の NTP サーバと遜色ない
- プライベートネットワーク内の NTP サーバ
    -  クライアントが少ない場合はバックアップ目的として
    -  十台以上のクライアントがある場合は外部に問い合わせる負荷が問題になってくるのでネットワーク内で完結させる為

# 福岡大学の NTP サーバを指定されている方へ  {#s2be465c}
問い合わせ NTP サーバを選択する際には、福岡大学 ( clock.nc.fukuoka-u.ac.jp ) は指定しないようにしましょう。

多数のユーザからのアクセスがあり、過負荷に陥っている、との事です。

- [スラッシュドット・ジャパン | 福岡大学NTPサーバの混雑解消にご協力を](http://slashdot.jp/articles/05/01/21/0214236.shtml "スラッシュドット・ジャパン | 福岡大学NTPサーバの混雑解消にご協力を")

# NTP サーバの設定  {#k9d5973e}
問い合わせ NTP サーバを決定したら早速 NTP サーバの設定を行いましょう。

筆者の利用しているプロバイダが [ASAHIネット](http://asahi-net.jp/ "ASAHIネット") なので、プロバイダ提供の NTP サーバとして [ASAHIネットの NTP サーバ](https://asahi-net.jp/support/guide/0000.html "ASAHIネットの NTP サーバ") を指定しています。


```
# vi /etc/ntp.conf

restrict default ignore
restrict 127.0.0.1
restrict 192.168.1.0 mask 255.255.255.0 nomodify nopeer notrap

restrict 202.224.32.4   nomodify notrap noquery # ntp.asahi-net.or.jp
restrict 210.173.160.27 nomodify notrap noquery # ntp1.jst.mfeed.ad.jp
restrict 210.173.160.57 nomodify notrap noquery # ntp2.jst.mfeed.ad.jp
restrict 210.173.160.87 nomodify notrap noquery # ntp3.jst.mfeed.ad.jp

server -4 ntp.asahi-net.or.jp  minpoll 6 maxpoll 10 prefer
server -4 ntp1.jst.mfeed.ad.jp minpoll 8 maxpoll 15
server -4 ntp2.jst.mfeed.ad.jp minpoll 8 maxpoll 15
server -4 ntp3.jst.mfeed.ad.jp minpoll 8 maxpoll 15

logconfig -syncstatus
logfile   /var/log/ntpd.log
pidfile   /var/run/ntpd.pid
driftfile /var/db/ntpd.drift

```

# 自動起動を有効にする  {#a199f760}
上記項目の設定が終了したら、 ntpd が起動時に有効になる様に /etc/rc.conf に設定します。

また、起動時に時刻合わせもする様に設定します。


```
# vi /etc/rc.conf

ntpd_enable="YES"
ntpd_sync_on_start="YES"

```

# ntpd を立ち上げる  {#ofa5348f}
全ての作業が終わったら ntpd を立ち上げます。


```
# /etc/rc.d/ntpd start

```

# リンク  {#ve45b988}
- [ntpd\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=ntpd&dir=jpman-6.2.2%2Fman&sect=0 "ntpd\(8\)")
- [ntp.conf\(5\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=ntp.conf&dir=jpman-6.2.2%2Fman&sect=0 "ntp.conf\(5\)")
- [ntpq\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=ntpq&dir=jpman-6.2.2%2Fman&sect=0 "ntpq\(8\)")
- [インターネットマルチフィード株式会社 \( mfeed \)](http://www.jst.mfeed.ad.jp/ "インターネットマルチフィード株式会社 \( mfeed \)")
- [NICT](http://www2.nict.go.jp/w/w114/stsi/PubNtp/ "NICT")
- [NTP - wiki@nothing](http://wiki.nothing.sh/page/NTP "NTP - wiki@nothing")
