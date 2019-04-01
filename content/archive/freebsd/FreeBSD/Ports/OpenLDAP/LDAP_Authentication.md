+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/OpenLDAP/LDAP_Authentication"
date = "2008-10-16T04:12:10Z"
+++


# nss_ldap と pam_ldap で LDAP 認証  {#u8fa0e01}
通常のアカウントの認証方法は大抵の場合が /etc/passwd だったりします。
それを LDAP に管理させれば、ホスト毎にアカウントを設定する手間や、不整合を無くすことが出来ます。

# nss_ldap のインストール  {#h9865971}
まずは nss_ldap のインストールから行います。


```
# portinstall net/nss_ldap

The nss_ldap module expects to find its configuration files at the
following paths:

LDAP configuration:     /usr/local/etc/nss_ldap.conf
LDAP secret (optional): /usr/local/etc/nss_ldap.secret


WARNING: For users of previous versions of this port:
WARNING:
WARNING: Previous versions of this port expected configuration files
WARNING: to be located at /etc/ldap.conf and /etc/ldap.secret.  You
WARNING: may need to move these configuration files to their new
WARNING: location specified above.

```

# pam_ldap のインストール  {#af074aa2}
次に pam_ldap のインストールを行います。


```
# portinstall security/pam_ldap

Copy /usr/local/etc/ldap.conf.dist to /usr/local/etc/ldap.conf, then edit
/usr/local/etc/ldap.conf in order to use this module.  Add a line similar to
the following to /etc/pam.conf on 4.X, or create an /etc/pam.d/ldap on 5.X
and higher with a line similar to the following:

login   auth    sufficient      /usr/local/lib/pam_ldap.so

```

[pam.conf\(5\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=pam.conf&dir=jpman-6.3.2%2Fman&sect=0 "pam.conf\(5\)") を見てみると分かるのですが、 function-class には login というものはありません。
このインフォメーションは少々古いもののようです。

# 設定ファイルのコピー  {#rfb064e0}
ldap.conf.dist と nss_ldap.conf.sample をコピーします。


```
# cp /usr/local/etc/ldap.conf.dist /usr/local/etc/ldap.conf
# ln -s /usr/local/etc/ldap.conf /usr/local/etc/nss_ldap.conf
# chmod 644 /usr/local/etc/ldap.conf

```

# nss_ldap と pam_ldap の設定  {#jc678443}
nss_ldap は pam_ldap のシンボリックリンクなので、 pam_ldap を編集すれば nss_ldap にも適用されます。


```
# vi /usr/local/etc/ldap.conf

host ldap.clx.ath.cx
base dc=clx,dc=ath,dc=cx
uri ldaps://ldap.clx.ath.cx/
port 636
scope one
bind_policy soft
pam_filter objectclass=posixAccount
pam_login_attribute uid
pam_member_attribute memberUid
nss_base_passwd		ou=Users,ou=System,dc=clx,dc=ath,dc=cx?one
nss_base_shadow		ou=Users,ou=System,dc=clx,dc=ath,dc=cx?one
nss_base_group		ou=Group,ou=System,dc=clx,dc=ath,dc=cx?one
ssl on
tls_checkpeer yes
tls_cacertfile /usr/local/etc/openldap/certs/ca.cert

```

この設定の中でも、bind_policyだけは指定しておいた方が良いです。

- [[LDAP-Users:48]](http://ml.ldap.jp/pipermail/ldap-users/2007-June/000047.html "[LDAP-Users:48]")
- [[LDAP-Users:49]](http://ml.ldap.jp/pipermail/ldap-users/2007-June/000048.html "[LDAP-Users:49]")

# 以降の作業について  {#l6671f52}
これからはシステムと深く関わる部分なので、新しいコネクションを開いて root としてログインしたものを用意しておいてください。
失敗すると su や SSH でのログインが出来なくなるので、遠隔操作の場合は何も出来なくなってしまいます。

# nsswitch.conf の編集  {#x782106c}
nsswitch.conf を編集して LDAP に登録されているユーザでログイン出来るようにしておきます。


```
# vi /etc/nsswitch.conf

#group: compat
#group_compat: nis
group: files ldap
hosts: files dns
networks: files
#passwd: compat
#passwd_compat: nis
passwd: files ldap
shells: files

```

既存の group,passwd をコメントアウトし、新たに group,passwd を定義しています。
詳細は [nsswitch.conf\(5\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=nsswitch.conf&dir=jpman-6.3.2%2Fman&sect=0 "nsswitch.conf\(5\)") をご参照下さい。

# テストユーザの追加  {#zdda498e}
動作確認をする為、テストユーザを追加します。


```
# vi testuser.ldif

################################################################################
# user data

# test
dn: uid=test,ou=Users,ou=System,dc=clx,dc=ath,dc=cx
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: test
uid: test
userPassword: {SSHA}I8H1uziqjgevWfKM4JG9V0M29FY6MkJp
uidNumber: 11000
gidNumber: 11000
homeDirectory: /nonexistent
loginShell: /usr/sbin/nologin
gecos: test user

dn: cn=test,ou=Group,ou=System,dc=clx,dc=ath,dc=cx
objectClass: posixGroup
cn: test
gidNumber: 11000
memberUid: test

```

ldapadd コマンドでテストユーザを追加します。


```
# ldapadd -x -D 'cn=Manager,dc=clx,dc=ath,dc=cx' -W -f testuser.ldif

```

# 動作確認  {#u8c899af}
id で /etc/passwd にないユーザ情報を問い合わせてみます。


```
# id test
uid=11000(test) gid=11000(test) groups=11000(test)

```

# PAM の設定  {#kb010e2e}
正常に /etc/nsswitch.conf が編集出来ている事を確認したら PAM の設定を行います。


```
# vi /usr/local/etc/pam.d/system

auth		sufficient	/usr/local/lib/pam_ldap.so	no_warn try_first_pass
account		sufficient	/usr/local/lib/pam_ldap.so
session		optional	/usr/local/lib/pam_ldap.so
password	sufficient	/usr/local/lib/pam_ldap.so	no_warn try_first_pass

```

# 動作確認  {#k5cda2fb}
su で動作確認してみます。


```
# su test
This account is currently not available.
```

