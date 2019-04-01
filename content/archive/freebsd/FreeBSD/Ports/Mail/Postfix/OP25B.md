+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail/Postfix/OP25B"
date = "2009-11-09T21:39:58Z"
+++


# OP25B 対策とは？  {#naf9bde4}
OP25B とは昨今増えている迷惑メールに対する対策のひとつで、主にプロバイダが導入しているものです。

[WikiPedia.ja:Outbound Port 25 Blocking](https://ja.wikipedia.org/wiki/Outbound_Port_25_Blocking "WikiPedia.ja:Outbound Port 25 Blocking")

固定 IP アドレスなどでサーバを運用している場合は影響を受けませんが、動的 IP アドレスで運用している場合、 OP25B に引っかかる事があります。
今回は Postfix での OP25B 対策について書いていきます。

# プロバイダの SMTP サーバに接続して認証方式を調べる  {#l355a1a7}
まずは Submission Port ( 587 ) でプロバイダの SMTP サーバに接続して、どの認証方式に対応しているのか調べます。


```
# telnet プロバイダの SMTP サーバ 587
Trying ***.***.***.***...
Connected to mail.example.com.
Escape character is '^]'.
220 mail.example.com ESMTP
```

上記のような表示になった後、何も表示されなくなりますが、以下のように入力すればサーバとの通信が再開します。


```
EHLO example.com
mail.example.com Hello example.net [***.***.***.***], pleased to meet you
250-ENHANCEDSTATUSCODES
250-PIPELINING
250-8BITMIME
250-SIZE 10240000
250-DSN
250-AUTH LOGIN PLAIN ← ここがプロバイダのサポートしている認証方式
250-STARTTLS
250-DELIVERBY
250 HELP
```

この SMTP サーバがサポートしている認証方式は LOGIN, PLAIN ということになります。
最後に QUIT と入力すれば接続が終了します。


```
QUIT
221 2.0.0 mail.example.com closing connection
Connection closed by foreign host.
```

# Postfix の設定  {#c22671d8}
次に Postfix の設定ですが、今回は認証方式として LOGIN, PLAIN をターゲットとして進めます。


```
# vi /usr/local/etc/postfix/main.cf
```


```
relayhost = [プロバイダの SMTP サーバ]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/usr/local/etc/postfix/isp_passwd
smtp_sasl_mechanism_filter = login, plain # プロバイダが提供している認証方式
smtp_sasl_security_options = noanonymous
```

プロバイダの SMTP サーバに接続するために、接続情報を記述したファイルを作成します。


```
# vi /usr/local/etc/postfix/isp_passwd
```


```
# [プロバイダの SMTP サーバ]:587 アカウント名:パスワード
```

上記で作成したファイルを postmap でデータベース化、権限を落として一般ユーザに見られないようにします。


```
# postmap /usr/local/etc/postfix/isp_passwd
# chmod 640 /usr/local/etc/postfix/isp_passwd
```

最後に Postfix を再起動して設定は完了です。


```
# /usr/local/etc/rc.d/postfix restart
```

# メールの配信テスト  {#z0905908}
最後に正常に配信されるか、テストメールを配信してみましょう。


```
# echo test | mail メールアドレス
```

上記のメールアドレス宛に test とだけ記入されているメールが届けば完了です。
