+++
title = "[PukiWiki:wiki] BSD/FreeBSD/OpenSSH"
date = "2008-12-10T09:33:19Z"
+++

# SSH Memo  {#wd2c2b1c}


## First Session  {#w15e0240}
インストール時にsshdの自動起動設定をNoにした場合。

```
# vi /etc/rc.conf

sshd_enable="YES"

# /etc/rc.d/sshd start

```

一般ユーザーで認証鍵の作成。

```
% ssh-keygen -t dsa
Generating public/private dsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_dsa): (リターン)
Enter passphrase (empty for no passphrase): (パスフレーズを入力)
Enter same passphrase again: (再度同じパスフレーズを入力)
Your identification has been saved in /home/user/.ssh/id_dsa.
Your public key has been saved in /home/user/.ssh/id_dsa.pub.
The key fingerprint is:
xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx user@local

% cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys
% chmod 600 ~/.ssh/authorized_keys
```

ここで一旦秘密鍵 ( ~/.ssh/id_dsa ) の内容を安全な方法で作業コンピュータにコピーする。

その後、サーバに残ってる秘密鍵を削除する。

```
% rm ~/.ssh/id_dsa

```

## Setting  {#qc2224f5}


```
# vi /etc/ssh/sshd_config

Port 22
Protocol 2
AddressFamily inet
ListenAddress 192.168.1.100

PermitRootLogin no

PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys

PasswordAuthentication no
PermitEmptyPasswords no

ChallengeResponseAuthentication no

AllowUsers user

# /etc/rc.d/sshd restart

```

## Memo  {#a15067bf}
こんな所かな。

## Link  {#qc47c415}
[Masashi Blog » FreeBSD \(sshd & hosts.allow\)](http://blog.masashi.org/archives/238 "Masashi Blog » FreeBSD \(sshd & hosts.allow\)")
