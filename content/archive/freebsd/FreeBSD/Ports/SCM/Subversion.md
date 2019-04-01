+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/SCM/Subversion"
date = "2008-11-17T12:46:49Z"
+++


# Subversionでバージョン管理  {#ec3c617c}
Subversionというソフトウェアをご存知でしょうか？
これはバージョン管理システムの実装の一つで、バージョン管理システムとして最も普及しているソフトウェアです。

# はじめに  {#b8ebb77c}
リポジトリのアクセス方法はネットワーク経由の場合、svnserveを直接起動する方法、ApacheのWebDAVを用いた方法、SSH経由でsvnserveを利用する方法と三種類存在します。
セキュリティの観念から今回はApacheのWebDAVを用いた方法、SSH経由でsvnserveを利用する方法の二種類を解説します。
また、SSH経由の場合はApacheをインストールする必要がないので、各自の環境と照らし合せた上でご覧下さい。

# ApacheのWebDAV経由で利用する場合  {#je56b7eb}
ApacheのWebDAV経由でリポジトリを操作する場合はdevel/aprとwww/apacheをインストールしてください。
注意しなければならない点は、devel/aprはBDB(Berkeley DB)サポート付でインストールしなければならない事です。
また、Ports Collectionにはdevel/apr-svnというMeta Ports(特定のオプションを有効にしたり、パッチを当てるPortsの事)がありますので、そちらを利用しても構いません。

# Subversionのインストール  {#z14dfb06}
Subversionのインストール時に注意する点は、ApacheのWebDAVを利用する場合と、利用しない場合ではオプションが異なる点です。

## ApacheのWebDAV経由でリポジトリにアクセスする場合  {#b907675e}


```
$ cd /usr/ports/devel/subversion
$ sudo make WITH_APACHE2_APR=yes WITH_MOD_DAV_SVN=yes WITH_SVNSERVE_WRAPPER=yes WITH_BDB=yes install clean
```

インストールが終わったらhttpd.confにdav_moduleが二つ記述されていないかチェックしてください。


```
$ grep dav_module /usr/local/etc/apache22/httpd.conf
LoadModule dav_module libexec/apache22/mod_dav.so
LoadModule dav_module         libexec/apache22/mod_dav.so
```

上記のように、二行出力された場合は以下のようにして後ろの一行をコメントアウトしてください。一行だけでしたら問題ありません。


```
$ sudoedit /usr/local/etc/apache22/httpd.conf
```


```
LoadModule dav_module libexec/apache22/mod_dav.so
#LoadModule dav_module         libexec/apache22/mod_dav.so
```

修正が終わったらApacheを再起動します。


```
$ sudo /usr/local/etc/rc.d/apache restart
```

## SSH経由のみでリポジトリにアクセスする場合  {#b417eec5}


```
$ cd /usr/ports/devel/subversion
$ sudo make WITH_SVNSERVE_WRAPPER=yes WITH_BDB=yes install clean
```

# 練習用リポジトリの作成  {#j0d1cf45}
まずは練習用のリポジトリを作成しましょう。
今回は/home/svn/repos以下にリポジトリを作成していきます。


```
$ sudo mkdir -p /home/svn/repos
$ sudo svnadmin create /home/svn/repos/sandbox
```

正常に作成されたらsvn専用のユーザとグループを作成します。


```
$ sudo pw groupadd -n svn
$ sudo pw useradd -n svn -c "Subversion Comit User" -d /home/svn -g svn -h - -s /bin/sh
```

リポジトリの所有者を変更します。


```
$ sudo chown -R svn:svn /home/svn/repos/sandbox/db
$ sudo chown -R svn:svn /home/svn/repos/sandbox/locks
$ sudo chown root:wheel /home/svn/repos/sandbox/db/fs-type
$ sudo chown root:wheel /home/svn/repos/sandbox/db/uuid
```

リポジトリのパーミッションを変更します。


```
$ sudo chmod -R g+w /home/svn/repos/sandbox/db
$ sudo chmod -R g+w /home/svn/repos/sandbox/locks
$ sudo chmod g-w /home/svn/repos/sandbox/db/fs-type
$ sudo chmod g-w /home/svn/repos/sandbox/db/uuid
```

ここからApacheのWebDAV経由とSSH経由で作業内容が異なります。
各自の環境と照らし合せてご覧下さい。

# ApacheのWebDAV経由でリポジトリにアクセスする場合  {#d46c48be}
svnグループにApacheを動かしているユーザを追加します。通常はwwwになります。


```
% sudo pw groupmod svn -M www

```

次にWebDAVでアクセスした時に必要になるディレクトリを作成します。


```
% sudo mkdir /home/svn/repos/sandbox/dav
% sudo chown svn:svn /home/svn/repos/sandbox/dav
% sudo chmod g+w /home/svn/repos/sandbox/dav

```

次にWeb上からリポジトリにアクセス出来るようにhttpd.confを編集します。


```
% sudoedit /usr/local/etc/apache22/Includes/subversion.conf

```


```
<Location /svn>
   DAV svn
   SVNParentPath /home/svn/repos
   SVNListParentPath On
</Location>
```

Apacheを再起動します。


```
% sudo /usr/local/etc/rc.d/apache22 restart

```

# SSH経由でリポジトリにアクセスする場合  {#uf934860}
SSH経由で利用する場合はsvnユーザのホームディレクトリに.sshディレクトリを作成します。


```
% sudo mkdir /home/svn/.ssh
% sudo chmod 700 /home/svn/.ssh
% sudo chown svn:svn /home/svn/.ssh

```

次に秘密鍵と公開鍵を作成します。


```
% ssh-keygen -t rsa -b 2048
```


```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa): /home/user/.ssh/svn_rsa
Enter passphrase (empty for no passphrase):パスフレーズを入力
Enter same passphrase again:パスフレーズを入力
Your identification has been saved in /home/user/.ssh/svn_rsa.
Your public key has been saved in /home/user/.ssh/svn_rsa.pub.
The key fingerprint is:
**:**:**:**:**:**:**:**:**:**:**:**:**:**:**:** user@example.com
The key's randomart image is:
+--[ RSA 2048]----+
|           o o   |
|          o = +  |
|         . = * . |
|          + = o .|
|        S  o .Eo.|
|         .    .oo|
|        . .   . o|
|         o   . . |
|          ...o+  |
+-----------------+
```

次に先ほど作成した公開鍵をsvnユーザのホームディレクトリにコピーします。


```
% cd ~
% sudo cp .ssh/svn_rsa.pub /home/svn/.ssh/authorized_keys
% sudo chmod 600 /home/svn/.ssh/authorized_keys
% sudo chown svn:svn /home/svn/.ssh/authorized_keys

```

次にコピーした公開鍵を編集して、svnserve以外を利用できないようにします。
これはセキュリティの観点からみてとても重要で、対話的シェルを起動させない為にも必ず編集してください。

まずはファイルを開くと以下のようにずらーっと文字列が続いていると思います。


```
% sudo cat /home/svn/.ssh/authorized_keys
ssh-rsa AAAABBBB...文字列....123456789== user@example.com

```

上記の**ssh-rsa**の前に以下のようにして追記します。
実際は一行ですので注意して下さい。


```
command="svnserve -t --tunnel-user=コミットユーザ名 -r /home/svn/repos"
,no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAA....文字列....123456789== user@examle.com

```

/etc/ssh/sshd_configでAllowUsersかAllowGroupを設定している場合はsvnユーザを追加して下さい。
以下の場合はAllowGroupsを設定している場合です。


```
% grep AllowGroups /etc/ssh/sshd_config

AllowGroups wheel

% sudoedit /etc/ssh/sshd_config

AllowGroups wheel svn

```

sshdを再起動します。


```
# /etc/rc.d/sshd restart

```

# チェックアウト  {#k254692e}
これでようやくリポジトリにアクセスできるようになります。
Apache経由ならhttp://サーバのアドレス/svn/sandboxでリポジトリをチェックアウト出来ます。
SSH経由ならsvn+ssh://svn@サーバのアドレス/sandboxでチェックアウト出来ます。

# 参考リンク  {#i25cf138}
- [WikiPedia.ja:Subversion](https://ja.wikipedia.org/wiki/Subversion "WikiPedia.ja:Subversion")
- [Subversion Manual](http://subversion.bluegate.org/doc/ "Subversion Manual")
- [TortoiseSVN Manual](http://tortoisesvn.net/docs/release/TortoiseSVN_ja/ "TortoiseSVN Manual")
