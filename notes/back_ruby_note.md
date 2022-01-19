# Ruby Note
1. [はじめに](#anchor1)
2. [参考サイト](#anchor2)
3. [基本情報](#anchor3)
4. [Gem](#anchor4)
   - バージョン指定でインストール
5. [Bundler](#anchor5)
   - 古いバージョンの Gem を使用する場合
   - 使い方
6. [Ruby を exe ファイルへ変更](#anchor6)
7. [Color List](#anchor7)
8. [&:メソッド名 記法](#anchor8)
9. [配列を複数の引数として渡す ( splat 展開 )](#anchor9)
10. [可変長引数](#anchor10)
11. [ハッシュ 構文](#anchor11)
    - ハッシュの初期値
12. [キーワード引数](#anchor12)
    - 基本構文
    - 任意のキーワードの受付

<a id="anchor1"></a>

## 1. pipe.catch_a_star
 - [ホワイの(感動的)rubyガイド 第4章 より](http://www.aoky.net/articles/why_poignant_guide_to_ruby/chapter-4.html#section4)

    ```
    見ての通り、哀れな小さな星を集める仕事はあなたにかかっているのだ。
    あなたがやらなければ、それは単に消えてしまう。
    メソッドを使ったときはいつも何かが返ってくる。
    あなたはそれを無視してもいいし使ってもいい。

    メソッドが返す答えを使えるようになると、あなたは支配できるようになる。
    ```

<a id="anchor2"></a>

## 2. 参考サイト
 - [Rubular ( 正規表現確認サイト )](https://rubular.com/)
 - [るりまサーチ ( リファレンスマニュアル検索サイト )](https://docs.ruby-lang.org/ja/search/)

<a id="anchor3"></a>

## 3. 基本情報
 - オブジェクト指向言語で動的型付け言語です。文字列や数値、配列などすべてがオブジェクトです。
 - 改行が文の区切りとなります。<br>**; ( セミコロン )** や **\ ( バックスラッシュ )** で明示的に改行を表すことができます。
 - 数値と文字列は別のものとして認識します。暗黙の型変換はないため、**数値と文字列は計算や連結ができません。**
 - 式展開 **#{ }** を使った場合は、自動的に **to_s** メソッドが呼ばれるため、文字列に変換する必要ありません。
 - 変数への代入は **変数 = オブジェクト** で表します。変数を宣言するのみの構文は存在しません。
 - 文字列を付く際は **ダブルクオート ( " )** または **シングルクオート( ' )** で囲むことが一般的です。<br>シングルクオートだと式展開や改行文字が文字列となることに注意しましょう。
 - **変数の代入自体が戻り値を持ちます。**
 - 空行はプログラム上では無視されます。改行は **\n** で表します。
 - 複数行のコメントは **=begin コメント =end** で囲んで表現します。
 - 対話モードは、コマンドプロンプトにて **irb** と入力します。終了する際は **exit** と入力します。
 - **変数にはオブジェクトそのものではなく、オブジェクトへの参照が格納されます。**
 - **ドット ( . )** の右辺は必ずメソッドになります。名前空間を区切ったり定数を指定できません。

<a id="anchor4"></a>

## 4. Gem
 - インストール

    ```:書式
    gem install < Gem 名 >
    gem install < Gem 名 > -p http:// < username > : < password > @ < domain > : < port >
    ```

### バージョン指定でインストール
 - 指定したバージョンで固定<br>**gem install 'rails', '5.1.6'**
 - 5.16 ~ 5.19 までの間なら使用可能<br>**gem install 'rails', '~>5.1.6'**
 - 5.16 以上 のバージョンでなければ使用できない<br>**gem install 'rails', '>=5.1.6'**
 - 5.16 以上、5.6 未満のバージョンでなければ使用できない<br>**gem install 'rails', '>=5.1.6', '5.6'**

<a id="anchor5"></a>

## 5. Bundler
 - インストール ( 標準でインストールされている可能性があります )

    ```:コマンド
    gem install bundler
    ```

 - バージョン確認

    ```:コマンド
    bundler -v
    ```

### 古いバージョンの Gem を使用する場合
 - Gemfile に記載されたバージョンで Ruby を実行できます。

    ```:書式
    bundler exec ruby '該当のバージョンが記載されたファイル名'
    ```

### 使い方
1. init を実行

    ```:コマンド
    bundler init
    ```

    - **Writing new Gemfile to /~/Gemfile** が表示されれば成功です。
2. 作成したファイルに Gem 名を記述<br>以下 Rails の場合の設定例です。

    ```:記述例
    # frozen_string_literal: tru
    source "https://rubygems.org
    git_source(:github) {|repo_name| "https://github.com/#{repo_name}"
    gem 'rails'
    ```

3. アップデート

    ```:コマンド
    bundler update
    ```

4. インストール

    ```:コマンド
    bundler install
    ```

    - 実行すると **Gemfile.lock** ファイルが作成されますが、削除してはいけません。
    - ` --path vendor/bundle ` をオプションで環境別に Gem をインストールできます。<br>その場合、` bundle exec rails new . ` のような形でコマンドを打つことになります。

<a id="anchor6"></a>

## 6. Ruby を exe ファイルへ変更
1. ライブラリインストール

    ```:コマンド
    gem install ocra libui-ruby
    ```

2. コマンド実行

    ```:書式
    ocra < ファイル名 > --dll ruby_builtin_dlls\libssp-0.dll --dll ruby_builtin_dlls\libgmp-10.dll
    ```

<a id="anchor7"></a>

## 7. Color List

 ```:設定例
 class Color
     RED = "\e[31;1m"
     GREEN = "\e[32;1m"
     YELLOW = "\e[33;1m"
     BLUE = "\e[34;1m"
     MAGENTA = "\e[35;1m"
     CYAN = "\e[36;1m"
     WHITE = "\e[37;1m"
 end
 puts Color::RED + "Hello" + Color::WHITE
 ```

<a id="anchor8"></a>

## 8. &:メソッド名 記法
 - メソッドにブロックを渡す代わりに **&:メソッド名** という引数を渡すことができます。

    ```:例
    strings = [1, 2, 3, 4].map(&:to_s)
    p strings
    #=> ["1", "2", "3", "4"]
    ```

<a id="anchor9"></a>

## 9. 配列を複数の引数として渡す ( splat 展開 )
 - 配列の要素を**複数の引数**として渡す場合は **\*** を配列の前に置きます。

    ```:例
    a = []
    b = [4, 5, 6]
    p a.push(b)
    #=> [[4, 5, 6]]

    p a.push(*b)
    #=> [[4, 5, 6], 4, 5, 6]
    ```

<a id="anchor10"></a>

## 10. 可変長引数
 - 個数に制限のない引数のことで、配列として受け取れます。引数の手前に **\*** を付けます。

    ```:例
    def spell(*names)
       puts "She cast magic, #{names.join(" and ")}."
    end

    spell("Fire")
    #=> She cast magic, Fire.

    spell("Fire", "Ice")
    #=> She cast magic, Fire and Ice.
    ```

<a id="anchor11"></a>

## 11. ハッシュ 構文
1. ` 変数 = { 'key1' => 'value1',  'key2' => 'value2' } `
2. ` 変数 = { key1: 'value1', key2: 'value2' } `

### ハッシュの初期値
 - 存在しない値を **nil** 以外で返す場合は **Hash.new** で初期値を引数で指定します。

    ```:例
    #通常
    hash = Hash.new('default')

    #ブロック使用
    hash = Hash.new {'default'}
    ```

<a id="anchor12"></a>

## 12. キーワード引数
 - ハッシュの表記 **シンボル： 値** を利用して、メソッドの引数を分かりやすくできる機能です。
 - キーワード引数 ( シンボル ) に引数の意味を込めた値を指定することで、役割を明確化できます。
 - キーワード引数を使用するメソッドに存在しないキーワードを指定するとエラーになります。

### 基本構文
 - 引数のデフォルト値は省略することもできます。

    ```:例
    def メソッド名 ( キーワード引数１: デフォルト値１, キーワード引数２: デフォルト値２ )
        # 省略
    end

    メソッド名 ( キーワード引数１: 値１, キーワード引数２: 値２ )
    ```

### 任意のキーワードの受付
 - **\*\*** を付けた引数にはキーワードで指定されていないキーワードがハッシュとして格納されます。

    ```：例
    def メソッド名 ( キーワード引数１: デフォルト値１, **others )
        # 省略
    end

    メソッド名 ( キーワード引数１: 値１, キーワード引数２: 値２ )
