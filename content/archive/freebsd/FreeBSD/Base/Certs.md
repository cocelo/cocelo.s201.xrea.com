+++
title = "[PukiWiki:freebsd] FreeBSD/Base/Certs"
date = "2009-10-31T22:30:06Z"
+++


# はじめに  {#z0cc7f6a}
Apache の SSL などでは証明書が必要ですが、ベリサインなどの認証局を利用しようとすると相当額が発生してしまいます。
ビジネスで利用する場合は信頼性が第一ですので、そういった場合ではこの自己認証局を構築しない方が良いです。
しかし、個人で利用する場合は通信の暗号化が目的なので、逆に自己認証局を構築した方がコストを抑えられます。

# 私的シェルスクリプト  {#ic3a8a4e}
以下に私が作成したシェルスクリプトを置いておきます。

[CA.sh](http://svn.sourceforge.jp/svnroot/cocelo-style/platform/shellscript/CA.sh "CA.sh")

## 設定値について  {#w780dc7d}
必ず変更しなければならないのが **Organization Name ( O )** です。
規定値では example.com となっているので、各自の環境にあわせて編集してください。


```
# vi /root/CA.sh
```


```
BASE_DIR=/usr/local/etc/ssl
CA_O=example.com
SERVER_O=example.com
CLIENT_O=example.com
```

## シェルスクリプトを root だけ使えるようにする  {#sa35d204}
シェルスクリプトを root だけ使えるようにするため、パーミッションの変更を行います。


```
# chmod 700 /root/CA.sh
# chown root:wheel /root/CA.sh
```

# 自己認証局の構築  {#xa7d7a31}
以下のコマンドを入力し、何回かパスフレーズの設定と質問に答えれば、自己認証局が構築されます。


```
# ./CA.sh -newca
```

# サーバ証明書の発行  {#ne667d45}
以下のコマンドを入力すればサーバ証明書が発行されます。


```
# ./CA.sh -newserver www
```

# クライアント証明書の発行  {#ne667d45}
以下のコマンドを入力すればクライアント証明書が発行されます。


```
# ./CA.sh -newclient client
```

# 参考リンク  {#r518a4fd}
自己認証局の構築や、シェルスクリプト作成に当たって、下記のサイトを参考にしました。

- [プライベートCAの構築と運用 - PukiWiki](http://wiki.milkcup.jp/index.php?%A5%D7%A5%E9%A5%A4%A5%D9%A1%BC%A5%C8CA%A4%CE%B9%BD%C3%DB%A4%C8%B1%BF%CD%D1 "プライベートCAの構築と運用 - PukiWiki")
- [openssl:CA](http://e.tir.jp/wiliki?openssl%3aCA "openssl:CA")
