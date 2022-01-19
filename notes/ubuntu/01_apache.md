# Apache HTTP Server
1. [概要](#anchor1)
2. [インストール](#anchor2)
3. [設定ファイル](#anchor3)
   - 基本設定
   - サーバー名の設定
   - ドキュメントルート
4. [モジュール](#anchor4)
   - モジュール確認
   - 共有モジュールの有効化
   - 共有モジュールの無効化
5. [BASIC ( 基本 ) 認証](#anchor5)

<a id="anchor1"></a>

## 1. 概要
 - バージョンがいくつか系統があります。大きく分けて「２２系」「２４系」が存在します。
 - バーチャルホスト 機能 ( アクセスされるアドレスによって異なるページにアクセスする ) があります。

<a id="anchor2"></a>

## 2. インストール
 - インストール後 Apache は自動起動します。

    ```:コマンド
    sudo apt -y install apache2
    ```

 - 起動確認

    ```:コマンド
    sudo systemctl status apache2
    ss -atl
    ```

<a id="anchor3"></a>

## 3. 設定ファイル
 - 設定ファイルは **/etc/apache2/** ディレクトリ以下に配置されます。
 - **available** ディレクトリには、インストールされているパッケージに対応した設定が格納されています。
 - **enabled** ディレクトリには、現在有効な設定が格納されています。available 以下ファイルへのシンボリックリンクです。

    |設定ファイル|説明|
    |---|---|
    |apache2.conf|メイン設定ファイル|
    |conf-available/|各種機能の設定が格納されるディレクトリ|
    |conf-enabled/|有効な設定ファイルが格納されるディレクトリ ( conf-available 内ファイルへのリンク ) |
    |mods-available/|各種モジュールの設定ファイルが格納されるディレクトリ<br> *.load はモジュールをロードする設定 , *.conf はモジュールの設定ファイル|
    |mods-enabled/|有効なモジュール設定ファイルが格納されるディレクトリ ( mods-available 内ファイルへのリンク )|
    |sites-available/|Web サイトの設定ファイルが格納されるディレクトリ|
    |sites-enabled/|有効な Web サイトの設定が格納されるディレクトリ ( sites-available 内ファイルへのリンク )|
    |envvars|デフォルトの環境変数設定|
    |magic|mod_mine_magic のための MIME データ|
    |ports.conf|待ち受けポート番号の設定|

### 基本設定
 - Apache の設定ファイルはいくつかに分かれています。
- **/etc/apache2/sites-enabled/000-default.conf** ファイルに記述していきます。
 - ディレクティブとは、設定項目を意味します。

    ```:書式
    ディレクティブ 設定値
    ```

    |ディレクティブ|説明|
    |---|---|
    |ServerTokens Prod\|Major\|Minor\|Min\|OS\|Full|HTTP ヘッダ内に出力されるバージョン情報を指定する|
    |ServerRoot パス|Apache が利用するトップディレクトリを指定する|
    |Timeout タイムアウト時間|クライアントからの接続がタイムアウトになる時間を秒数で指定する|
    |KeepAlive on\|off<br>MaxKeepAlive 上限リクエスト数<br>KeepAliveTimeout タイムアウト時間|Web サーバーとクライアントの TCP 接続をキープするか指定する<br>１回の TCP 接続における最大リクエスト数を指定する<br>１回の TCP 接続におけるタイムアウト時間を秒数で指定する|
    |HostnameLookups|DNS の逆引きを行い、ログにホスト名などを記録する|
    |SeverName サーバーのホスト名|Apache が稼働しているホストのホスト名を指定する|
    |ServerAdmin メールアドレス|サーバー管理者のメールアドレスを指定する ( エラーページに表示されたりする )|
    |ErrorLog ログファイルのパス<br>LogLevel ログレベル|エラーを記録するファイルを指定する ( ${APACHE_LOG_DIR } は /var/log/apache2 を指す )<br>ログを出力するレベルを指定する|
    |Listen [ IP アドレス :] ポート番号|待ち受けるポート番号を指定する ( IP アドレスは省略できる )|
    |DocumentRoot ディレクトリパス|ドキュメントルートとなるディレクトリを指定する|
    |UserDir 公開ディレクトリ\|disabled|一般ユーザーがディレクトリを公開する場合の公開ディレクトリを指定する<br>|ディレクトリ名はホームディレクトリから相対パスもしくは絶対パスで指定する
    |DirectoryIndex インデックスファイル名|ディレクトリのインデックスとして返すファイルを指定する|
    |Alias ディレクトリパス |ドキュメントツリー以外の場所を参照できるようにする|

### サーバー名の設定
 - **/etc/apache2/sites-enabled/000-default.conf** ファイルの **ServerName** で設定します。

    ```:設定例
    <VirtualHost *:80>
            ServerName www.example.com
    ```

### ドキュメントルート
 - デフォルトでは **/var/www/html** ディレクトリです。ここに **html** ファイルを格納します。
 - ` sudo vim /var/www/html/index.html ` を実行し、以下内容をコピーして確認してみましょう。

    ```:設定例
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>サンプル</title>
        </head>
        <body>
            <h1>SamplePage</h1>
            <h2>Sample</h2>
             <p> /var/www/html/ に格納して表示</p>
        </body>
    </html>
    ```

<a id="anchor4"></a>

## 4. モジュール
 - Apache は、さまざまな機能をモジュールとして実装しています。

### モジュール確認
 - **static** は Apache 本体に静的に組み込まれているモジュールです。
 - **shared** は Apache 本体に動的に組み込まれている共有モジュールです。

    ```:コマンド
    sudo apachectl -t -D DUMP_MODULES
    ```

### 共有モジュールの有効化

 ```:コマンド
 a2enmod < モジュール名 >
 ```

### 共有モジュールの無効化

 ```:コマンド
 a2dismod < モジュール名 >
 ```

<a id="anchor5"></a>

## 5. BASIC ( 基本 ) 認証
 - 特定のディレクトリ以下にアクセスする際に、ユーザー名とパスワードを用いた認証を行います。
 - ` htpasswd ` コマンドで認証に使用するユーザーを作成します。Linux ユーザーとは無関係です。
 - 基本認証では、パスワードは暗号化されません。インターネットでは、SSL / TLS で使用しましょう。

1. エリア作成

    ```:コマンド
    sudo mkdir /var/www/html/private-area
    ```

2. ファイル作成

    ```:コマンド
    sudo vim /etc/apache2/sites-available/private-area.conf
    ```

 - 以下内容記述します。

    ```:設定例
    <Directory /var/www/html/private-area>
    AuthType Basic
    AuthName "Private Area"
    AuthUserFile /etc/apache2/htpasswd
    Require vaild-user
    </Directory>
    ```

3. 認証ユーザー作成 ( ユーザー名 hoge )
 - ` /etc/apache2/htpasswd ` は、パスワードが格納されるファイルです。<br>存在しない場合は ` -c ` オプションが必要です。

    ```:コマンド
    sudo htpasswd -c /etc/apache2/htpasswd hoge
    ```

4. 有効化

    ```:コマンド
    sudo a2ensite private-area && \
    sudo systemctl restart apache2
    ```
