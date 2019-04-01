+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder/WinXP_CleanUp.cmd"
date = "2008-12-10T09:33:22Z"
+++


```
cWnd /hide @

@echo off

DEL /F /Q "%SystemRoot%\*.bmp"
DEL /F /Q "%SystemRoot%\Web\Wallpaper\*"
DEL /F /Q "%SystemRoot%\system32\*.scr"
DEL /F /Q "%SystemRoot%\Cursors\*"

FOR %%i IN (D E F G H I J K L M N O P Q R S T U V W X Y Z) DO IF EXIST %%i:\WIN51 SET CDROM=%%i:
COPY /Y "%CDROM%\$OEM$\$$\Web\Wallpaper\*" "%SystemRoot%\Web\Wallpaper\*"

RD /S /Q "%ALLUSERSPROFILE%\Documents\My Pictures\Sample Pictures"
RD /S /Q "%ALLUSERSPROFILE%\Documents\My Music\Sample Music"
RD /S /Q "%ALLUSERSPROFILE%\Documents\My Music\Sample Playlists"

DEL /F /Q "%ALLUSERSPROFILE%\スタート メニュー\Windows Update.lnk"
DEL /F /Q "%ALLUSERSPROFILE%\スタート メニュー\Windows カタログ.lnk"
DEL /F /Q "%ALLUSERSPROFILE%\スタート メニュー\プログラムのアクセスと既定の設定.lnk"
DEL /F /Q "%ALLUSERSPROFILE%\デスクトップ\Microsoft Network Monitor 3.1.lnk"

REM Windows 標準の zip/cab ファイルの展開を無効にする
regsvr32 /u /s zipfldr.dll
regsvr32 /u /s cabview.dll

exit
```

