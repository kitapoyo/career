# Rails RSpec
1. [規約](#anchor1)
   - [インストール](#anchor1a)
   - [be マッチャー](#anchor1b)
2. テストコード 実行
   - [一括実行](#anchor2a)
   - [ディレクトリ指定](#anchor2b)
   - [個別ファイル指定](#anchor2c)
   - [特定の example 指定](#anchord)
3. [保留](#anchor3)
   - [pending メソッド](#anchor3a)
4. RSpec 初期設定
   - [Gemfile 記述](#anchor4a)
   - [コマンド実行](#anchor4b)
   - [spec_helper.rb 編集](#anchor4c)
5. example 構文
   - [example とは](#anchor5a)
   - [example グループ](#anchor5b)
   - [変数 s の文字数が 4 であることをチェックするテストコード](#anchor5c)
   - [example メソッド ( it メソッド )](#anchor5d)
   - [xexample メソッド ( 保留 )](#anchor5e)
6. [expect メソッド](#anchor6)
   - [not_to](#anchor6a)
   - [ブロック](#anchor6b)
7. RSpec によるルーティングテスト
   - [ルーティングの expect メソッド](#anchor7a)
   - [be_routable メソッド](#anchor7b)
   - [テスト用ファイルを格納するディレクトリと spec.rb を作成](#anchor7c)
   - [テストの実行](#anchor7d)
8. [Factory Bot](#anchor8)
   - [spec ファイルに記述](#anchor8a)
   - [Factory の定義](#anchor8b)
   - [spec ファイルの作成](#anchor8c)
   - [メモ化されたメソッド](#anchor8d)
   - [attributes_for メソッド](#anchor8e)
   - [let メソッド](#anchor8f)

<a id="anchor1"></a>

## 1. 規約
 - RSpec のテストコードファイル ( 以下 **spec ファイル** ) は通常、 **spec フォルダ**配下に格納します。
 - spec ファイルの名前の末尾は **_spec.rb** にします。
 - spec ファイルは、spec ディレクトリ以下にサブディレクトリを作成し、役割ごとに分類します。<br>モデルクラスに関する場合： **spec/models/**<br>API に関する場合： **spec/requests/**

<a id="anchor1a"></a>

### インストール

    ```:コマンド
    rails generate rspec:install
    ```

<a id="anchor1b"></a>

### be マッチャー
 - RSpec では、**be_ という接頭辞を持つ未定義のメソッド** が呼び出されると、以下の動作をします。
1. メソッド名から **be_** を取り除き、末尾に **?** を付けたメソッドを呼び出します。
2. そのメソッドの **戻り値が真であればテストが成功** します。<br>**be_suspended** の場合は、**suspended?** の判定と同じ意味になります。

## 2. テストコード 実行

<a id="anchor2a"></a>

### 一括実行
 - デフォルトで spec フォルダ以下の spec ファイルをすべて実行します。

    ```:コマンド
    rspec
    ```

<a id="anchor2b"></a>

### ディレクトリ指定
 - **spec ディレクトリ** を指定する場合

    ```:コマンド
    rspec spec
    ```

<a id="anchor2c"></a>

### 個別ファイル指定

 ```:コマンド
 rspec < spec ファイルまでのパス/ファイル名 >
 ```

 - **spec/experiments/string_spec.rb** を指定する場合

    ```:コマンド
    rspec spec/experiments/string_spec.rb
    ```

<a id="anchor2d"></a>

### 特定の example 指定

 ```:コマンド
 rspec < spec ファイルまでのパス > :< 該当 example の行番号 >
 ```

 - **./string_spec.rb** の５行目の example を指定する場合

    ```:コマンド
    rspec ./string_spec.rb:5
    ```

<a id="anchor3"></a>

## 3. テストの保留
 - テストが失敗した時点でテストは終了します。
 - **一時的に保留** にすることでエラーが解消されなくてもその他のテストを継続できます。

<a id="anchor3a"></a>

### pending メソッド
 - テストで発生したエラーを保留にして、テストを継続することができます。<br>**pending メソッド** の引数には、保留にした理由を表すテキストを指定します。
 - **example "文字追加"** を保留にする場合

    ```:設定例
    describe String do
      describe "#<<" do
        example "文字追加" do
          pending("保留")
          s = nil
          expect(s.size).to eq(4)
        end
      end
    end
    ```

## 4. RSpec 初期設定

<a id="anchor4a"></a>

### 1. Gemfile 記述
 - **Gemfile** に RSpec で使用するライブラリを追記します。

    ```:設定
    group :test do
      gem 'capybara', '>= 2.15'
      gem 'selenium-webdriver'
      gem 'webdrivers'
      gem 'rspec-rails'
      gem 'factory_bot_rails'
    end
    ```

<a id="anchor4b"></a>

### 2. コマンド 実行
 - **spec フォルダ** が作成され、その中に **rails_helper.rb** , **spec_helper.rb** が作成されます。

    ```:コマンド
    bin/rails generate rspec:install
    ```

    ```:実行例
    bash-4.4$ bin/rails generate rspec:install
    Running via Spring preloader in process 145
      create  .rspec
      create  spec
      create  spec/spec_helper.rb
      create  spec/rails_helper.rb
    ```

<a id="anchor4c"></a>

### 3. spec_helper.rb 編集
 - **spec/spec_helper.rb** のコメントを削除します。

    ```:設定
    require "spec_helper"
    ENV['RAILS_ENV'] ||= "test"
    require File.expand_path("../config/environment", __FILE__)
    abort("The Rails environment is running in production mode!") if Rails.env.production?
    require "rspec/rails"

    begin
      ActiveRecord::Migration.maintain_test_schema!
    rescue ActiveRecord::PendingMigrationError => e
      puts e.to_s.strip
      exit 1
    end

    RSpec.configure do |config|
      config.fixture_path = "#{::Rails.root}/spec/fixtures"
      config.use_transactional_fixtures = true
      config.infer_spec_type_from_file_location!
      config.filter_rails_from_backtrace!
    end
    ```

## 5. Example 構文

<a id="anchor5a"></a>

### example とは
 - RSpec で使用されている独自の用語の１つで、テストコードの記述に使用します。
 - ビヘイビア稼働開発 ( Behavior Driven Development : BDD ) を実践するためのテストフレームワークです。
 - 関連する example を example グループとしてまとめることができます。<br>example グループは入れ子にすることができます。

<a id="anchor5b"></a>

### example グループ
 - **describe do ~ end** までが example グループとなります。
 - **describe メソッド** の引数には、**クラス** または **文字列** を指定してグループ分けします。

<a id="anchor5c"></a>

### 変数 s の文字数が 4 であることをチェックするテストコード
 - ファイルの場所は **spec/string_spec.rb** です。( 例としての場所です )

    ```:設定
    require "rails_helper"

    describe String do
      describe "#<<" do
        example "文字追加" do
          s = "ABC"
          s << "D"
          expect(s.size).to eq(4)
        end
      end
    end
    ```

<a id="anchor5d"></a>

### example メソッド ( it メソッド )
 - **example メソッド** の引数には、この example を説明する短い文を定義します。
 - **it** というエイリアスが存在します。<br>**example** を **it** に置き換えて記述できます。<br>it の直後の文字列は日本語でも OK です。

    ```:設定
    it "append a character" do
      s = "ABC"
      s << "D"
      expect(s.size).to eq(4)
    end
    ```

<a id="anchor5e"></a>

### xexample メソッド ( 保留 )
 - **example **メソッドを **xexample** に書き換えることで保留にできます。<br>その場合、**# Temporarily skipped with xexample** とテスト実行時に表示されます。

    ```:設定

    describe String do
      describe "#<<" do
        xexample "文字の追加" do
          s << nil
          expect(s.size).to eq(4)
        end
      end
    end
    ```

<a id="anchor6"></a>

## 6. expect メソッド
 - **T** をターゲット、**M** をマッチャーと呼びます。
 - ターゲットは、メソッドが返すオブジェクトです。<br>マッチャーは、ターゲットに指定されたオブジェクトが条件にマッチするかを調べるオブジェクトです。

    ```:書式
    expect(T).to M
    ```

<a id="anchor6a"></a>

### not_to
 - **.to** の反対の意味として使用できます。

    ```:書式
    expect(T).not_to M
    ```

<a id="anchor6b"></a>

### ブロック
 - 引数にブロックを指定して式を使用することができます。

    ```:書式
    expect { ... }.to M
    ```

 - 変数 **s** に **nil** を追加すると TypeError になるテスト

    ```:書式
    expect{ s << nil }.to raise_error(TypeError)
    ```

## 7. RSpec によるルーティングテスト

<a id="anchor7a"></a>

### ルーティングの expect メソッド

 ```:書式
 expect(get: X).to route_to(Y)
 ```
 - **X** には URL を指定します。<br>**get:** の箇所は HTTP メソッドです。<br>**post: , patch: , delet:** などを設定できます。<br>**route_to** は、ルーティングテスト用のマッチャーです。<br>**Y** には、実際に URL にアクセスした場合の **params オブジェクト** にセットされる内容を指定します。
 - GET メソッドで **http://example.com** にアクセスすると<br> **admin/top** コントローラーの **show** アクションを呼び出す場合のテスト

    ```:設定
    require "rails_helper"

    describe "ルーティング" do
      example "管理者トップページ" do
        expect(get: "http://example.com").to route_to(
          host: "example.com", controller: "admin/top", action: "show"
        )
      end
    end
    ```

<a id="anchor7b"></a>

### be_routable メソッド
 - 与えられた HTTP メソッドと URL の組み合わせから、想定したアクションと結びついているか確認します。
 - GET メソッドで **http://foo.com** にアクセスしたらルーティングされない場合のテスト

    ```：設定
    require "rails_helper"

    describe "ルーティング" do
      example "ホスト名が対象外の場合 routable ではない" do
        url = "http://foo.com"
        expect(get:url).not_to be_routable
      end
    end
    ```

<a id="anchor7c"></a>

### テスト用ファイルを格納するディレクトリと spec.rb を作成
 - **spec/** に **routing** というディレクトリを作成します。
 - テスト用ファイルを **constraints_spec.rb** という名前で作成します。

    ```:コマンド
    mkdir spec/routing
    touch spec/routing/constraints_spec.rb
    ```

<a id="anchor7d"></a>

### テストの実行
 - 対象のファイルを指定してテストを実行します。

    ```：コマンド
    rspec spec/routing/constraints_spec.rb
    ```

<a id="anchor8"></a>

## 8. Factory Bot
 - データーベースにテスト用のデータを投入するためのツールです。
 - 定型的なモデルオブジェクトを生成するオブジェクトを **Factory** と呼びます。

    ```:設定例
    FactoryBot.define do
      factory :administrator do
        email: "admin@example.com",
        password: "pw"
      end
    end
    ```

<a id="anchor8a"></a>

### 1. spec ファイルに記述
 - 以下の内容を **spec/rails_helper.rb** に記述します。
 - **FactoryBot** で定義されているメソッドを使用するために定義します。

    ```:設定
    config.include FactoryBot::Syntax::Methods
    ```

<a id="anchor8b"></a>

### 2. Factory の定義
 - **spec/factories ディレクトリ** を新規に作成し、**staff_members.rb** を作成します。<br>**spec/factories/staff_members.rb**
 - **FactoryBot.define do ~ end のブロック内** で Factory を定義します。

    ```:設定
    FactoryBot.define do
      factory :staff_member do
      family_name { "山田" }
      given_name { "太郎" }
      password { "pw" }
      end
    end
    ```

<a id="anchor8c"></a>

### 3. spec ファイルの作成
 - **build メソッド** により Factory で割り当てられた属性値を持つオブジェクトがセットされます。<br>データベースへの保存はされません。<br>引数を使用することで属性値に任意の値をセットできます。

    ```:設定
    require "rails_helper"
      describe Staff::Authenticator do
        describe "#authenticate" do
          example "正しいパスワードなら true を返す" do
            m = build(:staff_member)
            expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
          end
        end
      end
    ```

<a id="anchor8d"></a>

### メモ化されたメソッド
 - 複数回呼び出された際に、以下のように動作するメソッドです。
1. １回目の呼び出し時にメソッドの中身を続行して結果を返し、結果を記録します。
2. ２回目の呼び出し以降、１回目の結果をそのまま返します。

<a id="anchor8e"></a>

### attributes_for メソッド
 - 引数として Factroy の名前を指定し、戻り値としてハッシュを返します。
 - このハッシュは、モデルオブジェクトの **assign_attributes メソッド** の引数として使用できるキーを持ちます。
 - 設定例を前提とした場合、**attributes_for(:administrator)** は以下のハッシュを返します。

    ```:書式
    { email: "admin@example.com", password: "pw" }
    ```

<a id="anchor8f"></a>

### let メソッド
 - メモ化されたヘルパーメソッドを定義するメソッドで、引数にシンボルを取り、必ずブロックを引き連れます。
 - メソッドの中身が **nil , false** の場合、１回目の呼び出し結果が再利用されません。何度も実行されます。
 - 初回の実行時に値が確定されるため、**定義した段階では値は定まっていません。**
 - 設定例での **let(:admin_update) { attributes_for(:administrator) }** は、以下のコードと同様の意味です。

    ```:設定例
    def admin_update
      @admin_update ||= attributes_for(:administrator)
    end
    ```
