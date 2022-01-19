# MySQL / MariaDB
1. [概要](#anchor1)
   - MySQL
   - MariaDB
2. [インストール](#anchor2)
3. [初期設定](#anchor3)
4. [クライアントコマンド](#anchor4)
   - ユーザー作成
5. [バックアップ](#anchor5)
   - ユーザー hoge が sampledb を sampledb.txt ファイルにバックアップする場合
   - すべてのデータベースを alldb.txt ファイルにバックアップする場合
6. [リストア](#anchor6)
   - sampledb データベースのバックアップをリストアする場合

<a id="anchor1"></a>

## 1. 概要

### MySQL
 - 世界中で広く使用されている SQL データーベース管理システムです。

### MariaDB
 - MySQL 5.5 をベースに開発されているため、MySQL と大きな違いはありません。
 - MySQL と MariaDB の併用は基本出来ません。

<a id="anchor2"></a>

## 2. インストール
 - MySQL

    ```:コマンド
    sudo apt -y install mysql-server
    ```

 - MariaDB

    ```:コマンド
    sudo apt -y install mariadb-server
    ```

 - MariaDB の場合は表示が ` mysqld ` です。

    ```:コマンド
    sudo netstat -tap | grep mysql
    ```

    ```:表示例
    tcp        0      0 localhost:mysql         0.0.0.0:*         LISTEN      5768/mysqld
    ```

<a id="anchor3"></a>

## 3. 初期設定
 - 初期状態では、管理パスワードが設定されていません。
 - ` mysql_secure_installation ` コマンドで対話的に設定します。

1. コマンドの実行

    ```:コマンド
    sudo mysql_secure_installation
    ```

2. 最初に管理者パスワードを問われますが、そのまま **Enter** を押します。
3. ルートパスワードの登録を問われますので **y** を入力しパスワードの設定をします。
4. デフォルトでテスト用ユーザーが作成されているので、それを削除するか問われます。
5. 管理者のリモートログインを禁止にするか問われます。デフォルトでは許可されています。
6. テスト用のデーターベースを削除するか問われます。
7. 変更を反映するか問われますので **y** を入力します。
8. 以上でインストール完了です。

<a id="anchor4"></a>

## 4. クライアントコマンド
 - 書式

    ```:書式
    mysql [ オプション ] [ データーベース名 ]
    ```

   |オプション|説明|
   |---|---|
   |-u < ユーザー名 >|接続するユーザー名を指定します。|
   |-p|パスワードを対話的に入力します。|
   |-p < パスワード >|パスワードを指定します。|
   |-P < ポート >|ポート番号を指定します。デフォルトは、３３０６です。|
   |-h < ホスト名 >|MariaDB , MySQL が稼働しているホストを指定します。|

    |サブコマンド|説明|
    |----|----|
    |? , \h , help|ヘルプを表示|
    |\. < ファイル名 > , source < ファイル名 >|SQL が書かれたファイルを読み込んで実行する|
    |\s , status|MySQL , MariaDB サーバーのステータスを表示する|
    |\u < データーベース名 > , use < データーベース名 >|指定したデーターベースに切り替える|
    |\q . quit|mysql を終了する|

 - root でログインする場合

    ```:コマンド
    mysql -u root -p
    ```

 - データーベース一覧表示

    ```:コマンド
    SHOW DATABESES;
    ```

 - sys データーベースに接続する場合

    ```:コマンド
    USE sys;
    ```

 - テーブル表示

    ```:コマンド
    SHOW TABLES;
    ```

 - ユーザー一覧

    ```:コマンド
    SELECT User , Host FROM mysql.user;
    ```

### ユーザー作成
 - ユーザー名 **hoge** パスワード **passwd** で作成しています。

    ```:コマンド
    CREATE USER 'hoge'@'localhost' IDENTIFIED BY 'passwd';
    GRANT ALL PRIVILEGES ON testdb.* TO 'hoge'@'localhost';
    FLUSH PRIVILEGES;
    ```

<a id="anchor5"></a>

## 5. バックアップ
 - ` mysqldump ` コマンドでデーターベースをバックアップします。

    ```:コマンド
    mysqldump [ オプション ] < データーベース名 > [ テーブル名 ]
    ```

    |オプション|説明|
    |---|---|
    |-u < ユーザー名 >|接続するユーザーを指定します。|
    |-p|パスワードを対話的に入力します。|
    |-p < パスワード >|パスワードを指定します。|
    |-P < ポート番号 >|ポート番号を指定します。デフォルトは、３３０６番です。|
    |-h < ホスト名 >|接続先ホストを指定します。|
    |-d < データーベース名 >|MariaDB / MySQL が稼働しているホストを指定します。|
    |-A|すべてのデータベースをダンプします。|
    |-d|データは含めず、データベースの定義 ( スキーム ) のみダンプします。|
    |--lock-tables|ダンプする前にテーブルをロックします。|
    |--single-transaction|テーブルをロックせずにトランザクションの範囲でダンプします。|

### ユーザー hoge が sampledb を sampledb.txt ファイルにバックアップする場合

 ```:コマンド
 mysqldump -u hoge -p sampledb > sampledb.txt
 ```

### すべてのデータベースを alldb.txt ファイルにバックアップする場合

 ```:コマンド
 mysqldump -u hoge -p -A > alldb.txt
 ```

<a id="anchor6"></a>

## 6. リストア
 - ` mysqldump ` コマンドでバックアップしたデータは ` mysql ` コマンドでリストアします。

    ```:コマンド
    mysql [ オプション ] < データーベース名 > < バックアップファイル名 >
    ```

### sampledb データベースのバックアップをリストアする場合

 ```:コマンド
 mysql -u hoge -p sampledb > sampledb.txt
 ```
