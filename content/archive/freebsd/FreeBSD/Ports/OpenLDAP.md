+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/OpenLDAP"
date = "2009-10-27T23:46:04Z"
+++


# LDAP サーバの構築  {#sc2c7ebd}
OpenLDAP を用いた LDAP サーバを構築します。
ここでは jail 環境での構築方法の解説になります。
jail 環境に共通して言える事ですが、ループバックインターフェース ( lo0 ) が使えない事意外は特に注意すべき点はないので jail のホストでも応用が利きます。

# DIT  {#m3e69c8e}
階層格納構造は下記の通り。


```
+ dc=example,dc=com     suffix
    + dc=People         アカウント情報
    |   + cn=test       テストアカウント
    + ou=Group          グループ情報
        + cn=FTPUser    FTPグループ
        + cn=test       テストグループ
```

# インストール  {#uab65b88}
まずはインストールから行います。


```
# cd /usr/ports/net/openldap24-server
# make install clean
```


```
# rehash
```

# CA 証明書のコピーとサーバ証明書の発行  {#r893818b}
TLSを用いて暗号化された通信を行うので CA 証明書とサーバ証明書、サーバ秘密鍵を用意します。
まずは証明書と秘密鍵を格納するディレクトリを作成します。


```
# mkdir /usr/local/etc/openldap/certs
# mkdir /usr/local/etc/openldap/key
```

次に CA 証明書とサーバ証明書、サーバ秘密鍵を用意しますが、 CA 証明書とサーバ証明書は **/usr/local/etc/openldap/certs** 以下に格納し、サーバ秘密鍵は **/usr/local/etc/openldap/key** 以下に格納することにします。
CA を自前で用意している場合 ( 自己認証局を構築している場合 ) は CA 証明書とサーバ証明書、サーバ秘密鍵を発行します。
ベリサイン等にサーバ証明書を発行してもらった場合はそちらのCA 証明書とサーバ証明書、サーバ秘密鍵をお使いください。


```
# chown -R ldap:ldap /usr/local/etc/openldap/certs
# chown -R ldap:ldap /usr/local/etc/openldap/key
# chmod 744 /usr/local/etc/openldap/certs
# chmod 444 /usr/local/etc/openldap/certs/*
# chmod 700 /usr/local/etc/openldap/key
# chmod 400 /usr/local/etc/openldap/key/*
```

# RootDN のパスワード設定  {#w1008b56}
RootDN ( 管理者 ) のパスワードを SSHA ( Salted SHA ) 形式で生成します。
ここに表示されているのはあくまでも例なのでコピー & ペーストは行わないこと。


```
# slappasswd -s passwd
{SSHA}I8H1uziqjgevWfKM4JG9V0M29FY6MkJp
```

# slapd.conf の編集  {#gf574dab}
ベースとなる設定を行います。


```
# vi /usr/local/etc/openldap/slapd.conf
```


```
include		/usr/local/etc/openldap/schema/core.schema
include		/usr/local/etc/openldap/schema/cosine.schema
include		/usr/local/etc/openldap/schema/inetorgperson.schema
include		/usr/local/etc/openldap/schema/nis.schema

pidfile		/var/run/openldap/slapd.pid
argsfile	/var/run/openldap/slapd.args

modulepath	/usr/local/libexec/openldap
moduleload	back_bdb

access to attrs=userPassword
	by self write
	by anonymous auth
	by * none

access to *
	by self write
	by * read

TLSCACertificateFile	/usr/local/etc/openldap/certs/ca.crt
TLSCertificateFile	/usr/local/etc/openldap/certs/server.crt
TLSCertificateKeyFile	/usr/local/etc/openldap/key/server.key

database	bdb
suffix		"dc=example,dc=com"
rootdn		"cn=Manager,dc=example,dc=com"

# password "passwd"
rootpw		{SSHA}AcYy8pS+tcwWKuLSM07hwEdOnL8BX824

directory	/var/db/openldap-data

index	objectClass,uid,uidNumber,gidNumber,memberUid	eq
index	cn,mail,surname,givenname	eq,subinitial
```

## 各エントリの objectClass  {#d9e0503e}


```
include		/usr/local/etc/openldap/schema/core.schema
include		/usr/local/etc/openldap/schema/cosine.schema
include		/usr/local/etc/openldap/schema/inetorgperson.schema
include		/usr/local/etc/openldap/schema/nis.schema
```

## アクセス制御  {#kdedec30}


```
access to attrs=userPassword
	by self write
	by anonymous auth
	by * none

access to *
	by self write
	by * read
```

## 証明書と秘密鍵  {#j537a95e}


```
TLSCACertificateFile	/usr/local/etc/openldap/certs/ca.crt
TLSCertificateFile	/usr/local/etc/openldap/certs/server.crt
TLSCertificateKeyFile	/usr/local/etc/openldap/key/server.key
```

## ドメイン  {#ubcb9491}


```
suffix	"dc=example,dc=com"
```

## 管理者 DN  {#se266174}


```
rootdn	"cn=Manager,dc=example,dc=com"
```

## 管理者 DN のパスワード  {#ic4f22c3}


```
rootpw	{SSHA}I8H1uziqjgevWfKM4JG9V0M29FY6MkJp
```

## 検索を早くするための index  {#wee212a8}


```
index	objectClass,uid,uidNumber,gidNumber,memberUid	eq
```

# ldap.conf の編集  {#j2d4331f}
ldapsearch や ldapadd などのクラアイントのデフォルト値を設定します。


```
# vi /usr/local/etc/openldap/ldap.conf
```


```
BASE	dc=example,dc=com
URI	ldap://ldap.example.com
TLS_CACERT	/usr/local/etc/openldap/certs/ca.crt
```

## ベースとなるドメイン  {#p74552ed}


```
BASE	dc=example,dc=com
```

## LDAP URI  {#j39b64e9}


```
URI	ldap://ldap.example.com
```

## CA 証明書  {#xb16ff9b}


```
TLS_CACERT	/usr/local/etc/openldap/certs/ca.crt
```

# 自動起動の設定  {#nd66eb38}
インストールの時に出てきたメッセージの通り設定します。


```
# vi /etc/rc.conf
```


```
slapd_enable="YES"
slapd_flags='-h "ldapi://%2fvar%2frun%2fopenldap%2fldapi/ ldap://ldap.example.com/ ldaps://ldap.example.com/"'
slapd_sockets="/var/run/openldap/ldapi"
```

# 起動  {#vae778a4}
全て問題が無ければ起動します。


```
# /usr/local/etc/rc.d/slapd start

```

# BDB の設定ファイルのコピー  {#r97f2708}
BerkeleyDB の設定ファイルが存在しないと下記のような Warning がログに出力されます。


```
bdb_db_open: Warning - No DB_CONFIG file found in directory /var/db/openldap-data: (2) Expect poor performance for suffix dc=example,dc=com.
```

この Warning は BerkeleyDB の設定ファイルをコピーすれば出力されなくなります。


```
# cp /usr/local/etc/openldap/DB_CONFIG.example /var/db/openldap-data/DB_CONFIG
# chown ldap:ldap /var/db/openldap-data/DB_CONFIG
```

# 動作確認  {#cef75bfd}
接続出来るかどうか ldapsearch を実行します。


```
# ldapsearch
```

# 初期エントリの作成  {#v5e32e4a}
テストユーザのパスワードを生成します。
以下の場合では「test」というパスワードが暗号化されています。


```
# slappasswd -s test
{SSHA}2f/mb1QQl4LTYsSmlKjZWYgvxVLWsQ/n
```

dc o cn を各自の環境と読み替えてください。


```
# vi initialize.ldif
```


```
################################################################################
# directory hierarchy

dn: dc=example,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: Example
dc: example

dn: ou=People,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: People

dn: ou=Group,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Group

################################################################################
# user account

# test
dn: uid=test,ou=People,dc=example,dc=com
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: test
userPassword: {SSHA}2f/mb1QQl4LTYsSmlKjZWYgvxVLWsQ/n
uidNumber: 11000
gidNumber: 11000
cn: test
sn: test
givenname: test
gecos: test user
homeDirectory: /nonexistent
loginShell: /usr/sbin/nologin
mail: test@example.com
shadowLastChange: 0
shadowMin: 0
shadowMax: 99999
shadowWarning: 7

################################################################################
# group

dn: cn=test,ou=Group,dc=example,dc=com
objectClass: top
objectClass: posixGroup
cn: test
gidNumber: 11000
memberUid: test

dn: cn=ftp,ou=Group,dc=example,dc=com
objectClass: top
objectClass: posixGroup
cn: ftp
gidNumber: 10000
memberUid: test
```

# 初期エントリの追加  {#e23ba793}
初期エントリを追加するために ldapadd を使用します。
各オプションは下記の通りです。

| -Z[Z] | START TLS で接続する。二回指定すると START TLS が成功した場合のみ接続を続行する |
| -x | SASL を使わない簡易認証 |
| -D | 管理者の DN |
| -W | パスワードプロンプトの出力 |
| -f | ldif ファイルを指定 |


```
# ldapadd -ZZ -x -D 'cn=Manager,dc=example,dc=com' -W -f initialize.ldif
```

# 動作確認  {#t2428e2f}
ldapsearch コマンドで初期エントリが追加されているか調べます。


```
# ldapsearch -ZZ
```

# 付録：データリセット  {#y090ebf4}

```
# /usr/local/etc/rc.d/slapd stop
# rm -fr /var/db/openldap-data/*
# cp /usr/local/etc/openldap/DB_CONFIG.example /var/db/openldap-data/DB_CONFIG
# chown ldap:ldap /var/db/openldap-data/DB_CONFIG
# /usr/local/etc/rc.d/slapd start
```

# リンク  {#v58255ea}
この記事を書くに当たって参考にさせて頂いたサイト様。

- [OpenLDAP, Title](http://www.openldap.org/ "OpenLDAP, Title")
- [OpenLDAP Information](http://www5f.biglobe.ne.jp/~inachi/openldap/ "OpenLDAP Information")
- [【FreeBSD 5.3】OpenLDAP の設定](http://www.abk.nu/~nabe/document/openldap.htm "【FreeBSD 5.3】OpenLDAP の設定")
- [【FreeBSD 5.3】Samba 3.x + OpenLDAP による PDC の設定](http://www.abk.nu/~nabe/document/samba3.htm "【FreeBSD 5.3】Samba 3.x + OpenLDAP による PDC の設定")
- [[[LDAPによるユーザ情報の管理 - takedarts.jp](http://takedarts.jp/index.php?LDAP%A4%CB%A4%E8%A4%EB%A5%E6%A1%BC%A5%B6%BE%F0%CA%F3%A4%CE%B4%C9%CD%FD "[[LDAPによるユーザ情報の管理 - takedarts.jp")]]
- [FreeBSD で LDAP サーバ ver 0.2.1](http://www.pqrs.org/~tekezo/unix/doc/ldap/ldap.html "FreeBSD で LDAP サーバ ver 0.2.1")
- [連載：そろそろLDAPにしてみないか？｜gihyo.jp](http://gihyo.jp/admin/serial/01/ldap "連載：そろそろLDAPにしてみないか？｜gihyo.jp")
