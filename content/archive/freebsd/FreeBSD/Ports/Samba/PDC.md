+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Samba/PDC"
date = "2010-01-22T08:42:37Z"
+++


# Samba で PDC の構築  {#o373014a}
Samba では Windows の PDC ( プラマイリドメインコントローラ ) が構築できます。
今回は認証のバックエンドとして OpenLDAP を用いた PDC の構築を行います。

- FreeBSD 7.2-RELEASE
- OpenLDAP 2.4
- Samba 3.3

# はじめに  {#h933d914}
PDC を構築する場合、設定箇所が沢山ある事や、問題の切り分けが難しいので、まずは以下の記事でそれぞれのソフトウェアの設定や感覚を掴んだ方がいいかもしれません。

[[FreeBSD/Ports/OpenLDAP]]
[[FreeBSD/Ports/OpenLDAP/LDAP Authentication]]
[[FreeBSD/Ports/Samba]]

# アクセス制御リストと拡張ファイル属性を有効にする  {#u4afd6ff}
Samba で Windows のファイル属性を取り扱うには拡張ファイル属性のサポートが必要です。

[WikiPedia.ja:アクセス制御リスト](https://ja.wikipedia.org/wiki/アクセス制御リスト "WikiPedia.ja:アクセス制御リスト")
[WikiPedia.ja:拡張ファイル属性](https://ja.wikipedia.org/wiki/拡張ファイル属性 "WikiPedia.ja:拡張ファイル属性")

FreeBSD の標準カーネルでは ACL のみ組み込みになっているので、 EA を有効にするには UFS_EXTATTR が必要です。
カーネル再構築の方法は以下をご覧ください。

[カーネルの再構築](/archive/freebsd/FreeBSD/Base/Kernel/ "カーネルの再構築")

カーネルを再構築したら ACL と EA の設定になります。

## ACL を有効にする  {#w834ce74}
ACL を有効にするにあたって、以下のような環境を想定します。

- ACL が必要なパーティションを /var
- ターゲットとなるデバイスは /dev/ad4s1d

ACL を有効にするためには、一度該当パーティションを umount しなければなりません。
しかし、今回のケースでは一度シングルユーザモードに落としてからでないと umount できません。
できれば OS インストール時に有効にしておくのが望ましいですが、そうでない場合は別のパーティションを指定するなど、各自の環境に読み替えてください。


```
# umount /var
# tunefs -a enable /dev/ad4s1d
tunefs: ACLs set
# mount /dev/ad4s1d /var
# mount | grep /var
/dev/ad4s1d on /var (ufs, local, soft-updates, acls)
# tunefs -p /dev/ad4s1d
tunefs: ACLs: (-a)                                         enabled
tunefs: MAC multilabel: (-l)                               disabled
tunefs: soft updates: (-n)                                 enabled
tunefs: gjournal: (-J)                                     disabled
tunefs: maximum blocks per file in a cylinder group: (-e)  2048
tunefs: average file size: (-f)                            16384
tunefs: average number of files in a directory: (-s)       64
tunefs: minimum percentage of free space: (-m)             8%
tunefs: optimization preference: (-o)                      time
tunefs: volume label: (-L)
```

以上で ACL が有効になりました。

## EA を有効にする  {#e9e99cb5}
該当オプションを含めてカーネルの再構築を行ったら、以下のようにして EA を有効にします。


```
# mkdir -p /.attribute/user
# extattrctl start /
# extattrctl initattr 100 /.attribute/user/dosattrib
# extattrctl enable / user DOSATTRIB /.attribute/user/dosattrib
# extattrctl initattr 100 /.attribute/user/samba_pai
# extattrctl enable / user SAMBA_PAI /.attribute/user/samba_pai
```

# 自己認証局 ( PKI ) の構築  {#a761e14f}
Samba <=> LDAP 間の通信を暗号化する為、 PKI の構築を行います。
以下のページに自作の簡単なシェルスクリプトがありますので、よろしければご利用ください。

[[FreeBSD/Base/Certs]]

# OpenLDAP  {#pfc1a69d}
まずは OpenLDAP の設定を行います。

## CA 証明書のコピーとサーバ証明書の発行  {#r893818b}
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
# chmod 755 /usr/local/etc/openldap/certs
# chmod 444 /usr/local/etc/openldap/certs/*
# chmod 700 /usr/local/etc/openldap/key
# chmod 400 /usr/local/etc/openldap/key/*
```

## RootDN のパスワード設定  {#y0ca341f}
RootDN ( 管理者 ) のパスワードを SSHA ( Salted SHA ) 形式で生成します。
ここに表示されているのはあくまでも例なのでコピー & ペーストは行わないでください。


```
# slappasswd -s passwd
{SSHA}I8H1uziqjgevWfKM4JG9V0M29FY6MkJp
```

## slapd.conf の編集  {#zaff1c76}
suffix, rootdn, rootpw は各自の環境に読み替えてください。
また、 Samba のスキーマは ports からインストールした場合、 **/usr/local/share/examples/samba/LDAP/samba.schema** にありますので、それを指定しています。


```
# vi /usr/local/etc/openldap/slapd.conf
```


```
include		/usr/local/etc/openldap/schema/core.schema
include		/usr/local/etc/openldap/schema/cosine.schema
include		/usr/local/etc/openldap/schema/inetorgperson.schema
include		/usr/local/etc/openldap/schema/nis.schema
include		/usr/local/share/examples/samba/LDAP/samba.schema

pidfile		/var/run/openldap/slapd.pid
argsfile	/var/run/openldap/slapd.args

modulepath	/usr/local/libexec/openldap
moduleload	back_bdb

access to attrs=userPassword,sambaLMPassword,sambaNTPassword,sambaPasswordHistory,sambaPwdLastSet,sambaPwdMustChange
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

rootpw		{SSHA}********************************

directory	/var/db/openldap-data

index	objectClass			eq,pres
index	ou,cn,sn,mail,givenname		eq,pres,sub
index	uidNumber,gidNumber,memberUid	eq,pres
index	loginShell			eq,pres
index	uid				pres,sub,eq
index	displayName			pres,sub,eq
index	nisMapName,nisMapEntry		eq,pres,sub
index	sambaSID			eq,sub
index	sambaSIDList			eq
index	sambaGroupType			eq
index	sambaPrimaryGroupSID		eq
index	sambaDomainName			eq
```

## ldap.conf の編集  {#i71468cb}
ldapsearch や ldapadd などのクラアイントのデフォルト値を設定します。


```
# vi /usr/local/etc/openldap/ldap.conf
```


```
BASE	dc=example,dc=com
URI	ldap://ldap.example.com
TLS_CACERT	/usr/local/etc/openldap/certs/ca.crt
```

## 起動  {#x5f91ed4}
設定を完了したら OpenLDAP を起動します。


```
# /usr/local/etc/rc.d/slapd start
```

## 初期エントリ作成  {#j04ef6d1}
正常に起動できたら初期エントリを作成します。


```
# vi initialize.ldif
```


```
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

dn: ou=Idmap,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Idmap

dn: ou=Computer,dc=example,dc=com
objectClass: top
objectClass: organizationalUnit
ou: Computer
```

## 初期エントリ登録  {#v9a1268a}
上記で作成した ldif ファイルを OpenLDAP に流し込みます。


```
# ldapadd -ZZ -x -D 'cn=Manager,dc=example,dc=com' -W -f initialize.ldif
```

## 動作確認  {#odaf3d88}
正常に登録されたか ldapsearch で調べてみます。


```
# ldapsearch -ZZ
```

# nss_ldap と pam_ldap  {#f09a8a6d}
nss_ldap は主にユーザ情報とグループ情報を LDAP と関連付けるために使います。
pam_ldap は *UNIX の認証機構である PAM を LDAP 対応にするためのものです。

## 設定ファイルのコピー  {#n2a58b27}
nss_ldap と pam_ldap は共通の設定ファイルなので、シンボリックリンクを張ってコピーします。


```
# cp /usr/local/etc/ldap.conf.dist /usr/local/etc/ldap.conf
# ln -s /usr/local/etc/ldap.conf /usr/local/etc/nss_ldap.conf
# chmod 644 /usr/local/etc/ldap.conf
```

## nss_ldap と pam_ldap の設定  {#c17d3895}
FreeBSD 上から id 等を見えるように nss_ldap, pam_ldap の設定を行います。
また、ローカルで OpenLDAP を実行している場合はソケット間で通信を行うことができるので、今回はソケットでの通信を指定します。


```
# vi /usr/local/etc/ldap.conf
```


```
uri ldapi://%2fvar%2frun%2fopenldap%2fldapi/
base dc=example,dc=com

bind_timelimit 5
bind_policy soft
```

## nsswitch.conf の編集  {#ga28e35a}
これからはシステムと深く関わる部分なので、新しいコネクションを開いて root としてログインしたものを用意しておいてください。
失敗すると su や SSH でのログインが出来なくなるので、遠隔操作の場合は何も出来なくなってしまいます。

nsswitch.conf を編集して LDAP に登録されているユーザでログイン出来るようにします


```
# vi /etc/nsswitch.conf
```


```
#group: compat
#group_compat:
group: files ldap

hosts: files dns
networks: files

#passwd: compat
#passwd_compat:
passwd: files ldap

shells: files
services: compat
services_compat:
protocols: files
rpc: files
```

## PAM の設定  {#lf24a7ca}
PAM の設定を行わないと Samba でエラーが出てしまうので必ず行ってください。


```
# vi /usr/local/etc/pam.d/samba
```


```
auth		sufficient	/usr/local/lib/pam_ldap.so	no_warn try_first_pass ignore_authinfo_unavail
auth		required	pam_unix.so			no_warn try_first_pass nullok
account		sufficient	/usr/local/lib/pam_ldap.so	ignore_authinfo_unavail
account		required	pam_unix.so
```

# Samba  {#vc8cb24d}
ここからは Samba の設定を行っていきます。

## 設定内容の方針  {#ueb4a9e0}
設定内容としては以下のようなケースを想定しています。

- PDC として動作させる
    -  workgroup でドメイン名を決定しています
- Windows 2000 SP4, Windows XP SP1 以降のクライアントから利用する
    -  client NTLMv2 auth を有効にしているので、 Windows 9x などはログオンできません
- PAM を使わないで LDAP でアカウント情報の管理
- 移動プロファイルを有効に

設定ファイルの各項目は日本 Samba ユーザー会の [Samba-JP](http://wiki.samba.gr.jp/mediawiki/ "Samba-JP") で日本語マニュアルを公開しているのでそちらをご覧ください。

[smb.conf](http://www.samba.gr.jp/project/translation/3.3/htmldocs/manpages-3/smb.conf.5.html "smb.conf")


```
# vi /usr/local/etc/smb.conf
```


```
[global]
   workgroup = SAMBA
   netbios name = PDC
   server string = Samba Server

   load printers = no
   printing = bsd

   log level = 0
   syslog = 0

   log file = /var/log/samba/log.%m
   max log size = 50

   hosts allow = 192.168.1.
   socket options = IPTOS_LOWDELAY TCP_NODELAY

   security = user

   passdb backend = ldapsam:ldap://ldap.example.com

   ldapsam:trusted = yes
   ldapsam:editposix = yes

   ldap passwd sync = yes

   ldap admin dn = cn=Manager,dc=example,dc=com
   ldap suffix = dc=example,dc=com
   ldap group suffix = ou=Group
   ldap user suffix = ou=People
   ldap machine suffix = ou=Computer
   ldap idmap suffix = ou=Idmap

   ldap delete dn = yes

   idmap backend = ldap:ldap://ldap.example.com
   idmap uid = 10000-19999
   idmap gid = 10000-19999

   winbind enum users = yes
   winbind enum groups = yes

   template homedir = /home
   template shell = /usr/sbin/nologin

   admin users = Administrator
   guest account = Guest

   map to guest = Bad User

   client NTLMv2 auth = yes

   store dos attributes = yes
   ea support = yes
   map acl inherit = yes
   map archive = no

   inherit acls = yes
   inherit permissions = yes

   dos filetime resolution = yes
   dos filemode = yes

   logon home = \\%L\%U
   logon path = \\%L\%U\.profiles
   logon drive = Z:
   logon script = logon.bat

   dns proxy = no

   domain logons = yes
   domain master = yes
   local master = yes
   wins support = yes
   preferred master = yes
   os level = 64

   display charset = UTF-8
   unix charset = UTF-8
   dos charset = CP932

[homes]
   comment = Home Directories
   browseable = no
   read only = no

[profiles]
   comment = User Profile Directories for 2000 & XP
   path = /%H/.profiles
   browseable = no
   read only = no

[profiles.V2]
   comment = User Profile Directories for Vista & 7
   path = /%H/.profiles.V2
   browseable = no
   read only = no

[netlogon]
   comment = Network Logon Service
   path = /usr/local/share/samba/netlogon
   browseable = no
   read only = yes
   write list = Administrator
```

また、現在の設定内容を確認したい場合は testparm というコマンドがあります。


```
# testparm -vs | less
```

## ディレクトリの作成  {#le6dfeb6}
netlogon 用のディレクトリを作成します。


```
# mkdir -p /usr/local/share/samba/netlogon
# chmod 755 /usr/local/share/samba/netlogon
```

netlogon ディレクトリに logon.bat を配置すると、バッチフファイルがドメインにログオンする時に実行されます。
なお、改行コードは CR+LF なのでご注意ください。

## LDAP の管理者パスワードの設定  {#q08c1db0}
Samba に LDAP 管理者のパスワードを設定します。
今回の例では cn=Manager,dc=example,dc=com のパスワード ( つまり OpenLDAP の rootpw ) を設定します。


```
# smbpasswd -W
Setting stored password for "cn=Manager,dc=example,dc=com" in secrets.tdb
New SMB password:
Retype new SMB password:
```

## WinBIND の起動  {#p11a8de3}
WinBIND を起動します。


```
# /usr/local/sbin/winbindd -s /usr/local/etc/smb.conf
```

## ユーザ / グループの登録  {#k132013b}
net コマンドでユーザ、グループの登録を行います。


```
# net sam provision
```

## Administrator のパスワード設定  {#n04b667a}
LDAP に登録された Administrator のパスワード設定を行います。


```
# smbpasswd Administrator
```

## Samba の起動  {#bfa2b412}
Samba を起動します。


```
# /usr/local/etc/rc.d/samba restart
```

## 権限付与  {#b0f0495f}
Administrator にマシンアカウントの追加や削除が行えるように、権限を付与します。


```
# net sam rights grant Administrator SeMachineAccountPrivilege -U Administrator
# net sam rights grant Administrator SeAddUsersPrivilege -U Administrator
# net sam rights grant Administrator SeDiskOperatorPrivilege -U Administrator
# net sam rights grant Administrator SeBackupPrivilege -U Administrator
# net sam rights grant Administrator SeRestorePrivilege -U Administrator
# net sam rights grant Administrator SeRemoteShutdownPrivilege -U Administrator
# net sam rights grant Administrator SeTakeOwnershipPrivilege -U Administrator
# net sam rights grant Administrator SePrintOperatorPrivilege -U Administrator
```

## ユーザの追加  {#e62a9bd9}

```
# net rpc -U Administrator user add ユーザー名 パスワード
```

# 参考リンク  {#mb3f9959}
[Samba-JP](http://wiki.samba.gr.jp/mediawiki/ "Samba-JP")
