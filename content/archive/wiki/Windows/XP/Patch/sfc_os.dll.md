+++
title = "[PukiWiki:wiki] Windows/XP/Patch/sfc_os.dll"
date = "2008-12-10T09:33:23Z"
+++

# sfc_os.dll  {#rded8439}
Windows File Protection ( WFP ) を無効にする。


## 5.1.2600.2180  {#b1940228}
xpsp_sp2_rtm.040803-2158

### Patch  {#m3d912e0}

```
0000ECE9: 33 90
0000ECEA: C0 90
0000ECEB: 40 90

```

## Tips  {#wf280769}
パッチを適用したら下記のレジストリのエントリを書き換える。

```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

SFCDisable REG_DWORD 0xffffff9d


```

## Link  {#xe09b08f}
[JSI Tip 5392. More on disabling Windows File Protection](http://www.jsifaq.com/SF/Tips/Tip.aspx?id=5392 "JSI Tip 5392. More on disabling Windows File Protection")

WFP 無効化の Tips など。
