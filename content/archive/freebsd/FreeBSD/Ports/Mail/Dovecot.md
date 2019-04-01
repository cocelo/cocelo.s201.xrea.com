+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail/Dovecot"
date = "2008-10-16T04:12:09Z"
+++


# POP3 IMAP サーバーの構築  {#s7cd4fc7}
ここでは Dovecot で POP3 IMAP サーバーの構築を構築します。

# インストール  {#dff822d0}
まずはインストールからです。
通常なら Postfix を導入した際に一緒にインストールされていると思います。


```
% sudo portinstall mail/dovecot

```

しばらくすると下記のメッセージが表示されます。


```
 You can get basic IMAP and POP3 services running by enabling
 dovecot in /etc/rc.conf.

 In this basic configuration Dovecot will authenticate users against
 the system's passwd file and use the default /var/mail/$USER mbox
 files.

  echo dovecot_enable="YES" >> /etc/rc.conf

```

# 自動起動の設定  {#p30bf5a5}
まずは自動起動の設定を行います。


```
% sudo vi /etc/rc.conf

dovecot_enable="YES"

```

# 設定ファイルのコピー  {#y88a1a2c}
設定ファイルをコピー、権限を変更します。


```
# sudo cp /usr/local/etc/dovecot-example.conf /usr/local/etc/dovecot.conf
# sudo chmod 644 /usr/local/etc/dovecot.conf

```

# dovecot.conf の編集  {#k634f5b3}
Postfix と同様、設定項目が多いので簡単な説明を交えながら設定していきます。


```
% sudo vi /usr/local/etc/dovecot.conf

```

使用するプロトコル

```
#protocols = imap imaps
#protocols = imap pop3
protocols = imap imaps pop3 pop3s

```

使用するポート

```
protocol imap {
  listen = *:143
  ssl_listen = *:993
}
protocol pop3 {
  listen = *:110
  ssl_listen = *:995
}

```

LOGIN を許可する

```
#disable_plaintext_auth = yes
disable_plaintext_auth = no

```

SSL 接続するホスト

```
#ssl_listen =
ssl_listen = mail.clx.ath.cx

```

鍵ファイル

```
#ssl_cert_file = /etc/ssl/certs/dovecot.pem
#ssl_key_file = /etc/ssl/private/dovecot.pem
ssl_cert_file = /usr/local/etc/ssl/mail.clx.ath.cx/server.cert
ssl_key_file = /usr/local/etc/ssl/mail.clx.ath.cx/server.key

```

CRL に対応した認証局の CRL ファイルの指定

```
#ssl_ca_file =
ssl_ca_file = /usr/local/etc/ssl/CA/ca.cert

```

Maildir の指定

```
#mail_location =
#mail_location = mbox:~/mail/:INBOX=/var/mail/%u
mail_location = maildir:~/Maildir

```

Dovecot SASL の設定

```
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

# 起動  {#ve076396}
全て問題が無ければ起動します。


```
% sudo /usr/local/etc/rc.d/dovecot start

```

# mb2md インストール  {#x2748277}
mb2md は mbox に保存されているデータを Maildir 形式に変換するソフトウェアです。


```
% sudo portinstall mail/mb2md
% rehash

```

## spool 内のメールを変換 ( ユーザ毎に実行する )  {#a4e452dd}


```
% mb2md -m

```

## mbox を Maildir 変換 ( ユーザ毎に実行する )  {#ve60f25e}


```
% mb2md -s mbox
```

