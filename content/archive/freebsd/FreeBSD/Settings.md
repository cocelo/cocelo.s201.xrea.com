+++
title = "[PukiWiki:freebsd] FreeBSD/Settings"
date = "2008-10-16T04:12:13Z"
+++


# はじめに  {#t8206d0f}
インストール直後の状態は決して使い易いとは言えないので、細かなセッティングを行います。

# shell の設定  {#a0eb3306}
デフォルトの状態では tcsh を使うのが慣例となっているので、 tcsh を少し使いやすくします。

## user の tcsh  {#g468af9c}

```
> vi ~/.cshrc

setenv	LESSHISTFILE	-

set prompt = "[%n@%m]%B%~%b%# "
set autolist

> source ~/.cshrc

```

## root の tcsh  {#eefd5358}

```
# vi /root/.cshrc

setenv	LESSHISTFILE	-

#set prompt = "`/bin/hostname -s`# "
set prompt = "[%Broot@%m%b]%B%~%b%# "
set autolist

# source /root/.cshrc

```

## 新しいユーザを作る際に使われる tcsh  {#j5cb412b}

```
# vi /usr/share/skel/dot.cshrc

setenv	LESSHISTFILE	-

set prompt = "[%n@%m]%B%~%b%# "
set autolist

```

# キーボードの設定  {#u89f9b8b}
変更しなくても問題はありませんが、使い勝手向上の意味合いで設定します。


```
# vi /etc/rc.conf

keymap="jp.106"
keyrate="fast"
keybell="off"

```

# 起動時の待ち時間を短くする  {#ue71a7c1}
デフォルトの起動時間は少し長すぎるので 3 秒に変更する。


```
# vi /boot/loader.conf

autoboot_delay="3"

```

# ログイン時のメッセージを短くする  {#zd699af1}
コンソールや SSH 接続時に表示されるメッセージを短くする


```
# vi /etc/motd

Welcome to FreeBSD!

```

# root のメールをユーザーに転送する  {#bdac048d}
基本的に作業するのはユーザーなので、 root のメールを転送するようにすれば管理しやすい。


```
# vi /etc/mail/aliases

root: user

# newaliases

```

# make.conf を設定する  {#ia9dab7c}
make.conf を設定しておくと利便性があがる。
主にコンパイル時に利用される。
CPUTYPE については [GCC Manual](http://gcc.gnu.org/onlinedocs/gcc-3.4.6/gcc/i386-and-x86_002d64-Options.html#i386-and-x86_002d64-Options "GCC Manual") を参照すること。


```
# vi /etc/make.conf

CPUTYPE?=athlon64

NO_GAMES=	true
NO_INET6=	true
NO_PROFILE=	true

DOC_LANG=	en_US.ISO8859-1 ja_JP.eucJP

WITHOUT_X11=	yes
WITHOUT_IPV6=	yes
WITH_BDB_VER=	42

```

# MTU を調整する  {#wdf4fde3}
通常でしたら MTU を調整する必要はないのですが、これを調整することによって若干パフォーマンスが向上する場合があります。
- [NTT 東日本の B フレッツハイパーファミリーの MTU の推薦値](http://flets.com/customer/tec/opt/faq/faq_03.html#q7 "NTT 東日本の B フレッツハイパーファミリーの MTU の推薦値")は 1454 です。

下記の例では MTU 1448 に設定しています。


```
# vi /etc/rc.conf

ifconfig_bge0="inet 192.168.1.100 netmask 255.255.255.0 mtu 1448"

```

コマンドラインでは下記のように入力します。


```
# ifconfig bge0 mtu 1448

```

# fsck の対話的質問に全て yes で答える  {#p818a8ab}
遠隔操作で FreeBSD を運営している場合は fsck が自動実行された時の対話的質問に答える事が出来ません。
よって、この機能はあまり意味がないと思いますので fsck が自動実行された時、全て yes で答えるようにします。


```
# vi /etc/rc.conf

fsck_y_enable="YES"

```

# 全てのログを取る  {#l219e0ec}
サーバを運営していると様々な問題に遭遇します。
そう言った時の為に、ログを一箇所に集めておいたほうが良い場合もあります。


```
# touch /var/log/all.log
# chmod 600 /var/log/all.log
# vi /etc/syslog.conf

#*.*						/var/log/all.log
*.*						/var/log/all.log

```

# root のディレクトリを一般ユーザに見せない  {#w96c3c43}
root ディレクトリには管理の利便を確保する為、シェルスクリプトを置いている場合があると思います。
そういった場合に、一般ユーザが root ディレクトリを覗けてしまうのは好ましくありません。


```
# chmod 0750 /root

```

# [syslogd\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=syslogd&dir=jpman-6.2.2%2Fman&sect=0 "syslogd\(8\)") のネットワークソケットを閉じる  {#id60c789}
[syslogd\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=syslogd&dir=jpman-6.2.2%2Fman&sect=0 "syslogd\(8\)") はネットワーク上の syslogd とやり取りが出来るが、自宅のサーバ構成ではあまり意味を成さないので、ソケット自体を閉じてしまう。


```
# vi /etc/rc.conf

syslogd_flags="-ss"

```

# SYN+FIN パケットの破棄  {#e283acbc}
SYN+FIN パケットは TCP コネクション上の意味で言うと接続 + 切断になります。
通常の TCP コネクションでこのパケットが来た場合は高い確立で悪意のあるユーザによるものです。
また、このパケットを受信するようにしてしまうと DOS 攻撃の要因となってしまいます。

注意事項として、このオプションはカーネルに TCP_DROP_SYNFIN オプションを付けて再構築しないといけません。
カーネル再構築については [こちら](/archive/freebsd/FreeBSD/Base/Kernel/ "こちら") をご覧ください。


```
# vi /etc/rc.conf

tcp_drop_synfin="YES"

```

# ポートスキャン対策  {#l2fd4bc8}
ポートスキャンが行われる時、デフォルトの状態の FreeBSD では閉じているポートも応答を返してしまいます。
悪意あるユーザにこちら側の情報を教えてしまっているようなものなので、この応答を返さないようにします。


```
# vi /etc/sysctl.conf

net.inet.tcp.blackhole=2
net.inet.udp.blackhole=1

```

# カーネルの RST 応答を制限する  {#h21fc15c}
詳細は [こちら](http://www.freebsd.org/doc/ja_JP.eucJP/books/faq/networking.html#ICMP-RESPONSE-BW-LIMIT "こちら") をご覧ください。
噛み砕いて説明すると、ポートスキャン ( または DOS 攻撃 ) が行われた時に、閾値を超えている場合はカーネルが警告メッセージを出力します。
この閾値を調整する事で、アタックされているのかどうかある程度判断出来ます。


```
# vi /etc/sysctl.conf

net.inet.icmp.icmplim=400

```

# ICMP REDIRECT パケットの破棄  {#f4a51bbc}
ICMP REDIRECT パケットは一般的には経路情報を伝えるものですが、通常このパケットが外から飛んでくる事はありません。
よって ICMP REDIRECT パケットは破棄する設定にした方が良いでしょう。


```
# vi /etc/rc.conf

icmp_drop_redirect="YES"

```

# 他ユーザのプロセス情報を隠す  {#kcfe9a49}
一般ユーザが自分以外のプロセス情報を見えなくなるようにします。


```
# vi /etc/sysctl.conf

security.bsd.see_other_gids=0
security.bsd.see_other_uids=0

```

# その他のチューニングなど  {#vf041e44}
今まで主にインストール直後に行ったほうが良い設定やセキュリティ関連の設定を行いましたが、これ以降はチューニングの部類に入るので別ページに分けます。
このチューニングはシステムの稼動状況によって数値を変えなければいけないので万人にお勧めできる設定というものがありません。
FreeBSD をチューニングする際にはその点を十分ご留意ください。

- [FreeBSD のチューニング](/archive/freebsd/FreeBSD/Tuning/ "FreeBSD のチューニング")
