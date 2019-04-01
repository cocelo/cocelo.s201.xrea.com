+++
title = "[PukiWiki:wiki] BSD/FreeBSD/ntpdate"
date = "2008-12-10T09:33:20Z"
+++

# ntpdate Memo  {#z96965fc}


## Link  {#v9f8a590}
- [NTPDATE\(8\)](http://www.jp.freebsd.org/cgi/mroff.cgi?subdir=man&lc=1&cmd=&man=ntpdate&dir=jpman-6.2.2%2Fman&sect=0 "NTPDATE\(8\)")

## Memo  {#f593b168}
ntpd 設定してる場合はいりません。

## Install  {#d437f1cb}
ntpdate は FreeBSD には標準で入っています。

## Setting  {#zbc46d17}

```
# vi /etc/rc.conf

ntpdate_enable="YES"
ntpdate_flags="-b ntp.jst.mfeed.ad.jp"
```

