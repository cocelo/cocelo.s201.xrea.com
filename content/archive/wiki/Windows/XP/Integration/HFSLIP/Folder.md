+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder"
date = "2008-12-10T09:33:22Z"
+++

# フォルダ構成  {#jbd5be0c}
HFSLIP のフォルダ構成メモ。


# FDVFILES  {#z5fca51f}
Windows 2000 を統合する際に使用するフォルダなので Windows XP ユーザーは気にしなくて OK です。

# HF  {#qe3fa169}
Service Pack や Hotfix , DirectX End-User Runtimes を格納するディレクトリです。

# HFAAO  {#td555453}
nLite Addon を格納するディレクトリです。

使用できる圧縮形式は cab 及び 7z です。

# HFCABS  {#k56fa3c8}
Windows XP SP3 の場合、 [wbemoc.cab](http://hfslip.org/downloads.html "wbemoc.cab") を配置する必要があります。

# HFCLEANUP  {#l9e29730}
この機能はサポートされていません。

使用する場合は自己責任で。

参考サイト
- [HFCLEANUP - Reduce your source - MSFN Forums](http://www.msfn.org/board/index.php?showtopic=65537 "HFCLEANUP - Reduce your source - MSFN Forums")

# HFEXPERT  {#ze9eff1f}
HFEXPERT フォルダを**手動で**作成し、下記のフォルダを作成します。
- APPREPLACEMENT
- CODECS
- DRIVERCAB
- HIVEINSTALL
- PROGRAMFILES
- WIN

## APPREPLACEMENT  {#dade64d8}
既に存在しているファイルを置き換える事が出来ます。
- [mplayer2.exe \( Media Player Classic \)](http://nanasi7743.googlepages.com/ "mplayer2.exe \( Media Player Classic \)")
- [taskmgr.exe \( Process Explorer \)](http://technet.microsoft.com/ja-jp/sysinternals/bb896653(en-us).aspx "taskmgr.exe \( Process Explorer \)")
    -  [X-WORKS.org - Process Explorer](http://works.xworks.org/l10n/sysinternals/process_explorer "X-WORKS.org - Process Explorer")
- [notepad.exe \( メモ帳トラッパー \)](http://www.vector.co.jp/soft/win95/writing/se041174.html "notepad.exe \( メモ帳トラッパー \)")
    -  [メモ帳トラッパーをIE6対応に](http://www.vector.co.jp/soft/win95/writing/se215749.html "メモ帳トラッパーをIE6対応に")

## CODECS  {#n893d25f}
コーデックを統合することが出来ます。

参考サイト
- [Codec slipstreaming - MSFN Forums](http://www.msfn.org/board/index.php?showtopic=77369 "Codec slipstreaming - MSFN Forums")

- [HFSLIP your codecs - MSFN Forums](http://www.msfn.org/board/index.php?showtopic=57649 "HFSLIP your codecs - MSFN Forums")

## DRIVERCAB  {#bd4a17d5}
ドライバを統合することができます。

参考サイト
- [Integrating drivers with HFSLIP? - MSFN Forums](http://www.msfn.org/board/Integrating-drivers-with-HFSLIP-t63302.html "Integrating drivers with HFSLIP? - MSFN Forums")
- [hfslipまとめサイト @ wiki - ドライバ統合](http://www28.atwiki.jp/hfslip/pages/12.html "hfslipまとめサイト @ wiki - ドライバ統合")

## HIVEINSTALL  {#te8683e6}
Text-mode Setup 時にレジストリを追加します。

注意点として、レジストリの追加はできても**削除はできません。**

- [HKCU.inf](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/HKCU.inf/ "HKCU.inf")
- [HKLM.inf](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/HKLM.inf/ "HKLM.inf")

参考サイト
- [Semplice:Windowsのレジストリ（Registry）におけるハイブ構造とSID](http://blog.lucanian.net/archives/50581962.html "Semplice:Windowsのレジストリ（Registry）におけるハイブ構造とSID")

## PROGRAMFILES  {#r214c5eb}
[$OEM$フォルダ](/archive/wiki/Windows/XP/Integration/$OEM$/ "$OEM$フォルダ") の **$Progs フォルダ** のようなもの。

ロングファイルネーム、スペースをサポートしています。

## STORAGE  {#a370ee32}
SATA/RAIDドライバを統合する事ができます。

なお、このフォルダからインストールされたドライバは TXTSETUP.SIF に記述され、RAID構築時などの、所謂 **F6キー連打** を回避する事が出来ます。

[Integrating SATA and RAID drivers with HFSLIP - MSFN Forums](http://www.msfn.org/board/index.php?showtopic=84572 "Integrating SATA and RAID drivers with HFSLIP - MSFN Forums")

# HFGUIRUNONCE  {#d683e063}
**GUIRunOnce/RunOnceEX** で実行したいファイルを格納します。

- .EXE ( サイレントインストーラ形式 )
- .REG
- .INF
- .CMD

サイレントインストーラ .REG .INF .CMD を入れる事が出来ます。

RunOnceEX を自分で書いていた方はこのフォルダにファイルを配置する事により、 RunOnceEX の管理の手間が省けます。

- [X_Settings.inf](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/X_Settings.inf/ "X_Settings.inf")
- [XX_Services.inf](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/XX_Services.inf/ "XX_Services.inf")
- [XXX_ReBoot.cmd](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/XXX_ReBoot.cmd/ "XXX_ReBoot.cmd")

# HFSVCPACK  {#i1df2c8d}
**T-13** で実行したいファイルを格納します。

- .EXE ( サイレントインストーラ形式 )
- .REG
- .INF
- .CMD

サイレントインストーラ .REG .INF .CMD を入れる事が出来ます。

- [WinXP_CleanUp.cmd](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/WinXP_CleanUp.cmd/ "WinXP_CleanUp.cmd")
- [WinXP_Settings.inf](/archive/wiki/Windows/XP/Integration/HFSLIP/Folder/WinXP_Settings.inf/ "WinXP_Settings.inf")

# HFSVCPACK_SW1  {#a20b3134}
**T-13** で実行したいファイルを格納します。

- .MSI ( **/qn /norestart** でインストールできるもの )
- .EXE ( **/quiet /norestart** でインストールできるもの )

# HFSVCPACK_SW2  {#n46c7d58}
**T-13** で実行したいファイルを格納します。

- .EXE ( **/Q:A /R:N** でインストールできるもの )

# REPLACE  {#fa780a38}
HFSLIP が全ての作業を終えた後、強制的に上書きさせたいファイルを入れます。

また、これらは全て CAB 圧縮 ( LXZ21 ) されています。
- [I386\WINNT.SIF](/archive/wiki/Windows/XP/Integration/WINNT.SIF/ "I386\WINNT.SIF")
- [I386\setupapi.dl_](/archive/wiki/Windows/XP/Patch/SETUPAPI.DLL/ "I386\setupapi.dl_")
- [I386\sfc_os.dl_ \( or sfcfiles.dl_ \)](/archive/wiki/Windows/XP/Patch/sfc_os.dll/ "I386\sfc_os.dl_ \( or sfcfiles.dl_ \)")
- [I386\uxtheme.dl_](/archive/wiki/Windows/XP/Patch/uxtheme.dll/ "I386\uxtheme.dl_")
- [I386\tcpip.sy_](/archive/wiki/Windows/XP/Patch/TCPIP.SYS/ "I386\tcpip.sy_")
- I386\explorer.ex_

# HFTOOLS  {#oae06fa8}
HFSLIP で使うツール類など。
- [7za.exe](http://www.7-zip.org/download.html "7za.exe")
- [bbie.exe](http://www.nu2.nu/bbie/#1 "bbie.exe")
- boot.bin
- [CDIMAGE.EXE](http://www.tech-hints.com/2kos.html#7 "CDIMAGE.EXE")
- [CMDOW.EXE](http://www.commandline.co.uk/cmdow/ "CMDOW.EXE") or [cWnd](http://www.ryanvm.net/forum/viewtopic.php?t=5017 "cWnd")
- [EXTRACT.EXE](http://support.microsoft.com/kb/310618/ "EXTRACT.EXE")
- [modifyPE](ftp://ftp.sac.sk/pub/sac/utilprog/modpe081.zip "modifyPE")
- HFANSWER.INI

# SOURCE  {#qd18b453}
Windows XP の CD ソース。
- I386 フォルダ
- WIN51
- WIN51IP ( Windows XP Pro )
- WIN51IP.SP2 ( Windows XP Pro SP2 )

# SOURCESS  {#hff67300}
作業終了 ( SOURCE フォルダの内容に Hotfix などを適用した ) 後のフォルダ。
