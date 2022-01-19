# Python Note
 - [install](https://www.python.org/downloads/)
 - [Function lists](https://docs.python.org/ja/3/library/functions.html)
 - [Modules Documents](https://docs.python.org/ja/3/tutorial/modules.html)
 - [Library](https://docs.python.org/ja/3/library/index.html)
1. [改行コード](#anchor1)
2. [外部モジュール](#anchor2)
3. [pip proxy 利用](#anchor3)
4. [python を exe ファイルへ変更](#anchor4)
   - ライブラリインストール
   - exe 化コマンド
5. [Function ( 関数 ) と Method ( メソッド )](#anchor5)
   - 関数定義
6. List Tuple Dict
   - [List ( リスト )](#anchor6a)
   - [Tuple ( タプル )](#anchor6b)
   - [Dict ( 辞書 )](#anchor6c)
7. [例外処理](#anchor7)
8. 文法
   - [for ( データの数だけ繰り返し処理を実行 )](#anchor8a)
   - [if ( 条件分岐で処理を実行 )](#anchor8b)
   - [with ( ファイルを読み込み、自動で閉じる )](#anchor8c)
   - [while ( 条件を設定し、その条件を満たしている間 True 繰り返す )](#anchor8d)

<a id="anchor1"></a>

## 1. 改行コード
 - **\n**
 - 文字列中のバックスラッシュは特殊な動作をします。<br>**print('\\')** の場合 **\\** が表示されます。

<a id="anchor2"></a>

## 2. 外部モジュール
 - 基本的には **import 文は同一フォルダ内から読み込む**ため、**同一フォルダに配置**します。<br>` import < モジュール名 ( ファイル名から .py を取り除いたもの ) > `
 - 使用する際は、**モジュール名.関数名( )** で使用します。

    ```:記述例
    import calc
    sum = calc.add(1, 2)
    ```

- 関数のみ利用したい場合、**関数名( )** のみの記述で使用できます

    ```:書式
    from < モジュール名 > import < 関数名 >
    ```

    ```:記述例
    from calc import add, sub
    sum = add(1, 2)
    ```

<a id="anchor3"></a>

## 3. pip proxy 利用

 ```:コマンド
 pip3 install < packege > --proxy http://username:pass@foo.proxy:8080
 ```

<a id="anchor4"></a>

## 4. python を exe ファイルへ変更
1. ライブラリインストール

    ```:コマンド
    pip install pyinstaller
    ```

2. exe 化コマンド

    ```:コマンド
    pyinstaller --onefile --noconsole < pythonファイル名 >
    ```

    - **--onefile** ：関連するファイルを１つにまとめて exe ファイルを作成
    - **--noconsole** ：コンソール ( コマンドプロンプト ) の黒い画面を表示しない
    - **--onefile** と **--noconsole** は省略可能

<a id="anchor5"></a>

## 5. Function ( 関数 ) と Method ( メソッド )
 - 関数とは**引数**を受け取り、処理結果を**戻り値**として返すものです。
 - メソッドとはある値に対して処理を行うものです。

### 関数定義
 - 定義 ( define ) の略 **def** を使用します。

    ```:記述例
    def < 関数名 > ( < 引数 > ) :
        < 処理 >
        return < 戻り値 >
    ```

## 6. List Tuple Dict
 - リストは変更可能
 - タプルは変更不可能
 - データ型の混合は可能
 - データの順番は**０**から！

<a id="anchor6a"></a>

### List ( リスト )
 - データをカンマ **,** で区切って、角カッコ **[ ]** で囲みます。
 - 例： ` list = [1 , 2 , 3] `

<a id="anchor6b"></a>

### Tuple ( タプル )
 - データをカンマ **,** で区切って、丸カッコ **( )** で囲みます。
 - 例： ` tuple = (1 , 2 , 3) `

<a id="anchor6c"></a>

### Dict ( 辞書 )
 - **キー** から **値 ( バリュー )** を取得します。
 - キーの後に コロン **:** バリューの後にカンマ **,** を付け、波カッコ **{ }** で囲みます。

    ```:記述例
    dict = {
        '001': 'user1',
        '002': 'user2',
    }
    ```

<a id="anchor7"></a>

## 7. Exception ( 例外処理 )

 ```:記述例
 while True:
     try:
         command = input(`python >`)
     expect Expection as e:
         print("予期せぬエラーが発生しました。")
         print("* 種類:", type(e))
         print("* 内容:", e)
 ```

## 8. 文法
 - インデント ( 空白文字 ) を挿入して字下げします。<br>半角スペース４個が推奨らしいです。

<a id="anchor8a"></a>

### for ( データの数だけ繰り返し処理を実行 )

 ```:記述例
 for < 変数 > in < データリスト名 > :
     実行したい処理
 ```

<a id="anchor8b"></a>

### if ( 条件分岐で処理を実行 )

 ```:記述例
 if < 式 > :
     実行したい処理１
 elif < 式 > :
     実行したい処理2
 else:
     条件に当てはまらない場合の処理
 ```

#### False となる値
 - 整数の **0**
 - 実数の **0.0**
 - 空のリスト **[ ]**
 - 空のタプル **( )**
 - 空の辞書 **{ }**
 - 空でない判定 **if < 変数 > :**
 - 空の判定 **if not < 変数 > :**

#### 式に使用する比較演算子
 - **==** 等しい
 - **!=** 等しくない

#### 複数条件を設定可能
 - **if < 式 > and < 式 > :**
 - **if < 式 > or < 式 > :**

#### in 演算子
 - 任意の文字列が含まれている場合に **True** を返します。<br>for 文の in とは別物です。

    ```:記述例
    while True:
     command = input('python > ')
     print(command)
     if 'さようなら' in command:
         break
    ```

<a id="anchor8c"></a>

### with ( ファイルを読み込み、自動で閉じる )
 - open ( ) の戻り値は、as の後ろの変数に代入されます。
 - インデントされている間はファイルを開いている状態です。インデント辞めたところで自動的にファイルが閉じられます。

    ```:記述例
    with open(text.txt) as open_file:
      data = open_file.read()
    print(data) #ここでファイルが閉じられます
    ```

<a id="anchor8d"></a>

### while ( 条件を設定し、その条件を満たしている間 True 繰り返す )
 - プログラムの強制終了は ` Ctrl + C ` です。中断されると **KeyboardInterrupt** と表示されます。
 - 繰り返し処理を終了する場合は **break** を使用します。

    ```:記述例
    count = 5
    while count > 0:
       print(count)
       count = count - 1
    print('プログラム終了')
    ```
