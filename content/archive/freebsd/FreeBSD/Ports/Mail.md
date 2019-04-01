+++
title = "[PukiWiki:freebsd] FreeBSD/Ports/Mail"
date = "2008-10-16T04:12:08Z"
+++


# メールサーバの構築  {#o74b9ef2}
メールサーバを構築するにあたって、今回は Postfix と Dovecot を採用したメールサーバの構築方法を解説します。
Postfix は Sendmail より設定方法が比較的わかり易いと言われるソフトウェアで、似たソフトウェアに Exim などがあげられます。これらは最近の Linux ディストリビュージョンで標準採用されるなど、ご存知の方も多いかと思います。
対して Dovecot は新鋭のソフトウェアでありながら、リリース頻度 ( 一部の方から早すぎとも ^^; ) で群を抜く、今注目のソフトウェアです。似たようなソフトウェアとして、 Courie-IMAP などが挙げられます。

- [SMTP サーバーの構築](/archive/freebsd/FreeBSD/Ports/Mail/Postfix/ "SMTP サーバーの構築")
- [POP3 IMAP サーバーの構築](/archive/freebsd/FreeBSD/Ports/Mail/Dovecot/ "POP3 IMAP サーバーの構築")
- [LDAP 認証の設定](/archive/freebsd/FreeBSD/Ports/Mail/LDAP/ "LDAP 認証の設定")
- [スパム対策](/archive/freebsd/FreeBSD/Ports/Mail/Spam/ "スパム対策")
