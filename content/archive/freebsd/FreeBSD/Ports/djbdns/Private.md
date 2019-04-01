+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/djbdns/Private"
date = "2008-11-26T16:50:10Z"
+++


# 内向き DNS サーバの構築  {#t29971cd}
ここではローカルネットワーク向けに DNS サーバを提供する、コンテツサーバ、キャッシュ ( リゾルバ ) サーバを構築します。

# ネットワーク構成  {#j90534bd}
構成としては下記のように、ルーター配下にサーバが存在する、もっともスタンダードだと思われるネットワーク構成です。


```
                +---------+   +----------+           +---------------+------+---------------+
                |         |   |          |           |               |      |               |
--- Internet ---+   ONU   +---+  Router  +--- LAN    |               |      |    tinydns    |
                |         |   |          |     |     |               |      | 192.168.0.100 |
                +---------+   +----------+     |     |               |      |               |
                                               +-----+  192.168.0.2  + jail +---------------+
                                               |     |               |      |               |
                                               |     |               |      |   dnscache    |
                                               |     |               |      | 192.168.0.101 |
                                               |     |               |      |               |
                                               |     +---------------+------+---------------+
                                               |
                                               |     +---------------+
                                               |     |               |
                                               +-----+     Client    |
                                                     |               |
                                                     +---------------+

```

# 名前解決に至るまでの大まかな流れ  {#q06ad267}
名前解決の流れとしては下記のような形になります。

0.  全てのクエリはまず dnscache に対して行われる
0.  キャッシュを保持している場合は名前解決
0.  キャッシュを保持していない場合で、ゾーン情報を tinydns が保持しているなら tinydns にクエリを渡して名前解決
0.  キャッシュを保持していない場合で、ゾーン情報を tinydns が保持していないならプロバイダにクエリを渡して名前解決

# キャッシュサーバの構築  {#c24fa851}
キャッシュサーバの構築を行います。

## dnscache-conf で初期設定を行う  {#w647854b}
dnscache-conf で、キャッシュサーバの初期設定を行います。


```
% sudo dnscache-conf dnscache dnslog /usr/local/etc/namedb/dnscache 192.168.0.101

```

## アクセス制御の設定  {#c98c38f1}
デフォルトの状態だとローカルマシンだけしかアクセス出来ないので、利用するクライアントを許可する設定にしましょう。
この例では 192.168.0.0/24 からのアクセスを許可する設定になります。


```
% sudo touch /usr/local/etc/namedb/dnscache/root/ip/192.168.0

```

## 自ドメインの名前解決を tinydns に問い合わせ  {#x8ddca7f}
自ドメインのゾーン情報を tinydns に問い合わせるように設定します。
この設定ですと clx.ath.cx の正引き情報と逆引き情報を tinydns に問い合わせる事になります。


```
% echo 192.168.0.100 | sudo tee /usr/local/etc/namedb/dnscache/root/servers/example.com
% echo 192.168.0.100 | sudo tee /usr/local/etc/namedb/dnscache/root/servers/0.168.192.in-addr.arpa

```

## 自ドメイン以外の名前解決はプロバイダに問い合わせ  {#a60576cf}
自ドメイン以外のゾーン情報はプロバイダの DNS サーバに問い合わせます。


```
% echo 1 | sudo tee /usr/local/etc/namedb/dnscache/env/FORWARDONLY
% printf "202.224.32.1\n202.224.32.2\n" | sudo tee /usr/local/etc/namedb/dnscache/root/servers/@

```

## シンボリックリンクを作成  {#fe9ff082}
シンボリックリンクを作成して dnscache を起動します。


```
% sudo ln -s /usr/local/etc/namedb/dnscache /var/service/.

```

## 起動しているか確認する  {#q654e9dc}
ちゃんと起動しているかどうか確認するため svstat を実行します。


```
% sudo svstat /var/service/dnscache

```

以下のように up と出力されていれば成功です。


```
/var/service/dnscache: up (pid 91984) 1 seconds

```

# コンテンツサーバの構築  {#w0060797}
コンテンツサーバの構築を行います。

## tinydns-conf で初期設定を行う  {#r497d660}
tinydns-conf でコンテンツサーバの初期設定を行います。


```
% sudo tinydns-conf tinydns dnslog /usr/local/etc/namedb/tinydns 192.168.0.100

```

## 自ドメインのゾーン情報の登録  {#zba4e079}
自ドメインのゾーン情報の登録を行う為、下記のようなコマンドを入力します。
なお、初期設定を行った際にシェルスクリプトがいくつか作成されるが、今回はそれを使わないで登録します。


```
% cd /usr/local/etc/namedb/tinydns/root
% sudo vi data

```


```
# SOA + NS + A + PTR
.example.com:192.168.0.101:dns.example.com
.0.168.192.in-addr.arpa::dns.example.com
^101.0.168.192.in-addr.arpa:dns.example.com

# MX + A + PTR
@example.com:192.168.0.200:mail.example.com:10
^200.0.168.192.in-addr.arpa:mail.example.com

# A + PTR
=ns.example.com:192.168.0.100

# A
+ntp.example.com:192.168.0.100
```

make するとバイナリのデータベースファイルが作成されます。


```
% sudo make

```

## シンボリックリンクを作成  {#m25c7842}
シンボリックリンクを作成して tinydns を起動します。


```
% sudo ln -s /usr/local/etc/namedb/tinydns /var/service/.

```

## 起動しているか確認する  {#v545bda7}
ちゃんと起動しているかどうか確認するため svstat を実行します。


```
% sudo svstat /var/service/tinydns

```

以下のように up と出力されていれば成功です。


```
/var/service/tinydns: up (pid 91983) 1 seconds

```

# 動作確認  {#nc2a4a69}
dig で動作確認を行います。


```
% dig @192.168.0.101 example.com
% dig @192.168.0.101 -x 192.168.0.101
% dig @192.168.0.101 www.clx.ath.cx
% dig @192.168.0.101 yahoo.co.jp
% dig @192.168.0.101 google.com

```

# 名前解決に djbdns を使用する  {#u5697786}
ここまで問題無ければ名前解決に djbdns を使用します。


```
% sudo vi /etc/resolv.conf

domain	example.com
nameserver	192.168.0.101
```

