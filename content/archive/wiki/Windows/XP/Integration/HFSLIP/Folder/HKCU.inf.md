+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder/HKCU.inf"
date = "2008-12-10T09:33:22Z"
+++


```

[Version]
Signature = "$Windows NT$"

[SETUP]
; http://journal.mycom.co.jp/column/winxp/030/index.html
; エクスプローラを別プロセスで実行する
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer","DesktopProcess",0x00010001,0x00000001

; フォルダオプション
; 「各フォルダの表示設定を保存する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","ClassicViewState",0x00010001,0x00000001
; 「縮小表示のキャッシュをしない」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","DisableThumbnailCache",0x00010001,0x00000001
; 「フォルダのヒントにファイル サイズ情報を表示する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","FolderContentsInfoTip",0x00010001,0x00000000
; 「エクスプローラに簡易フォルダ表示を使用する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","FriendlyTree",0x00010001,0x00000000
; 「すべてのファイルとフォルダを表示する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","Hidden",0x00010001,0x00000001
; 「登録されている拡張子は表示しない」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","HideFileExt",0x00010001,0x00000000
; 「ネットワークのフォルダとプリンタを自動的に検索する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","NoNetCrawling",0x00010001,0x00000001
; 「ログオン時に以前のフォルダウィンドウを表示する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","PersistBrowsers",0x00010001,0x00000000
; 「別のプロセスでフォルダ ウィンドウを開く」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","SeparateProcess",0x00010001,0x00000001
; 「暗号化や圧縮された NTFS ファイルをカラーで表示する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","ShowCompColor",0x00010001,0x00000001
; 「フォルダとデスクトップの項目の説明をポップアップで表示する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","ShowInfoTip",0x00010001,0x00000000
; 「システム フォルダの内容を表示する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","WebViewBarricade",0x00010001,0x00000001
; 「タイトルバーにファイルのパス名を表示しない」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState","FullPath",0x00010001,0x00000000
; 「アドレスバーにファイルのパス名を表示する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState","FullPathAddress",0x00010001,0x00000001
; 「マイ コンピュータにコントロール パネルを表示する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\HideMyComputerIcons","{21EC2020-3AEA-1069-A2DD-08002B30309D}",0x00010001,0x00000000
; 「表示」 - 「ステータス バー」のチェックをON
HKCU,"Software\Microsoft\Internet Explorer\Main","StatusBarOther",0x00010001,0x00000001

; タスクバー
; 「アクティブでないインジケータを隠す」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer","EnableAutoTray",0x00010001,0x00000000
; 「同様のタスク バー ボタンをグループ化する」のチェックをOFF
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","TaskbarGlomming",0x00010001,0x00000000
; 「タスク バーを固定する」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","TaskbarSizeMove",0x00010001,0x00000000

; スタートメニュー
; 「[スタート] メニューに表示するプログラム数」を 0 に
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced","Start_MinMFU",0x00010001,0x00000000

; 検索時の「アニメーションキャラクタを表示しない」に
HKCU,"Software\Microsoft\Search Assistant","SocialUI",0x00010001,0x00000000
; 検索時の「検索動作」を「上級者向け」に
HKCU,"Software\Microsoft\Search Assistant","UseAdvancedSearchAlways",0x00010001,0x00000001
; 検索時の「詳細設定オプション」の「システム フォルダの検索」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer","SearchSystemDirs",0x00010001,0x00000001
; 検索時の「詳細設定オプション」の「隠しファイルとフォルダの検索」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer","SearchHidden",0x00010001,0x00000001
; 検索時の「詳細設定オプション」の「サブ フォルダの検索」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer","IncludeSubFolders",0x00010001,0x00000001

; 自動デスクトップ クリーンアップ機能を無効にする
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\CleanupWiz","NoRun",0x00010001,0x00000001

; コンソールIMEを無効に
HKCU,"Console","LoadConIme",0x00010001,0x00000000
; コマンドプロンプトを簡易編集モードに
HKCU,"Console","QuickEdit",0x00010001,0x00000001

; 言語バーを非表示に
HKCU,"Software\Microsoft\CTF\LangBar","ShowStatus",0x10001,03,00,00,00
HKCU,"Software\Microsoft\CTF\LangBar","Transparency",0x10001,ff,00,00,00
HKCU,"Software\Microsoft\CTF\LangBar","Label",0x10001,00,00,00,00
HKCU,"Software\Microsoft\CTF\LangBar","ExtraIconsOnMinimized",0x10001,00,00,00,00

; ウインドウアニメーションを無効に
; 利いていないっぽい？
HKCU,"Control Panel\Desktop\WindowMetrics","MinAnimate",0x00000000,"0"

; 無応答アプリケーションの自動終了
HKCU,"Control Panel\Desktop","AutoEndTasks",0x00000000,"1"
; ClearType
HKCU,"Control Panel\Desktop","FontSmoothing",0x00000000,"2"
HKCU,"Control Panel\Desktop","FontSmoothingOrientation",0x00010001,0x00000001
HKCU,"Control Panel\Desktop","FontSmoothingType",0x00010001,0x00000002
; メニューのディレイを短くする
HKCU,"Control Panel\Desktop","MenuShowDelay",0x00000000,"20"
; ハングアップするまでの時間
HKCU,"Control Panel\Desktop","HungAppTimeout",0x00000000,"3000"
; ハングアップしたアプリケーションの終了時間
HKCU,"Control Panel\Desktop","WaitToKillAppTimeout",0x00000000,"3000"
; 休止状態を無効に
HKCU,"Control Panel\Desktop","PowerOffActive",0x00000000,"0"
HKCU,"Control Panel\Desktop","PowerOffTimeOut",0x00000000,"0"
; スクリーンセーバーを無効に
HKCU,"Control Panel\Desktop","ScreenSaverIsSecure",0x00000000,"0"
HKCU,"Control Panel\Desktop","ScreenSaveTimeOut",0x00000000,"600"
HKCU,"Control Panel\Desktop","ScreenSaveActive",0x00000000,"0"
; デフォルトの壁紙の変更？
HKCU,"Control Panel\Desktop","OriginalWallpaper",0x00000000,"0"
HKCU,"Control Panel\Desktop","Wallpaper",0x00000000,"0"
HKCU,"Control Panel\Desktop\WindowMetrics","OriginalWallpaper",0x00000000,"0"
HKCU,"Control Panel\Desktop\WindowMetrics","Wallpaper",0x00000000,"0"

; http://trendy.nikkeibp.co.jp/article/tec/winxp/20030912/105896/
; プレースバーを非表示に
HKCU,"Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32","NoPlacesBar",0x00010001,0x00000001

; 「ファイルや URL の履歴をプレイヤーに保存する」のチェックをOFF
HKLM,"SOFTWARE\Microsoft\MediaPlayer\PREFERENCES","DisableMRU",0x00010001,0x00000001
; 「コーデックを自動的にダウンロードする」のチェックをOFF
HKLM,"SOFTWARE\Microsoft\MediaPlayer\PREFERENCES","UpgradeCodecPrompt",0x00010001,0x00000000
; 「メディア ファイルを再生するときライブラリに追加する」のチェックをOFF
HKLM,"SOFTWARE\Microsoft\MediaPlayer\PREFERENCES","AutoAddMusicToLibrary",0x00010001,0x00000000

; http://msdn.microsoft.com/ja-jp/library/cc389844.aspx

; Internet Explorer グループポリシー
; http://technet2.microsoft.com/WindowsServer/ja/library/c07587ec-4a60-4bca-8508-29a4296b72121041.mspx

; Internet Explorer - 詳細設定
; 「署名が無効でもソフトウェアの実行やインストールを許可する」のチェックをOFF
HKCU,"Software\Microsoft\Internet Explorer\Download","RunInvalidSignatures",0x00010001,0x00000000
; 「ダウンロードの完了時に通知する」のチェックをOFF
HKCU,"Software\Microsoft\Internet Explorer\Main","NotifyDownloadComplete",0x00000000,"no"
; 「Web ページのサウンドを再生する」のチェックをOFF
HKCU,"Software\Microsoft\Internet Explorer\Main","Play_Background_Sounds",0x00000000,"no"
; 「イメージを自動的にサイズ変更する」のチェックをOFF
HKCU,"Software\Microsoft\Internet Explorer\Main","Enable AutoImageResize",0x00000000,"no"
; 「イメージ ツールバーを有効にする」のチェックをOFF
HKCU,"Software\Microsoft\Internet Explorer\Main","Enable_MyPics_Hoverbar",0x00000000,"no"
; 「暗号化されたページをディスクに保存しない」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings","DisableCachingOfSSLPages",0x00010001,0x00000001
; 「ブラウザを閉じたときに、[Temporary Internet Files] フォルダを空にする」のチェックをON
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings\Cache","Persistent",0x00010001,0x00000000

; Internet Explorer - コンテンツ - オートコンプリート
; IE6 のパスワードを保存しない
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings","DisablePasswordCaching",0x00010001,0x00000001
; IE6 のオートコンプリートを無効にする
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete","Append Completion",0x00000000,"no"
HKCU,"Software\Microsoft\Windows\CurrentVersion\Explorer\AutoComplete","AutoSuggest",0x00000000,"no"
HKCU,"Software\Microsoft\Internet Explorer\Main","Use FormSuggest",0x00000000,"no"
HKCU,"Software\Microsoft\Internet Explorer\Main","FormSuggest Passwords",0x00000000,"no"
HKCU,"Software\Microsoft\Internet Explorer\Main","FormSuggest PW Ask",0x00000000,"no"

; Internet Explorer - セキュリティ - インターネット
; ファイルのダウンロード時に自動的にダイアログを表示
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3","2200",0x00010001,0x00000000

; Internet Explorer - その他
; 接続数を増やす
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings","MaxConnectionsPerServer",0x00010001,0x00000008
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings","MaxConnectionsPer1_0Server",0x00010001,0x00000008
; 「リンク」フォルダを非表示する
HKCU,"Software\Microsoft\Internet Explorer\Main","LinksFolderName",0x00000000,""
; 特定のファイルをダウンロードした時に出る「セキュリティ警告」を無効にする
HKCU,"Software\Microsoft\Windows\CurrentVersion\Policies\Attachments","SaveZoneInformation",0x00010001,0x00000001
; 「ページを履歴に保存する日数」を 0 に
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings\Url History","DaysToKeep",0x00010001,0x00000000
; インターネット一時ファイルの「使用するディスク領域」を 20MB に
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content","CacheLimit",0x00010001,0x00005000
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Content","CacheLimit",0x00010001,0x00005000
; Cookie を使用するサイトでプライバシーアイコンプロンプトを出さないように
HKCU,"Software\Microsoft\Windows\CurrentVersion\Internet Settings","PrivDiscUiShown",0x00010001,0x00000001

; Process Explorer
HKCU,"Software\Sysinternals",,0x00000010
HKCU,"Software\Sysinternals\Process Explorer","EulaAccepted",0x00010001,0x00000001

; メモ帳トラッパー設定
HKCU,"Software\TakeOne\MemoTrapper\Setting","Editor",0x00000000,"C:\Programs\Sakura Editor\sakura.exe"
HKCU,"Software\TakeOne\MemoTrapper\Setting","HtmlEditor",0x00000000,"C:\Programs\Sakura Editor\sakura.exe"
HKCU,"Software\TakeOne\MemoTrapper\Setting","ParamEditor",0x00000000
HKCU,"Software\TakeOne\MemoTrapper\Setting","FrontEditor",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","ParamHtml",0x00000000
HKCU,"Software\TakeOne\MemoTrapper\Setting","FrontHtml",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","NoTrapExt",0x00000000
HKCU,"Software\TakeOne\MemoTrapper\Setting","NoTrap",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","NoFile",0x00000000,"1"
HKCU,"Software\TakeOne\MemoTrapper\Setting","Ie4Temp",0x00000000,"1"
HKCU,"Software\TakeOne\MemoTrapper\Setting","DoNotepad",0x00000000,"1"
HKCU,"Software\TakeOne\MemoTrapper\Setting","ChangeIeExt",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","IeExt",0x00000000,"htm"
HKCU,"Software\TakeOne\MemoTrapper\Setting","PrintEditor",0x00000000
HKCU,"Software\TakeOne\MemoTrapper\Setting","ParamPrint",0x00000000,"/P"
HKCU,"Software\TakeOne\MemoTrapper\Setting","FrontPrint",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","UseLAN",0x00000000,"0"
HKCU,"Software\TakeOne\MemoTrapper\Setting","LanTempDir",0x00000000,"C:\WINDOWS\Temp"
HKCU,"Software\TakeOne\MemoTrapper\Setting","Rewrite",0x00000000,"1"
HKCU,"Software\TakeOne\MemoTrapper\Setting","CopyLocal",0x00000000,"1"

; Aero Cursors 追加
HKCU,"Control Panel\Cursors\Schemes","Aero Cursors",0x20000,"%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_arrow.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_helpsel.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_working.ani,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_busy.ani,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_prec.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_select.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_pen.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_unavail.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_ns.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_ew.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_nwse.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_nesw.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_move.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_alt.cur,%%SYSTEMROOT%%\Cursors\Aero Cursors\aero_link.cur"

; ハンゲームインストールフォルダ
HKCU,"Software\HanGame.Com\JAPANESE","DefaultHomeSet",0x0,"1"
HKCU,"Software\HanGame.Com\JAPANESE","Home",0x0,"C:\Programs\Hangame\JAPANESE"

; その他メモ等
; http://www.runan.net/program/registry/no.shtml
```

