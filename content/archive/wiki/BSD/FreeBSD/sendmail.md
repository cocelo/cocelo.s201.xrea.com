+++
title = "[PukiWiki:wiki] BSD/FreeBSD/sendmail"
date = "2008-12-10T09:33:20Z"
+++

# sendmail Memo  {#l955eb9b}


## Link  {#a22413a8}
- [SENDMAIL\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=sendmail&dir=jpman-6.2.2%2Fman&sect=0 "SENDMAIL\(8\)")
- [sendmail の設定](http://www.freebsd.org/doc/ja_JP.eucJP/books/handbook/sendmail.html "sendmail の設定")

## Settings  {#cf6f0a3e}

### IPv6 を無効にする  {#mf91e9fb}

```
# vi /etc/mail/sendmail.cf

#O DaemonPortOptions=Name=IPv6, Family=inet6, Modifiers=O
```

