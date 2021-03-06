+++
title = "[PukiWiki:freebsd] FreeBSD/Base/sshd"
date = "2008-10-16T04:12:05Z"
+++


# OpenSSH を有効にする  {#e8a22eca}
インストール時に OpenSSH を有効にしなかった場合は下記のようにして sshd を起動する。


```
# vi /etc/rc.conf

sshd_enable="YES"

# /etc/rc.d/sshd start

```

# 秘密鍵と公開鍵の準備  {#yf170554}
パスワード認証だとブルートフォースアタックを受けた際に破られてしまう恐れがあるので鍵認証方式で遠隔操作します。

## 一般ユーザーで公開鍵と秘密鍵を作成する  {#v6b0563d}
まずは一般ユーザーで公開鍵と秘密鍵を作ります。
root ユーザーで作らないように注意してください。


```
% ssh-keygen
Generating public/private dsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa): (リターン)
Enter passphrase (empty for no passphrase): (パスフレーズを入力)
Enter same passphrase again: (再度同じパスフレーズを入力)
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
The key fingerprint is:
xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx user@local

% mv ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
% chmod 600 ~/.ssh/authorized_keys

```

この作業を行った後、秘密鍵 ( id_rsa ) を遠隔操作するクライアントに安全な方法で移します。

## サーバーに残っている秘密鍵を削除する  {#v53b6cb8}
秘密鍵がいくつもあるのは好ましくないので、サーバーに残っている秘密鍵を削除します。


```
% rm ~/.ssh/id_rsa

```

# サーバの設定  {#sf4cdcde}
上記で鍵認証の為の公開鍵、秘密鍵を作成したので、今度はそれを有効にするためにサーバの設定を変更します。
下記に設定項目の例を晒しておくのでご参考ください。各設定項目の意味は[こちら](http://www.unixuser.org/~euske/doc/openssh/jman/sshd_config.html "こちら")をご覧ください。


```
# vi /etc/ssh/sshd_config

Port 22
Protocol 2
AddressFamily inet
ListenAddress 192.168.1.100

LoginGraceTime 30
PermitRootLogin no
StrictModes yes
MaxAuthTries 3

PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

PasswordAuthentication no
PermitEmptyPasswords no

ChallengeResponseAuthentication no

AllowTcpForwarding no
GatewayPorts no
X11Forwarding no
TCPKeepAlive yes
UseLogin no
UsePrivilegeSeparation yes
PermitUserEnvironment no
Compression delayed
ClientAliveInterval 10
ClientAliveCountMax 6
MaxStartups 2:80:5
PermitTunnel no

AllowUsers user

```

# 再起動  {#h92307f8}
設定や鍵認証等を有効にする為、再起動します。


```
# /etc/rc.d/sshd restart
```

