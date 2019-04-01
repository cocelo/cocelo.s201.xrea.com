+++
title = "[PukiWiki:freebsd] FreeBSD/Base/BIND"
date = "2008-10-16T04:12:04Z"
+++


# 名前解決で BIND を使用する  {#wed2eb44}
通常、名前解決の為には hosts ファイルなどを使いますが、ネットワーク上に多数のコンピュータが存在する場合、その全てのコンピュータで hosts ファイルを編集するのは些か面倒です。
なので、ここでは BIND を使った正引き、逆引きの設定を行います。

# 自動起動の設定  {#pf5d602e}
BIND が自動起動するように rc.conf に named_enable を記述します。


```
# vi /etc/rc.conf

named_enable="YES"

```

# ルートヒントファイルの更新  {#a8429afb}
ルートヒントファイルは常に最新の状態を保たなければいけません。


```
% cd /etc/namedb
% sudo fetch ftp://rs.internic.net/domain/named.root

```

# rndc の設定  {#v56bdfb9}
次に BIND を操作するための rndc の設定を行います。

## 鍵ファイルの作成  {#qe0b6adf}
rndc の設定を行うに当たって、鍵ファイルが必要になります。
FreeBSD では最初から用意されていますが、少し気持ち悪いので作り直します。


```
# rndc-confgen -a

```

通常は /etc/namedb/rndc.key に保存されています。


```
# ls -l /etc/namedb/ | grep rndc.key

-rw-------  1 root  wheel    77 Nov  1 00:00 rndc.key

```

## 鍵ファイルのコピー  {#efeb7f16}
先程作成した鍵ファイルの内容を rndc.conf にコピーします。


```
# cat /etc/namedb/rndc.key > /etc/namedb/rndc.conf

```

コピーされている内容は以下のようなものになっていると思います。
secret "md5"; の md5 はランダムな文字列です。


```
# cat /etc/namedb/rndc.conf

key "rndc-key" {
	algorithm hmac-md5;
	secret "md5";
};

```

## rndc.conf の設定  {#f1dfbf73}
次に rndc.conf を編集して、ローカルマシンからのみ操作出来るようにします。


```
# vi /etc/namedb/rndc.conf

key "rndc-key" {
	algorithm hmac-md5;
	secret "md5";
};

options {
	default-key "rndc-key";
	default-server 127.0.0.1;
	default-port 953;
};

Server 127.0.0.1 {
	key "rndc-key";
};

```

## root 以外は見れないようにする  {#w08a90e1}
rndc.conf と rndc.key は root だけに見えるようにします。


```
# chmod 600 /etc/namedb/rndc.conf
# chmod 600 /etc/namedb/rndc.key

```

# 注意事項  {#c4588bd9}
意外とハマりやすいのがユーザーとグループの設定に関してです。
log の取得に関しても、ユーザーとグループの所属が違うとログ関連でエラーが出力されます。
FreeBSD ( Linux *BSD Solaris etc ) に慣れている人でも、一度ハマってしまうと中々抜け出せません。

サーバを運営するのなら、そういった事柄を常に頭の隅に置いておく事が大切です。

# DNS サーバの種類  {#h2fc0bc2}
DNS サーバでは用途によって設定内容が変わります。
例えばコンテンツサーバとキャッシュサーバを分けて運営したり、マスター、スレーブの関係や、ゾーン転送に関してなど、学ぶべき事が多いです。
特に DNS サーバではドメインの名前解決という、全てのサーバに関わる事なので、自分はどのような DNS サーバを構築したいのか、今一度考え直してみてください。

- [内向き DNS サーバの設定](/archive/freebsd/FreeBSD/Base/BIND/Private/ "内向き DNS サーバの設定")
- [外向き DNS サーバの設定](/archive/freebsd/FreeBSD/Base/BIND/Internet/ "外向き DNS サーバの設定")

# リンク  {#md88c97c}
[連載記事 「BINDで作るDNSサーバ」](http://www.atmarkit.co.jp/flinux/index/indexfiles/bindindex.html "連載記事 「BINDで作るDNSサーバ」")
[連載記事 「実用 BIND 9で作るDNSサーバ」](http://www.atmarkit.co.jp/flinux/index/indexfiles/bind9index.html "連載記事 「実用 BIND 9で作るDNSサーバ」")
