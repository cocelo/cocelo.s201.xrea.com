+++
title = "[PukiWiki:freebsd] FreeBSD/Tips/sendmail"
date = "2008-10-16T04:12:14Z"
+++


# sendmail で IPv6 を無効にする  {#o672a307}
カーネルで IPv6 を無効にした場合は sendmail でも IPv6 を無効にしないとエラーが出てしまう。
なので、下記のように該当箇所をコメントアウトする。


```
% sudo vi /etc/mail/sendmail.cf

#O DaemonPortOptions=Name=IPv6, Family=inet6, Modifiers=O

```

# local-host-names を設定する  {#k7a9ef6c}
sendmail はインストール直後の状態でもローカルアドレス宛にメールを配送してくれない場合があります。
そういった時に local-host-names を設定すれば、ローカルアドレス宛に正しく配送されます。


```
% sudo vi /etc/mail/local-host-names

s1.clx.ath.cx

```

設定を反映する為に sendmail を再起動します。


```
% sudo /etc/rc.d/sendmail restart
```

