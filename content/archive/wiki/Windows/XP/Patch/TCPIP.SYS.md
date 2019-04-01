+++
title = "[PukiWiki:wiki] Windows/XP/Patch/TCPIP.SYS"
date = "2008-12-10T09:33:23Z"
+++

# TCPIP.SYS  {#i3bb759d}
TCPIP.SYS の TCP 同時接続制限を緩和する。


## 5.1.2600.2892  {#u888fce1}
xpsp_sp2_gdr.060420-0254

### Patch  {#iddce3e1}
TCP 同時接続数制限 16777214

```
00000130: 65 59
00000131: F8 F9
0004F5A2: 0A FE
0004F5A3: 00 FF
0004F5A4: 00 FF

```

## 5.1.2600.2892  {#ndbe37f2}
xpsp.060420-0256

### Patch  {#bc6367d2}
TCP 同時接続数制限 16777214

```
00000130: 9C 90
00000131: EB EC
0004F7C6: 0A FE
0004F7C7: 00 FF
0004F7C8: 00 FF

```

## Tips  {#x17e348d}
HFSLIP で統合した場合は QFE 版が適用される模様。

## Link  {#raacd986}
[www.LvlLord.de](http://www.lvllord.de/ "www.LvlLord.de")

TCPIP.SYS のパッチ配布サイト。
