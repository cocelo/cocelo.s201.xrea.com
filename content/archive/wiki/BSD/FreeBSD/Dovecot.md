+++
title = "[PukiWiki:wiki] BSD/FreeBSD/Dovecot"
date = "2008-12-10T09:33:19Z"
+++

# Dovecot Memo  {#t0ad63be}


## Link  {#o56a04d8}
- [Dovecot](http://www.dovecot.org/ "Dovecot")
- [Dovecot Wiki](http://wiki.dovecot.org/ "Dovecot Wiki")
- [Dovecot 翻訳プロジェクト](http://www.dovecot.jp/ "Dovecot 翻訳プロジェクト")

## First Step  {#uf46b9c2}
事前に [pkgtools.conf](/archive/wiki/BSD/FreeBSD/portupgrade/#ue11c464 "pkgtools.conf") の設定をしておくこと。

## Install  {#j5d0bf5c}

```
# portinstall mail/dovecot
# mkdir /var/log/dovecot/

```

## Settings  {#cca4bdb8}

```
# cp /usr/local/etc/dovecot-example.conf /usr/local/etc/dovecot.conf
# chmod 644 /usr/local/etc/dovecot.conf
# vi /usr/local/etc/dovecot.conf

protocols = imap imaps pop3 pop3s

protocol imap {
  listen = *:143
  ssl_listen = *:993
}
protocol pop3 {
  listen = *:110
  ssl_listen = *:995
}

disable_plaintext_auth = yes
shutdown_clients = yes

log_path = /var/log/dovecot/dovecot.log
info_log_path = /var/log/dovecot/dovecot-info.log
log_timestamp = "%b %d %H:%M:%S "
syslog_facility = mail

ssl_listen = mail.clx.ath.cx
ssl_disable = no
ssl_cert_file = /usr/local/etc/ssl/mail.clx.ath.cx/server.crt
ssl_key_file = /usr/local/etc/ssl/mail.clx.ath.cx/server.key
ssl_ca_file = /usr/local/etc/ssl/demoCA/cacrl.pem

mail_location = maildir:~/Maildir

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

