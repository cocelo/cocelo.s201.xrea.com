+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Apache_2.2/Tuning"
date = "2008-10-16T04:12:07Z"
+++


# Apache のチューニングについて  {#w8596332}
Apache のチューニングは運用方法によって変わってきます。
例えば Keep Alive については、 PHP や CGI が少なく、静的なページばかりの際は有効にしておいた方が良いです。
私自身、 Keep Alive 次第でサーバーのパフォーマンスが変わる、というくらいのトラフィックを経験した事がないので試行錯誤しています。

# リンク  {#gd2cae64}
- [keep-aliveのことをちゃんと考える || パフォーマンス・チューニングBlog: インターオフィス](http://www.inter-office.co.jp/contents/72 "keep-aliveのことをちゃんと考える || パフォーマンス・チューニングBlog: インターオフィス")
- [Apache関連/パフォーマンスチューニング - jun2065.net ネットワーク,php,java,perl,oracle,postgresql,linux,solaris](http://www.jun2065.net/index.php?Apache%B4%D8%CF%A2%2F%A5%D1%A5%D5%A5%A9%A1%BC%A5%DE%A5%F3%A5%B9%A5%C1%A5%E5%A1%BC%A5%CB%A5%F3%A5%B0 "Apache関連/パフォーマンスチューニング - jun2065.net ネットワーク,php,java,perl,oracle,postgresql,linux,solaris")
