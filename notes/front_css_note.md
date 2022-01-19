# CSS ( Cascading Style Sheets ) Note
1. [CSS ルール](#anchor1)
2. [文法](#anchor2)
   - [ショートハンド](#anchor2a)
   - [リンク](#anchor2b)
   - [エンベッド](#anchor2c)
   - [インライン](#anchor2d)
   - [タイプ ( 要素 ) セレクタ指定](#anchor2e)
   - [ID セレクタ , クラスセレクタ指定](#anchor2f)
   - [子孫セレクタ指定](#anchor2g)
3. CSS プロパティ
   - [ボックスモデル](#anchor3a)
   - [下線・上線・打ち消し線・点滅 ( text-decoration )](#anchor3b)
   - [段落単位の設定 ( text-align , text-indent )](#anchor3c)
   - [行間隔の指定 ( line-heigh )](#anchor3d)
4. 色の指定
   - [RGB ( Red, Green, Blue )](#anchor4a)
   - [HSL , HSLA ( Hue ( 色相 ), Saturation ( 彩度 ), Lightness ( 輝度 ) )](#anchor4b)
   - [文字の色 ( color )](#anchor4c)

<a id="anchor1"></a>

## 1. CSS ルール
 - CSS には継承が存在し、親子関係に従ってスタイルが継承されます。( 文字関連の１部以外は継承されません )
 - １つの要素に対して複数のセレクタを重ねて適用できますが、適用する優先度が存在します。
 - **CSS は「 セレクタ ( どこで？ ) 」「 プロパティ ( 何を？ ) 」「 値 ( どうする？ ) 」の３つで構成されています。**
 - **１行目に文字コードを必ず指定します。**<br>` @charset "utf-8"; `

<a id="anchor2"></a>

## 2. 文法
 - プロパティと値は **：** ( コロン ) で区切ります。
 - プロパティの最後には **；** ( セミコロン ) を付けます。
 - プロパティと値のセットをセレクタ後の **｛　｝** ( 中括弧 ) で囲みます。

    ```:書式
    p {
       color: #ff000;
       font-size:20px;
    }
    ```

<a id="anchor2a"></a>

### ショートハンド
 - １つのプロパティで複数の値をまとめて設定することです。

    ```:書式
    margin: 10px;
    #=> 四辺すべてに同じ値

    margin: 10px 20px;
    #=> 上下 / 左右

    margin: 10px 20px 30px;
    #=> 上 / 左右 / 下

    margin: 10px 20px 30px 0;
    #=> 上 / 右 / 下 / 左
    ```

<a id="anchor2b"></a>

### リンク
 - CSS を外部ファイルとして扱い、それを HTML 内から参照して利用する場合
 - **１つの CSS を複数の HTML にわたって適用できるためこれが主流です。**

    ```:書式
    <head>
       <link rel="stylesheet" href="style.css"(CSSファイルの場所)>
    </head>
    ```

<a id="anchor2c"></a>

### エンベッド
 - **style** 要素を **head 要素内に書き、その中に CSS を記述する場合

    ```:書式
    <style>
        p { font-size:20px; }
    </style>
    ```

<a id="anchor2d"></a>

### インライン
 - HTML のタグに直接記述する場合

    ```:書式
    < p style="font-size:20px;">
    ```

<a id="anchor2e"></a>

### タイプ ( 要素 ) セレクタ指定
 - **文章内の同じ要素全てを対象に適用する場合**

    ```:書式
    h2 { font-size: 50px; }
    #=> 文章内すべての「h2」要素が対象
    ```

<a id="anchor2f"></a>

### ID セレクタ , クラスセレクタ指定
 - **特定のID名やクラス名を持つ要素に適用する場合**
 - ID セレクタは ` # ID名 ` で構成します。
 - クラスセレクタは ` . クラス名 ` で構成します

    ```:書式
    #wrapper {width:980px; }
    #=> IDセレクタ

    .attention {width:980px; }
    #=> クラスセレクタ
    ```

<a id="anchor2g"></a>

### 子孫セレクタ指定
 - **要素の親子関係を利用し、特定の要素内の特定の要素に適用する場合**<br>セレクタ間は半角スペースで区切ります。

    ```:書式
    header h1 { color: #ff0000; }
    #=> header 要素の h1 要素に対して適用する
    ```

## 3. CSS プロパティ

<a id="anchor3a"></a>

### ボックスモデル

#### 内容 ( content ) , パディング ( padding )
 - **要素の内側の間隔を調整します。**

    ```:書式
    padding: 10px;
    ```

<a id="anchor3b"></a>

### ボーダー ( border )
 - **要素の四辺に枠線を付けます。**

    ```:書式
    border: solid(枠線種類) 10px(太さ) #FF00FF(色);
    ```

#### マージン ( margin )
 - **隣り合う要素との距離感を調整します。**

    ```:書式
    margin: 10px; #=> 四辺全て同じ値
    ```

<a id="anchor3c"></a>

### 下線・上線・打ち消し線・点滅 ( text-decoration )
 - **text-decoration** プロパティ<br>点滅に関しては **FireFox** , **Opera** など１部に対応しています。

    ``:書式
    exit-decoration: (underline,undeline,overline);
    ``

<a id="anchor3d"></a>

### 段落単位の設定 ( text-align , text-indent )
 - **text-align** プロパティ<br>**p** 要素などのブロック単位で文字の位置揃えをします。

    ```:書式
    text-align: (left,center,right);
    ```
 - **text-indent** プロパティ<br>文章の段落など１行目のインデント幅を指定します。

    ```:書式
    text-indent: 5em(字下げ幅);
    #=> hanging を指定するとぶら下げ時に省略すると字下げする
    ```

<a id="anchor3e"></a>

### 行間隔の指定 ( line-heigh )
 - **line-height** プロパティ<br>**値を省略すると、行内の１部に大きな文字サイズが存在すればその文字サイズに合わせて拡張されます。**

    ```:書式
    line-height: 1.75(行の高さ);
    ```

## 4. 色の指定

<a id="anchor4a"></a>

### RGB ( Red, Green, Blue )
 - それぞれを **0 ~ 255** の数値、または **0% ~ 100%** で半角カンマで区切って指定します。

    ```:書式
    background-color: rgb(0, 50, 100);
    ```

<a id="anchor4b"></a>

### RGBA  (Red, Green, Blue, Alpha )
 - それぞれを **0 ~ 255** の数値、または **0% ~ 100%** で半角カンマで区切って指定します。<br>**Alpha** とは透明度の値です。

    ```:書式
    background-color: rgba(0, 50, 100, 0.5(Alpha));
    ```

<a id="anchor4c"></a>

### HSL , HSLA ( Hue ( 色相 ), Saturation ( 彩度 ), Lightness ( 輝度 ) )
 - **同じ色を保って明るさや鮮やかさだけを変える際に使用します。**
 - それぞれを **0% ~ 100%** で半角カンマで区切って指定します。

    ```:書式
    color: hsl(128(色相), 40(彩度), 70(輝度));
    color: hsla(128(色相), 40(彩度), 70(輝度), 0.7(不透明度));
    ```

<a id="anchor4d"></a>

### 文字の色 ( color )
 - **color** プロパティ<br>先頭２桁：赤、次２桁：緑、最後２桁：青<br>` #FF00FF ` の形式で書きます。

    ```:書式
    color: #FF00FF;
    ```
