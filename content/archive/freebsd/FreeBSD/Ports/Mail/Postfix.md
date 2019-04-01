+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail/Postfix"
date = "2009-11-09T21:06:49Z"
+++


# SMTP サーバーの構築  {#sace24d6}
まずは Postfix を利用した SMTP サーバーの構築から行います。
また、このドキュメントは jail 環境下での解説になります。

# インストール  {#m194cb25}
Ports からインストールします。

## Perl のインストール  {#l0bc62ef}
まずは Perl 5.8 のインストールから行います。


```
# cd /usr/ports/lang/perl5.8
# make WITHOUT_USE_PERL=yes install clean

```

## iconv のインストール  {#bc770378}
Dovecot が libiconv を要求するので、まずは libiconv のインストールから行います。


```
# cd /usr/ports/converters/libiconv
# make -DBATCH WITH_EXTRA_PATCHES=yes install clean

```

## Dovecot のインストール  {#yd1cb0ae}
SMTP-AUTH に Dovecot の認証システムを採用する ( Cyrus SASL ではありません ) ので Postfix をインストールする前に Dovecot をインストールしておきます。


```
# cd /usr/ports/mail/dovecot
# make -DBATCH WITHOUT_IPV6=yes WITH_LDAP=yes WITH_MYSQL=yes WITH_SQLITE=yes install clean

```

## Postfix のインストール  {#de144a30}
最後に Postfix をインストールします。


```
# cd /usr/ports/mail/postfix
# make -DBATCH WITH_SASL2=yes WITH_DOVECOT=yes WITH_TLS=yes WITH_BDB=yes WITH_MYSQL=yes WITH_OPENLDAP=yes WITH_VDA=yes WITH_TEST=yes install clean

```

### 注意事項  {#gf26cc5a}
インストール中に、ある程度すると下記の注意事項が出力されます。
myorigin / mydestination / mynetworks の設定を変えること、公式 HP の [標準設定の例](http://www.postfix.org/STANDARD_CONFIGURATION_README.html "標準設定の例") ( [日本語訳](http://www.postfix-jp.info/trans-2.3/jhtml/STANDARD_CONFIGURATION_README.html "日本語訳") )に目を通すこと、メールの配送設定 ( /etc/aliases ) をチェックし newaliases. を実行すること、などが書かれています。


```
    Warning: you still need to edit myorigin/mydestination/mynetworks
    parameter settings in /usr/local/etc/postfix/main.cf.

    See also http://www.postfix.org/STANDARD_CONFIGURATION_README.html
    for information about dialup sites or about sites inside a
    firewalled network.

    BTW: Check your /etc/aliases file and be sure to set up aliases
    that send mail for root and postmaster to a real person, then
    run /usr/local/bin/newaliases.

```

### ユーザーとグループの作成  {#c6a107b1}
そしてまた暫くたつと下記のようなメッセージが出ます。


```
You need user "postfix" added to group "mail".
Would you like me to add it [y]? Enter

```

これは postfix:mail という、ユーザーとグループを作成してよいか？と尋ねています。
ここはエンターを押します。

### mailer.conf を Postfix 用の設定に書き換える  {#m938736c}
次は下記のようなメッセージが出ます。


```
Would you like to activate Postfix in /etc/mail/mailer.conf [n]? y

```

これは mailer.conf を Postfix 用の設定に書き換えても良いか？と尋ねています。
sendmail を使う予定が無い場合は ''y'' を押しましょう。

### インストール後にする設定  {#k98c941d}
最後にインストール後に行う設定のインフォメーションが表示されます。


```
To enable postfix startup script please add postfix_enable="YES" in your rc.conf

If you not need sendmail anymore, please add in your rc.conf:

sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"

And you can disable some sendmail specific daily maintenance routines in your
/etc/periodic.conf file:

daily_clean_hoststat_enable="NO"
daily_status_mail_rejects_enable="NO"
daily_status_include_submit_mailq="NO"
daily_submit_queuerun="NO"

If you are using SASL, you need to make sure that postfix has access to read
the sasldb file.  This is accomplished by adding postfix to group mail and
making the /usr/local/etc/sasldb* file(s) readable by group mail (this should
be the default for new installs).

```

通常ならこの通り設定すればまず間違いはないでしょう。

# コマンドの有効化  {#v0fd95d2}
インストールされたコマンドを有効にします。


```
# rehash

```

# 自動起動  {#ha833e1d}
ホスト起動時に自動的に Postfix が立ち上がるように rc.conf に設定します。


```
# vi /etc/rc.conf

postfix_enable="YES"
dovecot_enable="YES"

```

# Dovecot SASL の設定  {#nc926397}
Dovecot SASL を使用するので、 Dovecot の認証プロセスのみを立ち上げます。


```
# vi /usr/local/etc/dovecot.conf

protocols = none

ssl_disable = yes

auth default {
  mechanisms = plain login
  passdb pam {
  }
  userdb passwd {
  }
  socket listen {
    client {
      path = /var/spool/postfix/private/auth
      mode = 0660
      user = postfix
      group = postfix
    }
  }
}

```

# Dovecot の起動  {#f86bca0f}
Dovecot を起動します。


```
# /usr/local/etc/rc.d/dovecot start

```

# sendmail の自動起動を無効にする  {#k1db635f}
Postfix をインストールした場合、 sendmail は使わなくなると思いますので、まずはこれを無効にします。


```
# vi /etc/rc.conf

sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"

```

# sendmail の periodic daily を無効にする  {#sc4785a9}
上記項目で sendmail を無効にした場合は periodic daily でエラーが出ます。
なので該当する設定を無効にします。


```
# vi /etc/periodic.conf

daily_clean_hoststat_enable="NO"
daily_status_mail_rejects_enable="NO"
daily_status_include_submit_mailq="NO"
daily_submit_queuerun="NO"

```

# mailer.conf の設定  {#sa6fe02d}
インストール時に mailer.conf の設定を行わなかった場合は mailer.conf の設定を行います。


```
# vi /etc/mail/mailer.conf

#
# Execute the Postfix sendmail program, named /usr/local/sbin/sendmail
#
sendmail	/usr/local/sbin/sendmail
send-mail	/usr/local/sbin/sendmail
mailq		/usr/local/sbin/sendmail
newaliases	/usr/local/sbin/sendmail

```

# {build,install}world で mailer.conf を置き換えない  {#m0029de4}
newaliases や mailq などは FreeBSD インストール直後の状態では sendmail のものが使われます。
Postfix 付属の newaliases や mailq を使用する場合は {build,install}world で mailer.conf が置き換わらないようにします。


```
# vi /etc/make.conf

NO_SENDMAIL=YES

```

# main.cf の編集  {#m23427c3}
以下は変更した箇所のみを抽出して掲載しています。


```
# vi /usr/local/etc/postfix/main.cf

```

## 基本的な設定  {#i8b021f6}
下記にある設定は TLS や SASL のオプションに関わらず設定してください。

- ホスト名

```
#myhostname = host.domain.tld
#myhostname = virtual.domain.tld
myhostname = smtp.clx.ath.cx

```

- ドメイン名

```
#mydomain = domain.tld
mydomain = clx.ath.cx

```

- ローカルから送信された場合のドメイン名がどのドメインから来たか

```
#myorigin = $myhostname
#myorigin = $mydomain
myorigin = $mydomain

```

- 自分自身が最終的な目的地だとみなすドメインのリスト

```
#mydestination = $myhostname, localhost.$mydomain, localhost
#mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
#mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain,
#       mail.$mydomain, www.$mydomain, ftp.$mydomain
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

```

- メール中継を許可するクライアント

```
#mynetworks = 168.100.189.0/28, 127.0.0.0/8
#mynetworks = $config_directory/mynetworks
#mynetworks = hash:/usr/local/etc/postfix/network_table
mynetworks = 192.168.1.0/24, 127.0.0.1/32

```

- aliases マップの設定

```
#alias_maps = dbm:/etc/aliases
#alias_maps = hash:/etc/aliases
#alias_maps = hash:/etc/aliases, nis:mail.aliases
#alias_maps = netinfo:/aliases
alias_maps = hash:/etc/mail/aliases

```

- aliases データベースの設定

```
#alias_database = dbm:/etc/aliases
#alias_database = dbm:/etc/mail/aliases
#alias_database = hash:/etc/aliases
#alias_database = hash:/etc/aliases, hash:/opt/majordomo/aliases
alias_database = hash:/etc/mail/aliases

```

- mailbox ではなく Maildir を使用するように

```
#home_mailbox = Mailbox
#home_mailbox = Maildir/
home_mailbox = Maildir/

```

## SMTP-AUTH の設定  {#h93940d1}
SMTP-AUTH に Dovecot SASL を採用した場合の設定です。
Cyrus SASL を採用する場合はこの限りではありません。


```
#
# SASL AUTHENTICATION CONTROLS
#
smtpd_sasl_auth_enable = yes
smtpd_sasl_local_domain = $mydomain
smtpd_sasl_security_options = noanonymous
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth
smtpd_recipient_restrictions =
	permit_mynetworks
	permit_sasl_authenticated
	reject_unauth_destination
broken_sasl_auth_clients = yes

```

## TLS の設定  {#t2c33d88}
自己認証局を立てて証明書を発行した場合は下記のようになります。
公に認められている認証局から証明書を発行してもらった場合はこの限りではありません。


```
#
# STARTTLS SUPPORT CONTROLS
#
smtpd_tls_cert_file = /usr/local/etc/postfix/server.key.cert
smtpd_tls_CAfile = /usr/local/etc/postfix/ca.cert
smtpd_tls_loglevel = 1
smtpd_tls_security_level = may
smtpd_tls_session_cache_database = btree:/var/spool/postfix/smtpd_scache
smtpd_tls_mandatory_ciphers = export
smtpd_tls_dh1024_param_file = /usr/local/etc/postfix/dh_1024.pem
smtpd_tls_dh512_param_file = /usr/local/etc/postfix/dh_512.pem
smtpd_tls_always_issue_session_ids = no
tls_random_source = /dev/random

```

# smtps を有効にする  {#d2c018b0}
smtps を有効にすれば smtps に接続された時に全て暗号化された通信になります。


```
# vi /usr/local/etc/postfix/master.cf

smtp      inet  n       -       n       -       -       smtpd
#submission inet n       -       n       -       -       smtpd
#  -o smtpd_enforce_tls=yes
#  -o smtpd_sasl_auth_enable=yes
#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject
smtps     inet  n       -       n       -       -       smtpd
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
  -o smtpd_client_restrictions=permit_sasl_authenticated,reject

```

# 設定ファイルの確認  {#d787cfd8}
設定ファイルに記述ミスがないかどうかチェックします。


```
# /usr/local/sbin/postfix check

```

# alias database の再生成  {#o4687974}
sendmail の時に使っていた alias database を再生成します。


```
# /usr/local/sbin/postalias /etc/mail/aliases

```

# sendmail を停止  {#he792deb}
通常なら sendmail が起動しているので、 sendmail を停止する。


```
# /etc/rc.d/sendmail stop

```

# 起動  {#w3e5813a}
Postfix を起動します。


```
# /usr/local/etc/rc.d/postfix start

```

# リンク  {#f8b4399c}
[The Postfix Home Page](http://www.postfix.org/ "The Postfix Home Page")
[Postfixのぺーじ](http://www.postfix-jp.info/ "Postfixのぺーじ")
