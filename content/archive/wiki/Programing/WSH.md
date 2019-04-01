+++
title = "[PukiWiki:wiki] Programing/WSH"
date = "2009-02-14T20:01:58Z"
+++


# WSH (Windows Script Hosting)  {#n15bb11a}
javascriptの勉強を兼ねてjscriptをベースに扱っていきます。
世の中のWSHを扱っている人は大体vbscriptがベースっぽいけどｷﾆｼﾅｲ！

# Tips  {#j48f1c1d}

## コメント  {#i8b76155}

```

/*
  コメント
*/
```

## 変数  {#b07a36c1}

```
var i; // 変数iを宣言

var i = 0; // 変数iを数値で初期化

var i = "0"; // 変数iをリテラルで初期化

var i,j,k; // 変数i,j,kを宣言

var i = 0, j, k; // 変数iを数値で初期化、j,kを宣言

var i = 0 + 1; // 変数iを計算した数値で初期化
/*
  + 足し算
  - 引き算
  * 掛け算
  % 割り算
*/

var i = "0" + "1"; // 変数iをリテラルで結合したもので初期化
```

## 関数  {#mb09b4ba}

```
function func(arg) { // 変数argは引数
  var index = 0;
  return index; // indexが戻り値
}
```

## オブジェクト、メソッド、プロパティ  {#s5cd747b}

```
var ary = new Array("1", "2", "3"); // 配列の宣言
WScript.Echo(ary.toString()); // メソッド呼び出し
WScript.Echo(ary.length); // プロパティ呼び出し
```

## 制御文  {#y043ee59}

```
if (WScript.Version) {
  WScript.Echo("Hello World!!!");
} else if (hogehoge()) {
  WScript.Echo("hogehoge");
} else {
  WScript.Echo("fugafuga");
}
/*
  戻り値がtrueの場合、その構文が実行される。
  上記の場合、必ずHello World!!!が表示される。
*/
```


```
var ary = new Array("1", "2", "3");

while (ary.length < 10) {
  WScript.Echo(ary[i]);
  i++;
}
```

# リンク  {#a6ea1354}
Tipsとか。

## 入門  {#z31c0f25}
[JScript](http://msdn.microsoft.com/ja-jp/library/cc427807.aspx "JScript")
[JSHelp - JScript入門](http://www.bosagami.net/jshelp/ "JSHelp - JScript入門")
[[WSH入門] バッチファイルからWSHへ インデックス](http://www.jfast.net/~saikawa/wsh/ "[WSH入門] バッチファイルからWSHへ インデックス")
