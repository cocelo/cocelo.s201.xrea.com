+++
title = "[PukiWiki:wiki] BSD/FreeBSD/OpenSSL"
date = "2008-12-10T09:33:19Z"
+++

# OpenSSL Memo  {#rfc71563}


## はじめに  {#b413909c}
このメモは OpenSSL を用いた CA 構築の一例です。

FreeBSD ではデフォルトの設定ファイルが /etc/ssl にありますが /usr/local/etc/ssl ディレクトリを新たに作成、設定ファイルをコピーし、以降はこのディレクトリで作業することにします。

なお、このドキュメントを作成するにあたり、下記のサイトを参考にさせて戴きました。

この場を借りてお礼申し上げます。

[プライベートCAの構築と運用 - PukiWiki](http://wiki.milkcup.jp/index.php?%A5%D7%A5%E9%A5%A4%A5%D9%A1%BC%A5%C8CA%A4%CE%B9%BD%C3%DB%A4%C8%B1%BF%CD%D1 "プライベートCAの構築と運用 - PukiWiki")

## 認証局 ( CA ) の構築  {#t803cdc8}
以下のようなシェルスクリプトを make_CA.sh などの名前で作成します。

( ここに記述してあるシェルスクリプトはかなり汚いです。なのでもっと綺麗なソース書けるよ！っていう方はご連絡ください。 )


```
# vi /usr/local/etc/ssl/make_CA.sh

#!/bin/sh

DIR=/usr/local/etc/ssl
CADIR=/usr/local/etc/ssl/demoCA

mkdir -p $CADIR/certs $CADIR/crl $CADIR/newcerts $CADIR/private
chmod 700 $CADIR/private
echo "01" > $CADIR/serial
touch $CADIR/index.txt

cp /etc/ssl/openssl.cnf $DIR/openssl.cnf.in

sed -e 's/365/3650/' \
	-e 's/1024/2048/' \
	-e 's/AU/JP/' \
	-e 's/policy		= policy_match/policy		= policy_anything/' \
	-e 's/stateOrProvinceName_default/#stateOrProvinceName_default/' \
	-e 's/Internet Widgits Pty Ltd/Cocelo Style/' \
	-e 's/#organizationalUnitName_default	=/organizationalUnitName_default	= Private CA/' \
	-e 's/nsComment/# nsComment/' \
	$DIR/openssl.cnf.in > $DIR/openssl.cnf

rm $DIR/openssl.cnf.in

openssl req -new -x509 -batch \
	-config $DIR/openssl.cnf \
	-newkey rsa \
	-days 3650 \
	-keyout $CADIR/private/cakey.pem \
	-out $CADIR/cacert.pem

chmod 600 $CADIR/private/cakey.pem

# CRL
openssl ca -config $DIR/openssl.cnf -gencrl -out $CADIR/cacrl.pem

# Hash Link
ln -s $CADIR/cacert.pem $CADIR/newcerts/`openssl x509 -noout -hash < $CADIR/cacert.pem`.0
ln -s $CADIR/cacrl.pem $CADIR/crl/`openssl crl -noout -hash < $CADIR/cacrl.pem`.r0

# Check
openssl x509 -text -noout -in $CADIR/cacert.pem

```

実行権限を与えて実行します。


```
# chmod +x make_CA.sh
# ./make_CA.sh

```

CA を構築し終わったら上記のシェルスクリプトは以降使わないので削除してください。


```
# rm make_CA.sh

```

## 証明書発行要求 ( CSR ) の作成  {#wd558c1c}
まず証明書発行要求 ( CSR ) を作成する為のディレクトリを用意します。

例として /usr/local/etc/ssl 以下に作成しますが、各自運用ポリシーと照らし合わせた上、適当に読み替えてください。


```
# mkdir /usr/local/etc/ssl/clx.ath.cx

```

以下のような設定ファイルを server.cnf として作成します。


```
# vi /usr/local/etc/ssl/clx.ath.cx/server.cnf

RANDFILE = /tmp/ssl.rand

[ req ]
default_bits = 2048
encrypt_key = yes
distinguished_name = req_dn
x509_extensions = cert_type
prompt = no

[ req_dn ]
C=JP
O=Cocelo Style
OU=Cocelo Style
CN=clx.ath.cx
emailAddress=postmaster@clx.ath.cx

[ cert_type ]
nsCertType = server
# nsCertType = client, email
# nsCertType = client, email, objsign

```

証明書発行要求 ( CSR ) を作成するシェルスクリプト server.sh を作成します。


```
# vi /usr/local/etc/ssl/server.sh

#!/bin/sh

DIR=/usr/local/etc/ssl
HOST=clx.ath.cx

dd if=/dev/urandom of=/tmp/ssl.rand count=1

openssl req -new -newkey -nodes -sha1 \
	-config $DIR/$HOST/server.cnf \
	-keyform PEM \
	-keyout $DIR/$HOST/server.key \
	-outform PEM \
	-out $DIR/$HOST/server.csr

openssl rsa -in $DIR/$HOST/server.key \
	-out $DIR/$HOST/server.key

chmod 600 $DIR/$HOST/server.key

openssl gendh -rand /tmp/ssl.rand 512 > $DIR/$HOST/server.dh

chmod 600 $DIR/$HOST/server.dh

rm -f /tmp/ssl.rand

openssl req -text -noout -in $DIR/$HOST/server.csr

```

実行権限を与えて実行します。


```
# chmod 0700 server.sh
# ./server.sh

```

## 証明書発行要求 ( CSR ) から 証明書 ( CRT ) の作成  {#abce5d99}
ここでは証明書の発行を行います。


```
# openssl ca -config ./openssl.cnf -in clx.ath.cx/server.csr -out clx.ath.cx/server.crt

```

内容を確認します。


```
# openssl x509 -text -noout -in clx.ath.cx/server.crt
```

