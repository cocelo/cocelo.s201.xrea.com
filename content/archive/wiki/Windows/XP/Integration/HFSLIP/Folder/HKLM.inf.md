+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder/HKLM.inf"
date = "2008-12-10T09:33:22Z"
+++


```

[Version]
Signature = "$Windows NT$"

[SETUP]
; シャットダウン時にページングファイルを削除する
;HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management","ClearPageFileAtShutdown",0x00010001,0x00000001
; カーネルを物理メモリに常駐させる
HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management","DisablePagingExecutive",0x00010001,0x00000001
; アプリの起動を高速化する
HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management","LargeSystemCache",0x00010001,0x00000001
; L2 キャッシュのサイズを調整する
HKLM,"SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management","SecondLevelDataCache",0x00010001,0x00000400
; http://factory-sakura.sblo.jp/article/941138.html
; 使っていない「.DLL」ファイルをアンロードする
;HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer","AlwaysUnloadDLL",0x00010001,0x00000001
; アイコンキャッシュサイズ
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer","Max Cached Icons",0x00000000,0x00001000
; 画面表示をリアルタイムに
HKLM,"SYSTEM\CurrentControlSet\Control\Update","UpdateMode",0x00010001,0x00000000

; ネットワーク調整
; QoS で帯域を絞られないようにする
HKLM,"SOFTWARE\Policies\Microsoft\Windows\PSched","NonBestEffortLimit",0x00010001,0x00000000
HKLM,"SOFTWARE\Policies\Microsoft\Windows\PSched","MaxOutstandingSends",0x00010001,0x0000ffff

; RWIN AFD その他調整
;HKLM,"SYSTEM\CurrentControlSet\Services\AFD\Parameters","DefaultReceiveWindow",0x00010001,00,f4,03,00
;HKLM,"SYSTEM\CurrentControlSet\Services\AFD\Parameters","DefaultSendWindow",0x00010001,00,f4,03,00
;HKLM,"SYSTEM\CurrentControlSet\Services\AFD\Parameters","LargeBufferSize",0x00010001,00,40,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\AFD\Parameters","MediumBufferSize",0x00010001,00,08,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\AFD\Parameters","SmallBufferSize",0x00010001,00,01,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","DefaultTTL",0x00010001,80,00,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","EnablePMTUDiscovery",0x00010001,01,00,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","EnablePMTUBHDetect",0x00010001,00,00,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","TcpWindowSize",0x00010001,00,f4,03,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","Tcp1323Opts",0x00010001,03,00,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","SackOpts",0x00010001,01,00,00,00
;HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","TcpMaxDupAcks",0x00010001,03,00,00,00

; 各種セキュリティ設定
HKLM,"SYSTEM\CurrentControlSet\Services\Browser\Parameters","IsDomainMaster",0x00000000,"FALSE"
; ブラウズマスタにならない
HKLM,"SYSTEM\CurrentControlSet\Services\Browser\Parameters","MaintainServerList",0x00000000,"No"
; TCP/IP スタック強化
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","SynAttackProtect",0x00010001,0x00000002
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","EnableDeadGWDetect",0x00010001,0x00000000
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","EnablePMTUDiscovery",0x00010001,0x00000000
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","KeepAliveTime",0x00010001,0x000493e0
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","NoNameReleaseOnDemand",0x00010001,0x00000001
; http://journal.mycom.co.jp/column/winxp/100/index.html
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","DisableTaskOffload",0x00010001,0x00000000
; 問合せた DNS サーバ以外の応答を拒否する
HKLM,"SYSTEM\CurrentControlSet\Services\DnsCache\Parameters","QueryIpMatching",0x00010001,0x00000001
HKLM,"SYSTEM\CurrentControlSet\Services\Tcpip\Parameters","QueryIpMatching",0x00010001,0x00000001
; 管理共有を無効に
HKLM,"SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters","AutoShareWks",0x00010001,0x00000000
; リモート・アシスタンスを許可しない
HKLM,"SYSTEM\CurrentControlSet\Control\Terminal Server","fAllowToGetHelp",0x00010001,0x00000000
; リモート・デスクトップを許可しない
HKLM,"SYSTEM\CurrentControlSet\Control\Terminal Server","fDenyTSConnections",0x00010001,0x00000001
; .NETパスワードを保存しない
HKLM,"SYSTEM\CurrentControlSet\Control\Lsa","DisableDomainCreds",0x00010001,0x00000001

; システムの復元を無効に
HKLM,"SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore","DisableSR",0x00010001,0x00000001
HKLM,"SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore","DisableConfig",0x00010001,0x00000001
; ワトソン博士を無効に
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\AeDebug","Auto",0x00010001,0x00000000
; SFC 無効に ( SFC_OS.SYS 書き換え )
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon","SFCDisable",0x00010001,0xffffff9d
; 自動デフラグ機能を無効に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout","EnableAutoLayout",0x00010001,0x00000000
; エラー報告を無効に
HKLM,"SOFTWARE\Microsoft\PCHealth\ErrorReporting","DoReport",0x00010001,0x00000000
HKLM,"SOFTWARE\Microsoft\PCHealth\ErrorReporting","ShowUI",0x00010001,0x00000000
; NTFS 暗号化機能を無効に
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\EFS","EfsConfiguration",0x00010001,0x00000001
; インターネット印刷機能を無効に
HKLM,"SOFTWARE\Policies\Microsoft\Windows NT\Printers","DisableWebPrinting",0x00010001,0x00000001
; アプリケーション互換性エンジンを無効に
HKLM,"SOFTWARE\Policies\Microsoft\Windows\AppCompat","DisableEngine",0x00010001,0x00000001
; エラーメッセージダイアログを表示しない
HKLM,"SYSTEM\CurrentControlSet\Control\Windows","ErrorMode",0x00010001,0x00000002
; Outlook Express 起動時に Windows Messenger を起動しない
HKLM,"SOFTWARE\Microsoft\Outlook Express","Hide Messenger",0x00010001,0x00000002

; Windows Update 自動更新の設定
; 更新は通知するのみでダウンロードは行わない
HKLM,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU","NoAutoUpdate",0x00010001,0x00000000
HKLM,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU","AUOptions",0x00010001,0x00000002
HKLM,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU","ScheduledInstallDay",0x00010001,0x00000005
HKLM,"SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU","ScheduledInstallTime",0x00010001,0x00000000

; Windows Media Player
; 自動更新を無効に
HKLM,"SOFTWARE\Policies\Microsoft\WindowsMediaPlayer","DisableAutoUpdate",0x00010001,0x00000001
HKLM,"SOFTWARE\Microsoft\MediaPlayer","EnableAutoUpgrade",0x00000000,"no"
; 自動更新のメッセージを抑制
HKLM,"SOFTWARE\Microsoft\MediaPlayer","AskMeAgain",0x00000000,"yes"
; 初回起動時の設定画面を表示しない
HKLM,"SOFTWARE\Policies\Microsoft\WindowsMediaPlayer","GroupPrivacyAcceptance",0x00010001,0x00000001

; 初回ログオン時の Windows ツアーを表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Tour","RunCount",0x00010001,0x00000000

; WindowsのCD書き込み機能を無効に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoCDBurning",0x00010001,0x00000001
; 「別のユーザーとして実行」を無効に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","HideRunAsVerb",0x00010001,0x00000001
; 「ネットワークドライブの割り当て」「ネットワークドライブの切断」を非表示に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoNetConnectDisconnect",0x00010001,0x00000001
; 「このフォルダのカスタマイズ」を非表示に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoCustomizeWebView",0x00010001,0x00000001

; ユーザー操作追跡機能を無効にする
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoInstrumentation",0x00010001,0x00000001
; 「最近使ったファイルの履歴」を残さない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoRecentDocsHistory",0x00010001,0x00000001
; 「スタート」 - 「最近使ったファイルの履歴」を表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoRecentDocsMenu",0x00010001,0x00000001
; 「マイネットワーク」に「最近使ったフォルダの履歴」を残さない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoRecentDocsNetHood",0x00010001,0x00000001

; http://www.wa.commufa.jp/~exd/contents/privacy_security/028.html
; 「スタート」 - 「プログラムのアクセスと既定の設定」を表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoSMConfigurePrograms",0x00010001,0x00000001
; 「プログラムの追加と削除」 - 「プログラムのアクセスと既定の設定」を表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Uninstall ","NoChooseProgramsPage",0x00010001,0x00000001
; 「スタート」 - 「ヘルプとサポート」を表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoSMHelp",0x00010001,0x00000001

; マイコンピュータで共有ドキュメントを表示しない
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoSharedDocuments",0x00010001,0x00000001

; コントロールパネルをクラッシック表示に
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","ForceClassicControlPanel",0x00010001,0x00000001

; ショートカット追跡機能の禁止
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoResolveTrack",0x00010001,0x00000001
; ショートカット検索機能の禁止
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","NoResolveSearch",0x00010001,0x00000001
; ショートカットのリンクチェック機能の禁止
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer","LinkResolveIgnoreLinkInfo",0x00010001,0x00000001
; ショートカットの矢印アイコンを消す
HKLM,"SOFTWARE\Classes\lnkfile","IsShortcut",0x00000000,""
; 「～へのショートカット」を消す
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer","link",0x00010000,00,00,00,00

; ごみ箱に入れずに直接削除する
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BitBucket","NukeOnDelete",0x00010001,0x00000001
; ごみ箱を非表示にする
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\NonEnum","{645FF040-5081-101B-9F08-00AA002F954E}",0x00010001,0x00000001

; http://technet2.microsoft.com/WindowsServer/ja/library/d0518719-7154-49b4-954c-0a6c015ab4411041.mspx
; ファイル名とディレクトリ名の補完機能を有効にする
HKLM,"SOFTWARE\Microsoft\Command Processor",CompletionChar,0x00010001,0x00000009
HKLM,"SOFTWARE\Microsoft\Command Processor",PathCompletionChar,0x00010001,0x00000009

; コントロールパネルに「メモ帳トラッパー」を追加
HKLM,"SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\Cpls","Text Editor",0x00000000,"Mmtrp.cpl"

; MeiryoKe
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","MeiryoKe_Gothic & MeiryoKe_PGothic & MeiryoKe_UIGothic (TrueType)",0x00000000,"meiryoKeGothic.ttc"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","MeiryoKe_Gothic_Bold & MeiryoKe_PGothic_Bold & MeiryoKe_UIGothic_Bold (TrueType)",0x00000000,"meiryoKeGothicB.ttc"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","MeiryoKe_Console (TrueType)",0x00000000,"meiryoKeConsole.ttf"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","メイリオ & メイリオ イタリック (TrueType)",0x00000000,"meiryo.ttc"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","メイリオ ボールド & メイリオ ボールド イタリック (TrueType)",0x00000000,"meiryob.ttc"

; Consolas
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","Consolas (TrueType)",0x00000000,"Consola.ttf"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","Consolas Bold (TrueType)",0x00000000,"Consolab.ttf"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","Consolas Bold Italic (TrueType)",0x00000000,"Consolaz.ttf"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","Consolas Italic (TrueType)",0x00000000,"Consolai.ttf"

; Meiryo with Consola
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","Meiryo_With_Consolas & Meiryo_With_Consolas イタリック (TrueType)",0x00000000,"meiryo_consolas.ttc"
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink","Consolas",0x00010000,"meiryo_consolas.ttc,Meiryo_With_Consolas"

; モトヤシータ
HKLM,"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts","NFモトヤシータ゛1 & NFモトヤシータ゛1等幅 & NFモトヤシータ゛1KP (TrueType)",0x00000000,"NFc1kp.ttc"

; IE7 を無効に
HKLM,"SOFTWARE\Microsoft\Internet Explorer\Setup\7.0","DoNotAllowIE70",0x00010001,0x00000001

; 各種拡張子のコンテキストメニューに「編集」を追加する
; HTA
HKLM,"SOFTWARE\Classes\htafile\Shell\Edit",,0x00000000,"編集(&E)"
HKLM,"SOFTWARE\Classes\htafile\Shell\Edit\Command",,0x00020000,"%%SystemRoot%%\System32\NOTEPAD.EXE %%1"
; HTML
HKLM,"SOFTWARE\Classes\htmlfile\Shell\Edit",,0x00000000,"編集(&E)"
HKLM,"SOFTWARE\Classes\htmlfile\Shell\Edit\Command",,0x00020000,"%%SystemRoot%%\System32\NOTEPAD.EXE %%1"
; WSH
HKLM,"SOFTWARE\Classes\WSHFile\Shell\Edit",,0x00000000,"編集(&E)"
HKLM,"SOFTWARE\Classes\WSHFile\Shell\Edit\Command",,0x00020000,"%%SystemRoot%%\System32\NOTEPAD.EXE %%1"
; XML
HKLM,"SOFTWARE\Classes\xmlfile\Shell\Edit",,0x00000000,"編集(&E)"
HKLM,"SOFTWARE\Classes\xmlfile\Shell\Edit\Command",,0x00020000,"%%SystemRoot%%\System32\NOTEPAD.EXE %%1"
; XSL
HKLM,"SOFTWARE\Classes\xslfile\Shell\Edit",,0x00000000,"編集(&E)"
HKLM,"SOFTWARE\Classes\xslfile\Shell\Edit\Command",,0x00020000,"%%SystemRoot%%\System32\NOTEPAD.EXE %%1"

; DNS キャッシュを 12 時間で破棄
HKLM,"SYSTEM\CurrentControlSet\Services\Dnscache\Parameters","MaxCacheEntryTtlLimit",0x00010001,0x0000a8c0
HKLM,"SYSTEM\CurrentControlSet\Services\Dnscache\Parameters","MaxNegativeCacheTtl",0x00010001,0x00000000

; HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
```

