+++
title = "[PukiWiki:wiki] BSD/FreeBSD/mbmon"
date = "2008-12-10T09:33:20Z"
+++

# mbmon Memo  {#j90a46db}


## インストール  {#i5bae53f}

```
# portinstall sysutils/mbmon
# rehash

```

## 実行  {#t9c1ab4f}

```
# mbmon -I

Temp.= 34.0, 56.0, 37.0; Rot.= 3308,    0,    0
Vcore = 1.58, 2.58; Volt. = 3.28, 3.41, 11.31,  -6.51, -2.70

```

Temp は左から MB , CPU , Chip の温度。
