# JavaScript Note
1. [変数の定義](#anchor1)
   - [let](#anchor1a)
2. [定数の定義](#anchor2)
   - [const](#anchor2a)
3. [配列の定義](#anchor3)
4. [条件式](#anchor4)
   - [論理演算子](#anchor4a)
   - [if 文](#anchor4b)
   - [switch 文](#anchor4c)
5. [繰り返し処理](#anchor5)
   - [while 文](#anchor5a)
   - [do ~ while 文](#anchor5b)
   - [for 文](#anchor5c)
6. [関数の定義](#anchor6)
7. [DOM ( Document Object Model )](#anchor7)
   - [特定の ID を持つ HTML 要素を取得](#anchor7a)
   - [HTML 要素の内容を変更](#anchor7b)
   - [要素のスタイルを変更](#anchor7c)
   - [要素の追加](#anchor7d)
   - [要素の削除](#anchor7e)
8. [API ( Application Programming Interface )](#anchor8)
   - [Web API のデータ形式](#anchor8a)
   - [API ( zipcloud )](#anchor8b)
9. [yarn](#anchor9)
   - 動作
   - 基本構文
   - アップグレード
10. [JQuery](#anchor10)
    - [ダウンロード](#anchor10a)
    - [HTML ファイルから jQuery を読み込む場合](#anchor10b)
    - [CDN ( データ配信に特化したネットワーク ) から利用する場合](#anchor10c)
    - [プラグインの利用](#anchor10d)
    - [jQuery を利用したプログラムの記述場所](#anchor10e)
    - [要素を選択するためのセレクタの書き方](#anchor10f)
    - [アニメーションの設定](#anchor10g)

<a id="anchor1"></a>

## 1. 変数の定義
 - 変数は有効範囲 ( ブロックスコープ ) によって定義する方法が異なります。
 - ブロック内で定義した場合は、ブロックの中のみで有効です。

<a id="anchor1a"></a>

### let
 - ` let 変数名 ; ` ： 定義のみの場合
 - ` let 変数名 = 値 ; ` ： 定義と同時に変数に値を代入する場合

<a id="anchor2"></a>

## 2. 定数の定義
 - 定数 ( 値を代入すると、変更ができない ) ものです。
 - ブロック内で定義した場合は、ブロックの中のみで有効です。

<a id="anchor2a"></a>

### const
 - ` const 定数名 ; ` ： 定義のみの場合
 - ` const 定数名 = 値 ; ` ： 定義と同時に変数に値を代入する場合

<a id="anchor3"></a>

## 3. 配列の定義
 - データをまとめて管理・表現するものです。
 - 配列に所属するデータはインデックス ( 管理番号 ) が割り振られ、インデックスを指定することでデータを参照します。
 - ` let array = [ データ１, データ２，データ３ ] ; `

<a id="anchor4"></a>

## 4. 条件式
 - 条件式の結果は **true** か **false** になります。
 - **{ }** で囲ったものをブロックと呼び複数の処理を書くことができます。本来は１文しか書けません。

<a id="anchor4a"></a>

### 論理演算子
 - **&&** ：論理積
 - **||** ：論理和
 - **!** ：否定

<a id="anchor4b"></a>

### if 文
 - 戻り値が **true** の場合に処理を実行します。

    ```:書式
    if ( 条件式 ) {
      実行する処理１ ;
      実行する処理２ ;
      実行する処理３ ;
    }
    ```

 - **if ~ else** 文：条件を満たさない場合の処理も記載できます。

    ```:書式
    if ( 条件式 1 ) {
      実行する処理１ ;
    } else if ( 条件式 2){
      実行する処理２ ;
    } else {
      全ての条件式に当てはまらない場合に実行する処理 ;
    }
    ```

<a id="anchor4c"></a>

### switch 文
 - 場合分けに便利な構文です。 上の条件から比較していくので記載順序に注意します。
 - 変数と比較する値にの最後にコロン ( : ) を付けます。
 - 処理の終わりには **break ;** を書きます。記載がない場合で複数の条件にマッチした場合、処理を複数実行します。

    ```:書式
    switch ( 変数 ) {
      case 変数と比較する値 :
        変数が該当の値の場合に実行する処理 ;
        break ;
      default :
        どの場合にも当てはまらない場合に実行する処理 ;
    }
    ```

<a id="anchor5"></a>

## 5. 繰り返し処理
 - **break** ：繰り返し処理を中断します。
 - **continue** ：繰り返し処理を飛ばします。繰り返し処理自体は中断されません。

<a id="anchor5a"></a>

### while 文
 - 条件式が **true** である限り、処理を実行します。

    ```:書式
    while ( 条件式 ) {
      実行する処理 ;
    }
    ```

<a id="anchor5b"></a>

### do ~ while 文
 - 条件に一致しない場合でも、一度は処理を実行する場合に使用します。

    ```:書式
    do {
      実行したい処理 ;
    } while ( 条件式 )
    ```

<a id="anchor5c"></a>

### for 文
 - 回数の決まった繰り返し処理を実行する場合に使用します。

    ```:書式
    for ( let i = 1 ; i < 100 ; i++ ) {
    実行したい処理 ;
    }
    ```

<a id="anchor6"></a>

## 6. 関数の定義
 - function の後に関数名を書き、ブロックの中に実行したい処理を記載します。
 - **return** は関数の終了を意味します。**result** には呼び出し元に返す戻り値を指定することができます。
 - デフォルト引数を定義することで、引数無しで関数を呼び出すことができます。
 - 関数の中で定義した変数は、その関数の中でのみ有効です。

    ```:書式
    function 関数名 ( 引数１ = デフォルト値１ , 引数２ = デフォルト値２) {
      実行したい処理 ;
      return result ;
    }
    ```

<a id="anchor7"></a>

## 7. DOM ( Document Object Model )
 - オブジェクトを通じて HTML 文章にアクセスする仕組みのことです。
 - HTML 文章 の構造をツリー状のオブジェクトで表したものです。
 - **HTML 要素の場合、変数に代入された値を変更すると、コピー元の HTML 要素も変更されます。**<br>変数には元のデータを参照するための情報が記録されているためです。

<a id="anchor7a"></a>

### 特定の ID を持つ HTML 要素を取得
 - **getElementById** メソッドを使用します。

    ```:書式
    let element = document.getElementById ( " IDの値 " ) ;
    ```

<a id="anchor7b"></a>

### CSS セレクタを使用して要素を取得
 - **querySelector** メソッドを使用します。

    ```:書式
    document.querySelector( " セレクタ名 " ) ;
    ```

<a id="anchor7c"></a>

### HTML 要素の内容を変更
 - **innerHTML** メソッドを使用します。<br>内容にタグが含まれる場合は、ブラウザがタグを解釈して、新しい HTML 要素が作られます。

    ```:書式
    要素.innerHTML = " 変更する内容 " ;
    ```

<a id="anchor7d"></a>

### 要素のスタイルを変更
 - 各要素がもつ style プロパティを利用します。

    ```:書式
    element.style.color = "#FF0000" ; #=> 文字色を変更する場合。
    ```

<a id="anchor7e"></a>

### 要素の追加
1. **document.createElement** メソッドで要素を作成します。
2. **setAttribute** メソッドで属性を指定します。
3. **innerHTML** メソッドで内容を記載します。
4. **insertBefore**( 追加する要素 , 追加する要素の前の要素 ) メソッドで追加を行います。

    ```:書式
    first = document.createElement( "div" ) ;
    first.setAttribute( "id" , "first" ) ;
    first.innerHTML = "<p>要素を追加</p>" ;
    practice.insertBefore(first, null ) ;
    ```

<a id="anchor7f"></a>

### 要素の削除
1. **parentElement** メソッドでオブジェクトを取得します。
2. **removeChild** メソッドで子要素を削除します。

<a id="anchor8"></a>

## 8. API ( Application Programming Interface )
 - Web を通じて利用できるサービスと、そのサービスを利用するためのルールです。

<a id="anchor8a"></a>

### Web API のデータ形式
 - **JSON ( JavaScript Object Notation )**：JavaScript のオブジェクトを通信や保存に適した形にしたものです。
 - **JSONP ( JSON with padding )**：通常の JSON ではドメインをまたぐ通信はできませんが、この問題を解決したものです。

<a id="anchor8b"></a>

### API ( zipcloud )
 - [zipcloud](http://zipcloud.ibsnet.co.jp/doc/api)：郵便番号検索 API です。
 - 以下の URL に郵便番号 ( ハイフン可 ) を追記してブラウザのアドレスバーに入力してアクセスします。<br>` https://zipcloud.ibsnet.co.jp/api/search?zipcode= `<br>**=** の後ろに郵便番号を入力してください。以下のように郵便番号に応じてリクエストが返ります。

<a id="anchor9"></a>

## 9. yarn
 - JavaScript で開発されたモジュールを管理するためのパッケージ管理システムの１つです。

### 動作
1. 実行時に **yarn.lock** ファイルの有無を調べます。
2. 無ければ **packege.json** ファイルの中身を参照し、**JavaScript** パッケージ群をインストールします。
3. インストールしたパッケージリストとバージョンを **yarn.lock** ファイルに書き込みます。
 - yarnm.lock が存在する場合<br>**yarn.lock** ファイルの中身を参照して **JavaScript** パッケージ群をインストールします。

### 基本構文
 - **--check-files** オプションを使用すると、すでにインストールされたファイルが削除されていないか確認します。

    ```:コマンド
    yarn
    ```

### アップグレード
 - インストール済の **JavaScript** パッケージ群をアップグレードしたい場合は以下のコマンドを使用します。
 - この場合 **yarn.lock** ファイルが存在しても無視されます。

    ```:コマンド
    yarn upgrade
    ```

<a id="anchor10"></a>

## 10. JQuery
 - [リファレンス](https://api.jquery.com/)<br>[日本語版リファレンス](http://semooh.jp/jquery/)
 - DOM 操作をよりシンプルに記述できます。<br>ブラウザごとの細かな挙動を意識しなくて済むようになります。<br>アニメーションに便利な関数を豊富に利用できます。<br>Ajax 処理を簡単に記述できます。

<a id="anchor10a"></a>

### ダウンロード
 - [ダウンロードサイト](https://jquery.com/)
 - **Download** > **Download the compressed, production jQuery 3.x.x**

<a id="anchor10b"></a>

### HTML ファイルから jQuery を読み込む場合
 -  jQuery ファイルが js フォルダ内にある場合

    ```:書式
    <script src="js/jquery3.6.0.js"></script>
    ```

<a id="anchor10c"></a>

### CDN ( データ配信に特化したネットワーク ) から利用する場合
 - [CDN 情報サイト](https://code.jquery.com/)

    ``:書式
    script
    rc="https://code.jquery.com/jquery-3.6.0.js"
    ntegrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
    rossorigin="anonymous"></script>
    ``

<a id="anchor10d"></a>

### プラグインの利用
 - jQuery プラグインは jQuery を使って作られた拡張するプログラムです。
 - 利用方法は各プラグインによって異なるので、利用時はライセンスなどを確認しましょう。
 - 基本的な書き方は **$** ( セレクタ ) と書いて目的の要素を指定し、メソッドを利用して様々な処理を実行します。
 - **\$( )** は jQuery メソッドの短縮形のため下記２つは同じ意味となります。<br>**$** には jQuery オブジェクトが代入されています。

    ```:書式
    $("#menu dt ").slideToggle( ) ;
    #=> セレクタで要素を指定し、メソッドで操作する。
    ```

    ```:書式
    $("#menu dt" ).slideToggle( ) ;
    jQuery("#menu dt" ).slideToggle( ) ;
    ```

 - イベント設定 ( body 要素にクリックイベントを登録する場合 )

    ```:書式
    $("body").click(function() {
        実行したい処理 ;
    } ) ;
    ```

<a id="anchor10e"></a>

### jQuery を利用したプログラムの記述場所
 - HTML の要素の準備ができたときに発生する **ready** イベントを利用します。省略形も存在します。

    ```:書式
    $("document").ready(function( ) {
        プログラムを記載
    } ) ;
    ```

    ```:書式
    省略版
    $(function( ) {
        プログラムを記載
    } ) ;
    ```

<a id="anchor10f"></a>

### 要素を選択するためのセレクタの書き方
 - jQuery メソッド **$( )** を利用し、HTML 要素を特定するためのセレクタを指定します。

    ```:書式
    基本構文
    $("#sample") ;
    #=> id = "sample" の要素を選択

    $("#sample p") ;
    #=> id = "sample" の要素の子孫要素である p 要素を選択

    $(".sample > p") ;
    #=> class = "sample" の要素の子孫要素である p 要素を選択
    ```

<a id="anchor10g"></a>

### アニメーションの設定
 - **animate** メソッドは、指定した時間をかけてスタイルを徐々に変化させる動作をします。

    ```:書式
    $("セレクタ").animate( {
        プロパティ名: プロパティ値,
        プロパティ名: プロパティ値,
    } , 変化時間 ) ;
    ```
