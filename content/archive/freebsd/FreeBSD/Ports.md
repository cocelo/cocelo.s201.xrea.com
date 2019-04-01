+++
title = "[PukiWiki:freebsd] FreeBSD/Ports"
date = "2008-10-16T04:12:06Z"
+++


# Ports Collection について  {#e6e00435}
Ports Collection は通常 ports と言われ、ソフトウェアの依存関係を解決してくれる素晴らしいものです。
イメージとしては Linux ディストリビュージョンの Debian などで採用されている apt-get と似たようなものです。
異なる点としては全てソースコードからコンパイルし直すので、自分にあった環境を構築できます。

ピンと来ない方の為に説明すると、例えば Apache 2.2 をコンパイルするには libtool と autoconf が必要になりますが、これらのソフトウェアを特に何も指定しなくても自動で依存関係を解決してインストールしてくれる。こんな感じです。

# ports の導入と更新  {#v283f8dd}
ports の更新は最近では cvsup ではなく portsnap が用いられる事が多くなりました。
更新の際には SSL で通信が暗号化されているなどの利点があります。

[portsnap の導入](/archive/freebsd/FreeBSD/Base/portsnap/ "portsnap の導入")

# 検索の仕方  {#u88028e5}

```
# whereis zsh
zsh: /usr/ports/shells/zsh
```


```
# cd /usr/ports
# make search name=zsh
Port:   zsh-4.3.9_5
Path:   /usr/ports/shells/zsh
Info:   The Z shell
Maint:  des@FreeBSD.org
B-deps: autoconf-2.62 autoconf-wrapper-20071109 libiconv-1.11_1 m4-1.4.12,1 perl-5.8.9_2
R-deps: libiconv-1.11_1
WWW:    http://www.zsh.org/
```


```
# cd /usr/ports
# make search key=zsh
Port:   zsh-4.3.9_5
Path:   /usr/ports/shells/zsh
Info:   The Z shell
Maint:  des@FreeBSD.org
B-deps: autoconf-2.62 autoconf-wrapper-20071109 libiconv-1.11_1 m4-1.4.12,1 perl-5.8.9_2
R-deps: libiconv-1.11_1
WWW:    http://www.zsh.org/
```

# 便利ツールの導入  {#k3d8e5e4}
サーバーを運営していく上で、便利な「小物」は数多くあります。
その中でも必須と思われるツールをいくつかピックアップしてみました。
ちなみにこの中には便利ツールというよりセキュリティの観点から必須と思われるツールも入っています。

[ユーティリティソフトウェアの導入](/archive/freebsd/FreeBSD/Ports/Utility/ "ユーティリティソフトウェアの導入")
[セキュリティソフトウェアの導入](/archive/freebsd/FreeBSD/Ports/Security/ "セキュリティソフトウェアの導入")
[日本語関連ソフトウェアの導入](/archive/freebsd/FreeBSD/Ports/Japanese/ "日本語関連ソフトウェアの導入")
