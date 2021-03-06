+++
title = "[PukiWiki:wiki] Windows/XP/Integration/Windows_Updates_Downloader/Schema"
date = "2008-12-10T09:33:23Z"
+++

# スキーマ解説  {#w44dc603}
Windows Updates Downloader スキーマの詳細。


## Example  {#h62497a7}

```
<?xml version="1.0" encoding="utf-8"?>
<updatelist product="" platform="" language="" lastupdate="" xmlns="http://wud.jcarle.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://wud.jcarle.com http://wud.jcarle.com/wud.xsd">

<categories>
  <category id=""></category>
</categories>

<updates>
  <update id="" category="" publishdate="" article="">
    <title></title>
    <description></description>
    <filename></filename>
    <url></url>
  </update>
</updates>

</updatelist>

```

## Step 1  {#yc9bf480}

```
<updatelist product="( Operating System )" platform="( Platform )" language="( Language Code )" lastupdate="( Last Update)" xmlns="http://wud.jcarle.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://wud.jcarle.com http://wud.jcarle.com/wud.xsd">
```

- **( Operating System )**
    -  Windows OS の種類を下記の中から選択する。
    -  Windows XP, Windows XP x64, Windows 2000 Workstation, Windows 2000 Server
- **( Platform )**
    -  通常は x86 を選択する。
    -  x86, x64, ia64, amd64
- **( Language Code )**
    -  Microsoft language codes の中から選択する。
    -  通常は JPN を選択する。
- **( Last Update)**
    -  最終更新日を YYYY-MM-DD 形式で入力する。

### Microsoft language codes  {#p6c203c2}

```
ARA - Arabic
CHS - Chinese (Simplified)
CHT - Chinese (Traditional)
CSY - Czech
DAN - Danish
NLD - Dutch
ENU - English
FIN - Finnish
FRA - French
DEU - German
ELL - Greek
HEB - Hebrew
HUN - Hungarian
ITA - Italian
JPN - Japanese
KOR - Korean
NOR - Norwegian (Bokmål)
PLK - Polish
PTB - Portuguese (Brazil)
PTG - Portuguese (Portugal)
RUS - Russian
ESN - Spanish
SVE - Swedish
TRK - Turkish

```

## Step 2  {#k4cdf9e0}

```
<category id="( Category ID )">( Category Title)</category>
```

- **( Category ID )**
    -  カゴテリ毎にユニークな整数の ID を指定する。
- **( Category Title)**
    -  カゴテリ 1 は Critical Updates 、 カゴテリ 2 は Service Packs を指定する？

## Step 3  {#v487d50e}

```
<update id="( Update ID )" category="( Category ID )" publishdate="( Publish Date )" article="( Article URL )">
 <title>( Title )</title>
 <description>( Description )</description>
 <filename>( Local Filename )</filename>
 <url>( Remote URL )</url>
</update>
```

- **( Update ID )**
    -  Hotfix 毎にユニークな ID を指定する。
- **( Category ID )**
    -  Step 2 で指定したカゴテリ ID を指定する。
- **( Publish Date )**
    -  Hotfix がリリースされた日付を YYYY-MM-DD 形式で指定する。
- **( Article URL )**
    -  Hotfix の詳細リンク。
- **( Title )**
    -  Windows Updates Downloader に表示されるタイトル。
- **( Description )**
    -  Windows Updates Downloader に表示される説明文。
- **( Local Filename )**
    -  ローカルに保存するファイル名。
    -  .Net Framework 1.1 と 2.0 は同じファイル名なので明示的に指定する必要がある。
- **( Remote URL )**
    -  Hotfix のダウンロード URL 。
