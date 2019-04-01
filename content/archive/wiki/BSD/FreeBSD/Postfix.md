+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Postfix"
date = "2008-12-10T09:33:19Z"
+++

# Dovecot Memo  {#l1c2cbc0}


## Link  {#p35d141d}
- [The Postfix Home Page](http://www.postfix.org/ "The Postfix Home Page")
- [Postfixのぺーじ](http://www.postfix-jp.info/ "Postfixのぺーじ")

## First Step  {#uf46b9c2}
事前に [pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") の設定をしておくこと。

## Install  {#fa63c6de}

```
# portinstall mail/postfix

    Warning: you still need to edit myorigin/mydestination/mynetworks
    parameter settings in /usr/local/etc/postfix/main.cf.

    See also http://www.postfix.org/STANDARD_CONFIGURATION_README.html
    for information about dialup sites or about sites inside a
    firewalled network.

    BTW: Check your /etc/aliases file and be sure to set up aliases
    that send mail for root and postmaster to a real person, then
    run /usr/local/bin/newaliases.

You need user "postfix" added to group "mail".
Would you like me to add it [y]? Enter
```

そのままエンターキーを押す。


```
Would you like to activate Postfix in /etc/mail/mailer.conf [n]? y
```

ここでは ''y'' キーを押す。


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

# portinstall mail/pflogsumm
# rehash

```

## Setting  {#off1759a}
起動時に postfix を立ち上げる。


```
# vi /etc/rc.conf

postfix_enable="YES"

```

buildworld 時に sendmail を作り直さない。


```
# vi /etc/make.conf

NO_SENDMAIL=true

```

sendmail を起動時に立ち上げない。


```
# vi /etc/rc.conf

sendmail_enable="NO"
sendmail_submit_enable="NO"
sendmail_outbound_enable="NO"
sendmail_msp_queue_enable="NO"

```

periodic daily でエラーが出るので該当箇所を無効に。


```
# vi /etc/periodic.conf

daily_clean_hoststat_enable="NO"
daily_status_mail_rejects_enable="NO"
daily_status_include_submit_mailq="NO"
daily_submit_queuerun="NO"

```

postfix の設定。


```
# vi /usr/local/etc/postfix/main.cf

default_privs = nobody
myhostname = s1.clx.ath.cx
mydomain = clx.ath.cx
myorigin = $mydomain
inet_interfaces = all
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
unknown_local_recipient_reject_code = 550
mynetworks = 192.168.1.0/24, 127.0.0.0/8
alias_maps = hash:/etc/aliases
alias_database = hash:/etc/aliases
home_mailbox = Maildir/
header_checks = regexp:/usr/local/etc/postfix/header_checks
smtpd_banner = smtp.$mydomain ESMTP $mail_name

# SMTP AUTH ( Dovecot SASL ) の設定。
smtpd_sasl_auth_enable = yes
smtpd_sasl_local_domain = $mydomain
smtpd_sasl_security_options = noanonymous
broken_sasl_auth_clients = yes

# smtpd_sasl_type はデフォルトで設定されている模様。
# しかし smtpd_sasl_path が smtpd に設定されている。
# なので一応設定しておいた方が良い？
smtpd_sasl_type = dovecot
smtpd_sasl_path = private/auth

# TLS の設定。
smtpd_use_tls = yes
smtpd_tls_cert_file = /usr/local/etc/ssl/clx.ath.cx/server.crt
smtpd_tls_key_file = /usr/local/etc/ssl/clx.ath.cx/server.key
smtpd_tls_session_cache_database = btree:/usr/local/etc/postfix/smtpd_scache

# mynetworks 、 SASL 認証を通らなかったものは破棄
smtpd_recipient_restrictions = permit_mynetworks, \
	permit_sasl_authenticated, reject_unauth_destination

```

smtps(465) と submission(587) を使えるように。


```
# vi /usr/local/etc/postfix/master.cf

smtps     inet  n       -       n       -       -       smtpd
  -o smtpd_tls_wrappermode=yes
  -o smtpd_sasl_auth_enable=yes
#  -o smtpd_client_restrictions=permit_sasl_authenticated,reject

```

ヘッダの書き換え。


```
# vi /usr/local/etc/postfix/header_checks

/^Received:.*192\.168\..*/ IGNORE
/^Received:.*127\.0\.0\.1.*/ IGNORE

```

設定の確認。


```
# postfix check

```

起動。


```
# posftix start

```

aliases DB を作成し直す。


```
# newaliases
```

