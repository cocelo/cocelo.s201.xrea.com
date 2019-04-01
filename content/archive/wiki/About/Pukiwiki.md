+++
title = "[PukiWiki:wiki] About/Pukiwiki"
date = "2010-08-08T03:28:52Z"
+++


# WikiFarm  {#lf1a7ae4}

[ディレクトリの分割（セキュリティの強化、WikiFarmの構築\) - PukiWiki Plus!](http://pukiwiki.cafelounge.net/plus/?Documents%2FWikiFarm "ディレクトリの分割（セキュリティの強化、WikiFarmの構築\) - PukiWiki Plus!")

ディレクトリ構成としては以下の通り。


```
root
|--- public_html ( 公開エリア )
|    |--- image
|    |--- skin
|    `--- wiki
|         |--- .htaccess
|         `--- index.php
`--- wiki ( 非公開エリア )
     |--- common ( 共通コンポーネント )
     |    |--- extend
     |    |--- init
     |    |--- lib
     |    |--- locale
     |    |--- plugin
     |    `--- tools
     `--- data ( Wiki データ )
          `--- wiki
               |--- attach
               |--- backup
               |--- cache
               |--- counter
               |--- diff
               |--- log
               |--- trackback
               `--- wiki
```

## ディレクトリ分割  {#q7084526}

まずはディレクトリの分割から。
以下のようなバッチファイルを作成する。


```
@echo off

set SRC=""
set DIR=""
set COMMON="%DIR%\wiki\common"
set DATA="%DIR%\wiki\data\wiki"
set PUBLIC="%DIR%\public_html"
set WIKI="%PUBLIC%\wiki"

echo .svn>exclude.txt
echo index.html>>exclude.txt
echo .htaccess>>exclude.txt

xcopy %SRC%\doc %COMMON%\doc /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\extend %COMMON%\extend /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\init %COMMON%\init /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\lib %COMMON%\lib /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\locale %COMMON%\locale /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\plugin %COMMON%\plugin /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\tools %COMMON%\tools /e /i /h /y /exclude:exclude.txt
copy /y %SRC%\* %COMMON%

xcopy %SRC%\attach %DATA%\attach /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\backup %DATA%\backup /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\cache %DATA%\cache /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\counter %DATA%\counter /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\diff %DATA%\diff /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\log %DATA%\log /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\trackback %DATA%\trackback /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\wiki %DATA%\wiki /e /i /h /y /exclude:exclude.txt

echo .svn>exclude.txt

xcopy %SRC%\image %PUBLIC%\image /e /i /h /y /exclude:exclude.txt
xcopy %SRC%\skin %PUBLIC%\skin /e /i /h /y /exclude:exclude.txt

md %WIKI%
copy /y %SRC%\.htaccess %WIKI%
copy /y %SRC%\index.php %WIKI%

pause

del exclude.txt

exit
```

## index.php の編集  {#g5839919}

公開ディレクトリ以下のindex.phpを編集して、非公開エリアに置いてあるPukiWikiのディレクトリを指定する。


```
define('SITE_HOME',	'../../wiki/common/');
define('DATA_HOME',	'../../wiki/data/wiki/');

define('ROOT_URI', '');
define('WWW_HOME', '');
```

# Link  {#b6d54480}
- [PukiWiki/Install/xrea.com - PukiWiki-official](http://pukiwiki.sourceforge.jp//?PukiWiki%2FInstall%2Fxrea.com "PukiWiki/Install/xrea.com - PukiWiki-official")
