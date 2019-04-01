+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/System/Puppet"
date = "2008-11-25T09:25:07Z"
+++


# はじめに  {#taf33307}

example.comは各自のドメインに置き換えてご覧下さい。
また、Subversionを使用してデータファイルの管理を行うので予めSubversionを導入しておいて下さい。

# インストール  {#o246733e}


```
$ sudo portinstall sysutils/puppet
```

# 初期設定  {#c510bf1d}

## rc スクリプトの有効化  {#ec272c77}


```
$ sudo sh -c 'printf "\n# puppet server" >> /etc/rc.conf'
$ sudo sh -c 'printf "\npuppetmasterd_enable=\"YES\"" >> /etc/rc.conf'
$ sudo sh -c 'printf "\n# puppet client" >> /etc/rc.conf'
$ sudo sh -c 'printf "\npuppetd_enable=\"YES\"" >> /etc/rc.conf'
```

## 受け入れ先ホストの設定  {#f14373d8}


```
$ sudo touch /usr/local/etc/puppet/namespaceauth.conf
$ sudoedit /usr/local/etc/puppet/namespaceauth.conf
```


```
# server side
[puppetmaster]
    allow *.example.com

[puppetreports]
    allow *.example.com

[fileserver]
    allow *.example.com

# client side
[puppetrunner]
    allow *.example.com
```

## 自動署名ホストの設定  {#jd1dc2c6}


```
$ sudo touch /usr/local/etc/puppet/autosign.conf
$ sudoedit /usr/local/etc/puppet/autosign.conf
```


```
*.example.com
```

# マニフェストの定義  {#j315dc72}

## ルートマニフェストファイル  {#e9adc858}


```
$ sudo touch /usr/local/etc/puppet/manifests/site.pp
$ sudoedit /usr/local/etc/puppet/manifests/site.pp
```


```
# $Id$
#
# Puppet Manifests

# FreeBSD Class
class freebsd {
  import "freebsd/*"
  package { portaudit: ensure => present, provider => freebsd }
}

case $operatingsystem {
    freebsd: { freebsd {} } # # apply the solaris class
}
```

# マスターサーバの起動  {#jf24a84a}


```
$ sudo /usr/local/etc/rc.d/puppetmasterd start
```

# 接続テスト  {#m6d05958}

試しに/etc/hostsのパーミッションを600にして接続してみる。


```
$ sudo chmod 600 /etc/hosts
$ sudo puppetd --server puppetmaster.example.com --verbose --test
```


```
notice: Ignoring --listen on onetime run
notice: Ignoring cache
info: No classes to store
info: Caching catalog at /var/puppet/state/localconfig.yaml
notice: Starting catalog run
notice: //File[/etc/hosts]/mode: mode changed '600' to '644'
Changes:
            Total: 1
Resources:
          Applied: 1
      Out of sync: 1
        Scheduled: 9
            Total: 10
Time:
   Config retrieval: 0.57
             File: 0.00
       Filebucket: 0.00
         Schedule: 0.00
            Total: 0.58
notice: Finished catalog run in 0.02 seconds
```

以下のようにパーミッションを変更した旨が出力されていれば成功。


```
notice: //File[/etc/hosts]/mode: mode changed '600' to '644'
```

# Tips  {#b5af7f43}

## vimのヘルパーモードを有効にする  {#ac57947b}


```
$ mkdir -p ${HOME}/.vim/plugin/
$ cd ${HOME}/.vim/
$ fetch https://reductivelabs.com/svn/puppet/trunk/ext/vim/filetype.vim
$ cd ${HOME}/.vim/plugin/
$ fetch https://reductivelabs.com/svn/puppet/trunk/ext/vim/puppet.vim
```

この他にも以下のSubversionリポジトリから便利なツール類がダウンロード出来る。
https://reductivelabs.com/svn/puppet/trunk/ext/

# 参考リンク  {#ke65a57c}
[puppet - Trac](http://reductivelabs.com/trac/puppet/ "puppet - Trac")
[Puppet FreeBSD - puppet - Trac](http://reductivelabs.com/trac/puppet/wiki/PuppetFreeBSD "Puppet FreeBSD - puppet - Trac")
[連載：オープンソースなシステム自動管理ツール Puppet｜gihyo.jp … 技術評論社](http://gihyo.jp/admin/serial/01/puppet "連載：オープンソースなシステム自動管理ツール Puppet｜gihyo.jp … 技術評論社")
[puppet wiki （パペウィキ） - Trac](http://trac.mizzy.org/puppet "puppet wiki （パペウィキ） - Trac")
[OSC2007](http://dev.gentoo.gr.jp/%7Etrombik/pub/OSC2007/ "OSC2007")
[ネットワーク上でのシステム管理を容易にするPuppet - SourceForge.JP Magazine](http://sourceforge.jp/magazine/08/08/21/0210246 "ネットワーク上でのシステム管理を容易にするPuppet - SourceForge.JP Magazine")
[Puppet - nabeken - Trac](http://projects.tsuntsun.net/~nabeken/Puppet.html "Puppet - nabeken - Trac")
