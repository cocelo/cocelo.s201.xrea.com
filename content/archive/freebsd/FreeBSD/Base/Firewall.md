+++
title = "[PukiWiki:freebsd] FreeBSD/Base/Firewall"
date = "2008-10-16T04:12:04Z"
+++


# ファイアウォール構築  {#u1ceea32}
ファイアウォール構築に当たっては、 TCP/IP の知識が必要になります。
パーソナルファイアウォールを構築するだけでしたら、知識は必要ないかもしれませんが、この機会に TCP/IP を勉強してみることをお勧めします。
インターネットの基盤とも言える技術ですので、この TCP/IP の知識があればまた違った見方が出来るようになります。

また、公式 HP のハンドブックにファイアウォールに関するドキュメントが用意されているので、そちらも参照してみる事をお勧めします。
- [ファイアウォール](http://www.freebsd.org/doc/ja/books/handbook/firewalls.html "ファイアウォール")

# FreeBSD でファイアウォール  {#k8cea74d}
FreeBSD でファイアウォールを構築する場合、主に下記の三つから選択する事になると思います。
近年では ipfw 、 ipf ( IP Filter ) ではなく、 pf ( Packet Filter ) を採用されている方が多くなっています。
pf は OpenBSD から誕生したこともあり、ライセンスの問題や、文法が非常に ipf と似通っているので資源の再利用がし易い、など、いくつもの利点があります。

- ipfw
- ipf ( IP Filter )
- pf ( Packet Filter )

# pf ( Packet Filter ) でファイアウォール構築  {#n7f46cb0}
pf ( Packet Filter ) でファイアウォール構築を行ったときのメモです。

#ls2(FreeBSD/Base/Firewall/pf,link,pf ( Packet Filter ) でファイアウォールの構築)
