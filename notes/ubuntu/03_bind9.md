# DNS Server
1. [予備知識](#anchor1)
   - SOA コード
   - NS レコード
   - MX レコード
   - A レコード
   - PTR レコード
2. [DNS サーバー ( BIND9 )](#anchor2)
   - インストール
   - 設定ファイル
   - キャッシュサーバーの設定
   - コンテンツサーバーの設定
   - 正引き・逆引きゾーンファイルの作成
   - セカンダリ DNS サーバーの設定

<a id="anchor1"></a>

## 1. 予備知識
 - CentOS では **named** ですが、UbuntuServer では **bind9** を使用します。

    |リソースレコードタイプ|説明|
    |----|----|
    |SOA|管理情報|
    |NS|ゾーンを管理する DNS サーバー|
    |MX|メールサーバー ( 正引きファイルのみ )|
    |A|ホスト名に対する IP アドレス ( 正引きファイルのみ )|
    |AAAA|ホスト名に対する IPv6 アドレス ( 正引きファイルのみ )|
    |CNAME|ホスト名の別名に対する正規名 ( 正引きファイルのみ )|
    |PTR|IP アドレスに対するホスト名 ( 逆引きファイルのみ )|

 - SOA コード

    ```:設定例
           IN SOA example.com. root.ns.example.com. (
                2021010101  ; Serial
                1D         ; Refresh
                1H         ; Retry
                1W        ; Expire
                1D )      ; Negative Cache TTL
    ```

    - **Serial** ：ゾーンファイルのバージョンです。一般的に、日付 + 管理番号で表します。
    - **Refresh** ：プライマリ DNS サーバーの情報をセカンダリ DNS サーバーが確認する間隔です。
    - **Retry** ：セカンダリがプライマリにアクセスできない場合のリトライ間隔です。
    - **Expire** ：セカンダリがプライマリにアクセスできない場合のゾーン情報の有効期限です。
    - **Negative Cache** ：存在しないドメインのキャッシュ間隔です。

 - NS レコード

    ```:設定例
    @       IN      NS      ns.example.com.
    ```

    - **@** 記号は、そのゾーン情報の基準となるドメイン ( オリジン ) を表します。

 - MX レコード

    ```:設定例
    @       IN      MX      10 mail.example.com.
    @       IN      MX      20 mail2.example.com.
    ```
    - バックアップ用のメールサーバーが存在する場合は、メールサーバーごとに１行ずつ記述します。
    - メールサーバーの優先度を表すプリファレンスを記述します。値が小さいほど優先されます。

 - A レコード

    ```:設定例
    srv    IN      A       192.168.1.200
    mail    IN      A       192.168.1.201
    ```

 - PTR レコード

    ```:設定例
    200.1.168.192.in-addr.arpa.     IN      PTR     ns.example.com.
    201.1.168.192.in-addr.arpa.     IN      PTR     mail.example.com.
    ```

<a id="anchor2"></a>

## 2. DNS サーバー ( BIND9 )
 - **５３番ポート** を使用します。
 - 起動したり終了する場合は **systemctl** を使用します。

### インストール

 ```:コマンド
 sudo apt -y install bind9
 ```

### 設定ファイル
 - **/etc/bind/** ディレクトリ以下に格納されます。
 - **/etc/bind/named.conf** はメインの設定ファイルです。

### キャッシュサーバーの設定
 - キャッシュサーバとは、クライアントからの問い合わせに対して回答するサーバーです。
 - **/etc/bind/named.conf.options** ファイルを設定します。

    ```:設定例
    # 問い合わせ先の DNS サーバーのアドレスを指定します
    forwarders {
         8.8.8.8;
         8.8.4.4;
    };
    # クライアントからの問い合わせを制限します
    allow-query {
        localhost;
        192.168.56.0/24;
    };
    ```

### コンテンツサーバーの設定
 - コンテンツサーバーとは、自身の管理するゾーン情報を他の DNS サーバーへ返答するサーバーです。
 - 自ら名前解決情報を所持しています。名前解決情報を記述するファイルを、ゾーンファイルといいます。
 - ゾーンファイル **/etc/bind/db.local** の場合

    ```:設定例
    ;
    ; BIND data file for local loopback interface
    ;
    $TTL    604800
    @       IN      SOA     localhost. root.localhost. (
                                             2         ; Serial
                                    604800         ; Refresh
                                      86400         ; Retry
                                  2419200         ; Expire
                                   604800 )       ; Negative Cache TTL
    ;
    @       IN      NS      localhost.
    @       IN      A        127.0.0.1
    @       IN      AAAA            ::1
    ```

 - **localhost** のように **.** を忘れると、ゾーン名または **$ORIGIN** で指定されたドメイン名が末尾に追加されます。
 - ゾーンファイルのチェックがコマンドでできます。

    ```:コマンド
    named-checkzone < ゾーン名ゾーンファイル >
    ```

### 正引き・逆引きゾーンファイルの作成
1. **/etc/bind/named.conf.local** に定義するゾーンを追記します。

    ```:設定例
    zone "example.com" {
            type master;
            file "/etc/bind/db.example.com";
    };
    zone "1.168.192.in-addr.arpa" {
            type master;
            file "/etc/bind/db.192";
    };
    ```

2. 正引きゾーンファイルを作成します。

    ```:コマンド
    sudo vim db.example.com
    ```

3. レコードを記載していきます。

    ```:設定例
    ;
    ; BIND data file for example.com
    ;
    $TTL    604800
    @       IN      SOA     example.com. root.ns.example.com. (
                         2021010101         ; Serial
                             604800            ; Refresh
                              86400             ; Retry
                            2419200           ; Expire
                             604800 )         ; Negative Cache TTL
    ;
    @         IN      NS         ns.example.com.
    @         IN      A           192.168.1.200
    @         IN      AAAA     ::1
    @         IN      MX         10 mail.example.com.
    ns         IN      A           192.168.1.200
    www     IN      CNAME   ns.example.com.
    svr        IN      A           192.168.1.200
    mail      IN      A           192.168.1.201
    ```

4. 逆引きゾーンファイルを作成します。

    ```:コマンド
    sudo vim db.192
    ```

5. レコードを記載していきます。

    ```:設定例
    ;
    ; BIND reverse data file for local 192.168.1.XXX net
    ;
    $TTL    604800
    @       IN      SOA     ns.example.com. root.example.com. (
                         2021010101         ; Serial
                             604800         ; Refresh
                              86400         ; Retry
                            2419200         ; Expire
                             604800 )       ; Negative Cache TTL
    ;
    @       IN      NS      ns.
    200     IN      PTR     ns.example.com.
    201     IN      PTR     mail.example.com.
    ```

6. 再起動して読み込みます。

    ```:コマンド
    sudo systemctl restart bind9
    ```

7. コマンドで確認してみましょう。

    ```:コマンド
    dig @localhost ns.example
    dig @localhost -x 192.168.1.200
    dig @localhost -x 192.168.1.201
    ```

### セカンダリ DNS サーバーの設定
 - セカンダリ DNS サーバーは、プライマリ DNS サーバーからゾーン情報をコピー ( ゾーン転送 ) して保持します。
1. プライマリ DNS サーバーの **/etc/bind/named.conf.local** ファイルにゾーン転送許可を追記します。

    ```:設定例
    zone "example.com" {
            type master;
            file "/etc/bind/db.example.com";
            allow-transfer { セカンダリ DNS サーバーの IP アドレス };
    };
    ```

2. 再起動して読み込みます。

    ```:コマンド
    sudo systemctl restart bind9
    ```

3. プライマリ DNS サーバーの ` /etc/bind/named.conf.local `  ファイルに設定を記述します。

    ```:設定例
    zone "example.com" {
            type slave;
            file "db.example.com";
            masters { プライマリ DNS サーバーの IP アドレス };
    };
    ```

4. 再起動して読み込みます。

    ```:コマンド
    sudo systemctl restart bind9
    ```

5. ログファイルでゾーン転送を確認してみましょう。

    ```:コマンド
    cat /var/log/syslog | tail -10
    ```
