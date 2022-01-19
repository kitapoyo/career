# HTML ( Hyper Text Markup Language ) 備忘録
1. [HTML ルール](#anchor1)
2. [DOCTYPE 宣言 ( Socument Type Definition DTD )](#anchor2)
3. [html 要素](#anchor3)
4. [head 要素](#anchor4)
   - meta 要素
5. body 要素
   - [header 要素](#anchor5a)
   - [nav 要素](#anchor5b)
   - [article 要素](#anchor5c)
   - [section 要素](#anchor5d)
   - [aside 要素](#anchor5e)
   - [div 要素](#anchor5f)
   - [figure 要素](#anchor5g)
   - [footer 要素](#anchor5h)
6. HTML タグ
   - [属性 とは](#anchor6a)
   - [br 改行 ( break )](#anchor6b)
   - [h 見出し ( heading )](#anchor6c)
   - [p 段落 ( paragraph )](#anchor6d)
   - [ul & li 箇条書き ( list item )](#anchor6e)
   - [ol & li 順序箇条書き](#anchor6f)
   - [a リンク ( anchor )](#anchor6g)
   - [img 画像 ( image )](#anchor6h)
   - [link 関連ファイル](#anchor6i)
   - [address](#anchor6j)
   - [small](#anchor6k)
   - [dl & dt & dd 定義リスト](#anchor6l)
   - [table & tr & th & td 表](#anchor6m)
   - [span ( 付けたし )](#anchor6n)
7. form 要素
   - [input 要素](#anchor7a)
   - [送信ボタン](#anchor7b)
   - [ラジオボタン](#anchor7c)
   - [チェックボックス](#anchor7d)
   - [セレクトボックス](#anchor7e)
   - [テキストエリア](#anchor7f)

<a id="anchor1"></a>

## 1. HTML ルール
 - HTML 文章では必ず１つの要素から始まらないといけません。
 - ルートディレクトリに **index.html** が存在しないと Web ページは表示されません。
 - 自サイト以外を要素で指定する場合は必ず**絶対パス**を書きます。<br>同じ Web サイト内のリンクには**相対パス**を書きます。
 - １つの HTML ファイルで **ID 名**は１つのみです。**クラス名**は複数可能です。<br>１つの要素に複数のクラス名を設定できます。( マルチクラス )

<a id="anchor2"></a>

## 2. DOCTYPE 宣言 ( Socument Type Definition DTD )
 - １行目に必ず書くもので **HTML がどのバージョンで作成されているかを宣言するものです。**<br>バージョンの指定がない場合は **HTML5** であることを表します。

    ```:書式
    <!DOCTYPE html>
    ```

<a id="anchor3"></a>

## 3. html 要素
 - すべての要素を内包する、HTML 全体を表す要素です。
 - **lang 属性** は言語を指定することができます。

    ```:書式
    <!DOCTYPE html>
    <html lang="ja">
    </html>
    ```

<a id="anchor4"></a>

## 4. head 要素
 - 文章に関する情報を示す要素です。タイトルや、読み込む CSS ファイル指定などを設定します。
 - **ブラウザには表示されません。** 人ではなく検索エンジンやブラウザなど機械に伝えるための情報を設定します。

    ```:書式
    <head>
      <!-- 文字コード指定 -->
      <meta charset="UTF-8">
      <!-- CSS の読み込み -->
      <link rel="stylesheet" href="style.css"
    </head>
    ```

### meta 要素
 - **属性次第で様々な情報を書きます。**
 - **charset 属性**<br>文字エンコーディングの指定をします。

    ```:書式
    <head>
    <meta charset-"UTF-8">
    </head>
    ```

## 5. body 要素
 - 見出しや画像・表など文章の構成に関する設定をします。**ブラウザに表示されます。**

    ```:書式
    <body>
    </body>
    ```

<a id="anchor5a"></a>

### header 要素
 - ページのヘッダーで、グローバルナビゲーションなどを設定します。

    ```:書式
    <header>
    </header>
    ```

<a id="anchor5b"></a>

### nav 要素
 - ナビゲーションを示すため **ul 要素** , **li 要素** でリストにします。

    ```:書式
    <nav id="global_navi">
      <ul>
        <li class="current"><a href="index.html"></a>HOME</li>
        <li><a href="sample.html">SAMPLE</a></li>
      </ul>
    </nav>
    ```

<a id="anchor5c"></a>

### article 要素
 - セクショニングコンテンツと呼ばれ、文章内にセクションが作成されます。<br>ブログや投稿記事など独立したコンテンツとする場合に使用します。

    ```:書式
    <article>
      <h1>ｈ１見出しが入ります。</h1>
    </article>
    ```

<a id="anchor5d"></a>

### section 要素
 - **article** 要素に内包させることで要素内に意味の区切りを設定できます。

    ```:書式
    <article>
      <h1>h1 見出しが入ります。</h1>
      <section>
        <h2>h2 見出しが入ります。</h2>
      </section>
    </article>
    ```

<a id="anchor5e"></a>

### aside 要素
 - ページ内で補足情報であることを示す要素です。サイドバー専用というわけではありません。

<a id="anchor5f"></a>

### div 要素
 - 特に意味を持たない汎用的コンテナのような要素で、デザインやレイアウトの囲みが必要な場合に使用します。
 - 汎用的なので、意味を分かりやすくするために **ID 名**を設定することが多いです。

    ```:書式
    <div id="wrapper">
    </div>
    ```

<a id="anchor5g"></a>

### figure 要素
 - 画像や表などの要素をさらに他の要素で囲む場合に使用します。

    ```:書式
    <figure>
      <img src="figure.jpg" alt="">
      <figcaption>見出しや説明</figcaption>
    </figure>
    ```

<a id="anchorh"></a>

### footer 要素
 - ページのフッターで、コピーライトなどを設定します。

    ```:書式
    <footer>
      <small>&copy; 2021 Sample.</small>
    </footer>
    ```

## 6. HTML タグ
 - 目印 ( マーク ) を付けて各要素の役割を示すものです。
 - 開始タグ , 終了タグが存在し、終了タグはタグ名の前にスラッシュ ( / ) を付けます。<br>終了タグを省略できるタグや単独で完結するタグも存在します。

<a id="anchor6a"></a>

### 属性 とは
 - 要素の役割を細かく指定するために使用されます。
 - 開始タグの中に書き、**タグと属性の間には必ず半角スペースを入れます。**

<a id="anchor6b"></a>

### br 改行 ( break )
 - 改行がコンテンツの一部である場合に使用します。
 - 意味的に段落として改行を表す際には **p** 要素を使用します。

    ```:書式
    <p>サンプル改行<br>改行されました。</p>
    ```
    <p>サンプル改行<br>改行されました。</p>

<a id="anchor6c"></a>

### h 見出し ( heading )
 - 数値が小さくなるに従って、大きく表示されます。

    ```:書式
    <h1>大見出し</h1>
    <h2>中見出し</h2>
    <h3>小見出し</h3>
    ```
    <h1>大見出し</h1>
    <h2>中見出し</h2>
    <h3>小見出し</h3>

<a id="anchor6d"></a>

### p 段落 ( paragraph )
 - **<p> ~ <\p>** で１つの段落を表します。

    ```
    <p>段落１</p>
    <p>段落２</p>
    <p>段落３</p>
    ```
    <p>段落１</p>
    <p>段落２</p>
    <p>段落３</p>

<a id="anchor6e"></a>

### ul & li 箇条書き ( list item)
 - **ul** 要素 と **li** 要素を使用することで箇条書きを表現します。
 - **ul 要素には必ず１つ以上の li 要素を内包させる**必要があります。

    ```:書式
    <ul>
       <li>箇条書き１</li>
       <li>箇条書き２</li>
       <li>箇条書き３</li>
    </ul>
    ```
    <ul>
       <li>箇条書き１</li>
       <li>箇条書き２</li>
       <li>箇条書き３</li>
    </ul>

<a id="anchor6f"></a>

### ol & li 順序箇条書き
 - 順序が変わると意味が異なる場合に使用します。行頭表示が番号に変わります。

    ```:書式
    <ol>
      <li>箇条書き１</li>
      <li>箇条書き２</li>
      <li>箇条書き３</li>
    </ol>
    ```
    <ol>
      <li>箇条書き１</li>
      <li>箇条書き２</li>
      <li>箇条書き３</li>
    </ol>

<a id="anchor6g"></a>

### a リンク ( anchor )
 - テキストや画像のリンクを指定する際に使用します。
 - ` <p><a><\a><\p> ` のように **p タグ ( 段落 )** の入れ子にします。
 - **href** 属性はリンク先の URL などの PATH を設定します。<br>**href = "#"** と設定するとページの一番上に移動します。

    ```:書式
    <p><a href="https://www.google.com/">Google</a></p>
    ```
    <p><a href="https://www.google.com/">Google</a></p>

    - リンク先を別タブで開く場合は **target** 属性に **_blank** を指定します。

    ```:書式
    <p><a href="https://www.google.com/" target="_blank">Google</a></p>
    ```
    <p><a href="https://www.google.com/" target="_blank">Google</a></p>

<a id="anchor6h"></a>

### img 画像 ( image )
 - **src** 属性に画像のファイルパスを書きます。
 - **alt** 属性に画像が表示されない場合のテキストを書きます。

    ```:書式
    <img src="sample.jpg" alt="サンプルイラスト">
    ```

<a id="anchor6i"></a>

### link 関連ファイル
 - 関連ファイル ( CSS など ) を読み込む際に使用します。
 - **rel** 属性 ( リンクの種類を設定 ) と **href** 属性が**必須**です。

    ```:書式
    <link rel="stylesheet" href="style.css"
    ```

<a id="anchor6j"></a>

### address
 - 直近の **article** 要素や **body** 要素の連絡先情報を示します。

    ```:書式
    <address><p>0120-44-4444</p></address>
    ```
    <address><p>0120-44-4444</p></address>

<a id="anchor6k"></a>

### small
 - 注釈や細目を表す要素として、意味合いを弱める役割をします。

    ```:書式
    <small>&copy; 2021 Sample.</small>
    ```
    <small>&copy; 2021 Sample.</small>

<a id="anchor6l"></a>

### dl & dt & dd 定義リスト
 - ある語句とそれに対する説明を一意にしたリストを示します。

    ```:書式
    <dl><p>定義リスト</p>
      <dt>リスト１</dt>
        <dd>リスト１の説明</dd>
      <dt>リスト２</dt>
        <dd>リスト２の説明</dd>
      <dt>リスト３</dt>
        <dd>リスト３の説明</dd>
    </dl>
    ```
    <dl><p>定義リスト</p>
      <dt>リスト１</dt>
        <dd>リスト１の説明</dd>
      <dt>リスト２</dt>
        <dd>リスト２の説明</dd>
      <dt>リスト３</dt>
        <dd>リスト３の説明</dd>
    </dl>

<a id="anchor6m"></a>

### table & tr & th & td 表
 - **tr** 要素に横１行を設定します。
 - **th** 要素に見出しセルを設定します。
 - **td** 要素にデータを定義します。

    ```:書式
    <table>
      <tr>
        <th>見出しセル１</th>
        <th>見出しセル２</th>
        <th>見出しセル３</th>
      </tr>
      <tr>
        <td>データセル１</td>
        <td>データセル２</td>
        <td>データセル３</td>
      </tr>
    </table>
    ```
    <table>
      <tr>
        <th>見出しセル１</th>
        <th>見出しセル２</th>
        <th>見出しセル３</th>
      </tr>
      <tr>
        <td>データセル１</td>
        <td>データセル２</td>
        <td>データセル３</td>
      </tr>
    </table>

<a id="anchor6n"></a>

### span ( 付けたし )
 - テキストの一部を別の要素にしたい場合などに使用します。

    ```:書式
    <form>
      <input type="radio" name="gender" value="male">男性
      <input type="radio" name="gender" value="femail">女性
      <span>※入力必須</span>
    </form>
    ```
    <form>
      <input type="radio" name="gender" value="male">男性
      <input type="radio" name="gender" value="femail">女性
      <span>※入力必須</span>
    </form>

## 7. form 要素
 - 入力フォームを作成します。属性を使用して、データの送信先や送信方法を指定指定します。
 - **action** 属性は、受け手となるプログラムへのパスや送信先のプログラムを指定します。
 - **method** 属性は、データの通信方式として **get** , **post** を指定します。

    ```:書式
    <form action="program.cgi" method="post">
    </form>
    ```

<a id="anchor7a"></a>

### input 要素

|要素|説明|
|---|---|
|required|**入力必須項目を指定** ( 未入力の場合は警告が表示 )|
|name|部品の名前を指定|
|size|部品の幅を指定|
|type|指定する値によって様々な部品を作成<br>**radio** , **checkbox** タイプに関しては、複数項目から選択するためグループ化する設定が必要|

|属性|説明|
|---|---|
|name|同じ値を指定し、グループであることを示す|
|value|項目が選択された際に、サーバーへ送信する値を指定|
|label|チェックボックスがボックスのみでなく、各項目名のクリックで選択可能|

<a id="anchor7b"></a>

### 送信ボタン

 ```:書式
 <form>
   <input type="submit" value="送信">
 </form>
 ```

<a id="anchor7c"></a>

### ラジオボタン

 ```:書式
 <form>
   <input type="radio" name="gender" value="male">男性
   <input type="radio" name="gender" value="femail">女性
  </form>
 ```

<a id="anchor7d"></a>

### チェックボックス
 - **label** 要素で囲むことで、項目名をクリックしても反応するようになります。

    ```:書式
    <form>
      <input type="checkbox" name="food" value="白米">白米
      <input type="checkbox" name="food" value="パン">パン
      <input type="checkbox" name="food" value="麺">麺
    </form>
    ```

<a id="anchor7e"></a>

### セレクトボックス
 - **select & option** 要素で囲むことで、プルダウン型のセレクトボックスを作成します。

    ```:書式
    <form><p>セレクトボックス</p>
      <select>
        <option value="A">A型</option>
        <option value="B">B型</option>
        <option value="O">O型</option>
        <option value="AB">AB型</option>
      </select>
    </form>
    ```

<a id="anchor7f"></a>

### テキストエリア
 - **textarea** 要素で囲むことで、入力フィールドのテキストエリアを作成します。
 - **rows** 属性と **cols** 属性で高さと横幅を指定できます。

    ```:書式
    <form>
      <textarea rows="1" cols="5"></textarea>
    </form>
    ```
