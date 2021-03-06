+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/djbdns"
date = "2008-10-16T04:12:13Z"
+++


# djbdns  {#mb78969c}
BIND は度々セキュリティホールが見つかるため、不安は拭いきれません。
今回は djbdns で BIND を置き換えます。

# daemontools のインストール  {#i7e08935}
djbdns は daemontools を使ってサービス停止や起動を制御するので daemontools のインストールからです。


```
% sudo portinstall sysutils/daemontools

```

# daemontools のサービスディレクトリの作成  {#sc373d64}
daemontools はサービスディレクトリ以下にあるファイルを見て daemontools が制御すべきサービスを判断します。


```
% sudo mkdir /var/service

```

サービスディレクトリを変えたい場合は下記のように svscan_servicedir を設定する事で変える事が出来ます。
通常なら /var/service 以下で問題ないでしょう。


```
# svscan_servicedir     The directory containing the various service.
#                       directories to be monitored.  Professor Daniel J.
#                       Bernstein recomments "/service", but the FreeBSD
#                       port has a default of "/var/service" instead, which
#                       is consistent with the FreeBSD filesystem hierarchy
#                       guidelines as described in the hier(7) manual page.

```

# daemontools の自動起動  {#p01b1e5f}
daemontools の自動起動の設定です。


```
% sudo vi /etc/rc.conf

svscan_enable="YES"

```

# daemontools の起動  {#je354401}
daemontools の起動を起動します。


```
% sudo /usr/local/etc/rc.d/svscan.sh start

```

# djbdns 用のユーザ及びグループの作成  {#k3edbaec}
まずは djbdns 用のユーザ作成を行います。
UID GID が重複しない様、気をつけましょう。


```
% sudo pw groupadd -n dns
% sudo pw useradd -n dnscache -c "djbdns dnscache" -d /nonexistent -g dns -h - -s /sbin/nologin
% sudo pw useradd -n tinydns -c "djbdns tinydns" -d /nonexistent -g dns -h - -s /sbin/nologin
% sudo pw useradd -n dnslog -c "djbdns dnslog" -d /nonexistent -g dns -h - -s /sbin/nologin

```

# djbdns のインストール  {#ydc938ab}
djbdns のインストールを行います。


```
% sudo portinstall dns/djbdns

```

# djbdns が使用するディレクトリの作成  {#q69a2ede}
通常は /var/dnscache などに作成するようですが、ここでは /usr/local/etc/namedb 以下にディレクトリを作成します。
理由としては FreeBSD の BIND の使用しているディレクトリが /etc/namedb ( シンボリックリンク ) のため、作業中の混乱を防止する意味合いでもあります。


```
% sudo mkdir -p /usr/local/etc/namedb

```

# 外向き DNS サーバと内向き DNS サーバの設定  {#sc68856e}
BIND で設定した際に、外向きと内向きで設定が違うと言及しました。
これは再帰検索と反復検索の違いを暗に意味しており、 BIND のように設定次第で再帰検索と反復検索が同時に実現出来てしまうのは初心者にとって非常に危険です。
DNS の仕組みについては [＠IT - アットマーク・アイティ](http://www.atmarkit.co.jp/ "＠IT - アットマーク・アイティ") の [DNSの仕組みの基本を理解しよう](http://www.atmarkit.co.jp/fnetwork/rensai/dns01/dns01.html "DNSの仕組みの基本を理解しよう") で非常に分かり易く説明されているので、一度は目を通しておいたほうが良いでしょう。

- [内向き DNS サーバの設定](/archive/freebsd/FreeBSD/Ports/djbdns/Private/ "内向き DNS サーバの設定")
- [外向き DNS サーバの設定](/archive/freebsd/FreeBSD/Ports/djbdns/Internet/ "外向き DNS サーバの設定")
