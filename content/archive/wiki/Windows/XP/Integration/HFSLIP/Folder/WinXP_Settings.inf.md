+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder/WinXP_Settings.inf"
date = "2008-12-10T09:33:23Z"
+++


```

[Version]
Signature=$Windows NT$

[Optional Components]
MyRegTweaks

[DefaultInstall]
OptionDesc ="Registry Entries"
Tip        ="Registry Entries"
Modes      =0,1,2,3
AddReg     =REGEntries.AddReg
DelReg     =REGEntries.DelReg

[MyRegTweaks]
OptionDesc ="Registry Entries"
Tip        ="Registry Entries"
Modes      =0,1,2,3
AddReg     =REGEntries.AddReg
DelReg     =REGEntries.DelReg

[REGEntries.AddReg]
; Reg2Inf v0.37 - http://tinyurl.com/fgqyf
; Internet Explorer の検索設定
HKCU,"Software\Microsoft\Internet Explorer\Main","Use Search Asst",0,"no"
HKCU,"Software\Microsoft\Internet Explorer\Main","Search Page",0,"http://www.google.com"
HKCU,"Software\Microsoft\Internet Explorer\Main","Search Bar",0,"http://www.google.com/ie_rsearch.html"
HKCU,"Software\Microsoft\Internet Explorer\SearchURL",,0,"http://www.google.com/keyword/%%s"
HKCU,"Software\Microsoft\Internet Explorer\SearchURL","provider",0,"gogl"
HKLM,"SOFTWARE\Microsoft\Internet Explorer\Search","SearchAssistant",0,"http://www.google.com/ie_rsearch.html"

[REGEntries.DelReg]
; Reg2Inf v0.37 - http://tinyurl.com/fgqyf

; http://journal.mycom.co.jp/column/winxp/105/
; ログオン時にIMEツールバー表示を無効にする
HKCU,".DEFAULT\Keyboard Layout\Preload","1"

; 「送る」メニューを削除
HKLM,"SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\Send To"

; 「新規作成」メニューの「テキストドキュメント」「ショートカット」「フォルダ」以外を削除
HKLM,"SOFTWARE\Classes\.bfc\ShellNew"
HKLM,"SOFTWARE\Classes\.bmp\ShellNew"
HKLM,"SOFTWARE\Classes\.doc\WordPad.Document.1"
HKLM,"SOFTWARE\Classes\.rtf\ShellNew"
HKLM,"SOFTWARE\Classes\.wav\ShellNew"
HKLM,"SOFTWARE\Classes\.wdp\ShellNew"
HKLM,"SOFTWARE\Classes\.zip\ShellNew"

; Windows Media Player の右クリックメニューを削除
HKLM,"SOFTWARE\Classes\CLSID\{7D4734E6-047E-41e2-AEAA-E763B4739DC4}"
HKLM,"SOFTWARE\Classes\CLSID\{8DD448E6-C188-4aed-AF92-44956194EB1F}"
HKLM,"SOFTWARE\Classes\CLSID\{CE3FB1D1-02AE-4a5f-A6E9-D9F1B4073E6C}"
HKLM,"SOFTWARE\Classes\CLSID\{F1B9284F-E9DC-4e68-9D7E-42362A59F0FD}"

; ネットワーク共有の「タスク」フォルダと「プリンタ」フォルダの削除
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{D6277990-4C6A-11CF-8D87-00AA0060F5BF}"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RemoteComputer\NameSpace\{2227A280-3AEA-1069-A2DE-08002B30309D}"

; 検索から「コンピュータ」「プリンタ」「人」「インターネット」を削除
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FindExtensions\Static\ShellSearch\1"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FindExtensions\Static\ShellSearch\2"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FindExtensions\Static\WabFind"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FindExtensions\Static\WebSearch"

; マウスカーソルのデザインをシステム標準以外削除
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows アニメーション"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","3D モノクロ"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","手 1"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","手 2"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","恐竜"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","オールド ファッション"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","コンダクタ"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","拡大ポインタ"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","いろいろなポインタ"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","3D ブロンズ"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 黒"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 黒 (大きいフォント)"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 黒 (特大のフォント)"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 反転色"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 反転色 (大きいフォント)"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows 反転色 (特大のフォント)"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows スタンダード (大きいフォント)"
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cursors\Schemes","Windows スタンダード (特大のフォント)"

; 各種拡張子のコンテキストメニューの「印刷」を削除する
HKLM,"SOFTWARE\Classes\batfile\shell\print"
HKLM,"SOFTWARE\Classes\cmdfile\shell\print"
HKLM,"SOFTWARE\Classes\htmlfile\shell\print"
HKLM,"SOFTWARE\Classes\htmlfile\shell\printto"
HKLM,"SOFTWARE\Classes\JSFile\Shell\Print"
HKLM,"SOFTWARE\Classes\inffile\shell\print"
HKLM,"SOFTWARE\Classes\inifile\shell\print"
HKLM,"SOFTWARE\Classes\regfile\shell\print"
HKLM,"SOFTWARE\Classes\txtfile\shell\print"
HKLM,"SOFTWARE\Classes\txtfile\shell\printto"
HKLM,"SOFTWARE\Classes\VBSFile\Shell\Print"
```

