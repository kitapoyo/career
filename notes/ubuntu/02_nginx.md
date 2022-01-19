# Nginx
1. [概要](#anchor1)
2. [インストール](#anchor2)
3. [基本設定](#anchor3)
   - 設定ファイルのブロック
   - /etc/nginx/nginx.conf
   - /etc/nginx/sites-enabled
   - 設定ファイルの構文チェック
4. [リバースプロキシ](#anchor4)
   - リバースプロキシ関連のディレクティブ
   - バックエンド Web サーバー

<a id="anchor1"></a>

## 1. 概要
 - 高速で動作し、高負荷に強い Web サーバー・プロキシサーバーソフトウェアです。
 - Apache が起動していると、Nginx は起動できません。
 - Nginx の起動や停止は **systemctl** を使用します。

<a id="anchor2"></a>

## 2. インストール

 ```:コマンド
 sudo apt -y install nginx
 ```

<a id="anchor3"></a>

## 3. 基本設定
 - デフォルトのサイトは **/etc/nginx/sites-available/default** ファイルで設定します。
 - 先に Apache をインストールしている場合、Apache のデフォルトページが表示されます。<br>その場合 **/var/www/html/index.nginx-debian.html** ファイルを **index.html** にします。

### 設定ファイルのブロック

|記号|説明|
|---|---|
|events|events モジュール|
|http|Web サーバーとしての基本設定|
|server|個々のサーバー ( バーチャルホスト ) の設定|
|location|ディレクトリやファイルのパス|

### /etc/nginx/nginx.conf
 - メインの設定ファイルです。サーバープロセス全般設定を行います。
 - 設定はディレクティブに値を指定します。行末に **;** が必要です。<br>また、ブロック構造のディレクティブもあります。

    ```:書式
    ディレクティブ {
        ディレクティブ 値 ;
        ディレクティブ 値 ;
        ディレクティブ 値 ;
    }
    ```

### /etc/nginx/sites-enabled
 - 個別のサイトについての設定を行います。
 - **/etc/nginx/sites-available** ディレクトリ以下のファイルのシンボリックリンクです。

### 設定ファイルの構文チェック

    ```:コマンド
    sudo nginx -t
    ```

<a id="anchor4"></a>

## 4. リバースプロキシ
 - **/etc/nginx/sites-available/default** ファイルに設定を記述します。

### リバースプロキシ関連のディレクティブ

|ディレクティブ|説明|
|----|----|
|proxy_pass|プロキシ先の URL |
|proxy_set_header|プロキシ先に送られるリクエストヘッダの定義|

### バックエンド Web サーバー ( 192.168.1.200 の場合 )
 - アクセスログには、リバースプロキシではなく、本来のアクセス元が記録できるようにヘッダを書き換えてます。

     ```:設定例
     server {
         listen 80 default_server:
         listen [::]:80 default_server;

         server_name www.example.com;

         location / {
             proxy_pass http://192.168.1.200:
             proxy_set_header Host $http_host;
             proxy_set_header X-Real-IP $remote_addr;
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         }
     }
     ```
