+++
title = "[PukiWiki:wiki] Windows/XP/Patch/Resource_Hacker"
date = "2009-04-05T06:10:30Z"
+++


# explorer.exe  {#ec8b62cc}
6.00.2900.2180 (xpsp_sp2_rtm.040803-2158)

## File  {#bd1dc2f9}
#ref(Start.res)
#ref(explorer01.res)
#ref(explorer02.res)
#ref(explorer03.res)

## Script  {#ea2e326a}

```
[FILENAMES]
Exe=            explorer.exe
SaveAs=         new_explorer.exe
Log=            explorer.log

[COMMANDS]
-addoverwrite   Start.res,        StringTable, 37,    1041
-addoverwrite   explorer01.res,   StringTable, 439,   1041
-addoverwrite   explorer02.res,   StringTable, 440,   1041
-addoverwrite   explorer03.res,   StringTable, 515,   1041

```

# msgina.dll  {#rdff7ff9}

## File  {#yb6fb94b}
#ref(msgina01.res)
#ref(msgina02.res)
#ref(msgina03.res)
#ref(msgina04.res)
#ref(msgina05.res)

## Script  {#xb4161ea}

```
[FILENAMES]
Exe=            msgina.dll
SaveAs=         new_msgina.dll
Log=            msgina.log

[COMMANDS]
-addoverwrite   msgina01.res,     Dialog,     1500,  1041
-addoverwrite   msgina02.res,     Dialog,     2200,  1041
-addoverwrite   msgina03.res,     Dialog,     2450,  1041
-addoverwrite   msgina04.res,     Dialog,     1950,  1041
-addoverwrite   msgina05.res,     Dialog,     20100, 1041

```

# netshell.dll  {#v2af5158}
5.1.2600.2180 (xpsp_sp2_rtm.040803-2158)

## File  {#ib90ccf9}
#ref(netshell01.res)

## Script  {#ofd91ad6}

```
[FILENAMES]
Exe=            netshell.dll
SaveAs=         new_netshell.dll
Log=            netshell.log

[COMMANDS]
-addoverwrite   netshell01.res,   StringTable, 76,    1041

```

# shell32.dll  {#i31dbde5}
6.00.2900.2951 (xpsp_sp2_gdr.060713-0009)

## File  {#y939390b}
#ref(shell32_01.res)
#ref(shell32_02.res)
#ref(shell32_03.res)

## Script  {#gb618da0}

```
[FILENAMES]
Exe=            shell32.dll
SaveAs=         new_shell32.dll
Log=            shell32.log

[COMMANDS]
-addoverwrite   shell32_01.res,   StringTable, 1362,  1041
-addoverwrite   shell32_02.res,   Dialog,      14352, 1041
-addoverwrite   shell32_03.res,   Dialog,      1089,  1041

```

# Tips  {#h98bf6a4}
まだ試した訳じゃないけど一応。
