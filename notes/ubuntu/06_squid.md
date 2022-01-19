# Squid
1. [インストール](#anchor1)
2. [squid の設定](#anchor2)
   - 設定書式
3. [アクセス制御](#anchor3)
   - アクセス禁止のブラックリスト

<a id="anchor1"></a>

## 1. インストール
 - Linux で標準的に使用されているプロキシサーバーです。

    ```:コマンド
    sudo apt -y install squid
    ```

<a id="anchor2"></a>

## 2. squid の設定
 - **/etc/squid/squid.conf** ファイルに設定を記述します。<br>デフォルトで８０００行ほどあり、大半は設定例などのコメントです。

### 設定書式
 - Apache の設定ファイルと同様の書式です。

    ```:書式
    ディレクティブ 設定値
    ```

    |ディレクティブ|説明|
    |---|---|
    |http_port|squid が利用するポート番号 ( デフォルトでは、TCP / 3128 )|
    |visible_hostname|ホスト名|
    |hierarchy_stoplist|キャッシュしない文字列のリスト|
    |maximum_object_size|キャッシュ可能なオブジェクトの最大サイズ|
    |minimum_object_size|キャッシュ可能なオブジェクトの最小サイズ ( ０なら無制限 )|
    |ipcache_size|キャッシュする IP アドレス数|
    |cache_dir|キャッシュを格納するディレクトリと容量など|
    |cache_mem|メモリ上のキャッシュサイズ|
    |access_log|クライアントのアクセスログファイルのパス|
    |cache_log|キャッシュのログファイルのパス|
    |acl|ACL の設定|
    |http_access|ACL の制御|

<a id="anchor3"></a>

## 3. アクセス制御
 - **squid.conf** の **acl** , **http_access** で設定します。
 - デフォルトのアクセスログは **/var/log/squid/access.log** です。<br>設定ファイルを **access_log daemon:/var/log/squid/access.log common** にすると読みやすくなります。

 - acl

    ```:書式
    acl ACL名 ACLタイプ IPアドレスもしくは文字列
    ```

    |ACL タイプ|説明|
    |---|---|
    |src|クライアント側の IP アドレス|
    |dst|代理アクセス先サーバーの IP アドレス|
    |srcdomain|クライアントの所属するドメイン|
    |dstdomain|代理アクセス先サーバーのドメイン|
    |port|代理アクセス先サーバーのポート番号|
    |myport|クライアントのポート番号|
    |proto|プロトコル|
    |method|HTTP メソッド|
    |url_regex|URL にマッチする正規表現|
    |urlpath_regex|URL からプロトコルとホスト名を除いたパス名にマッチする正規表現|
    |time|有効な時刻 ( "9:00-17:00" ) など|

 - 192.168.1.0/24 の許可の場合

    ```:設定例
    acl localnet src 192.168.1.0/24
    http_access allow localnet
    ```

### アクセス禁止のブラックリスト
 - **http_access** 行は **http_access deny all** の前に記述してください。
1. **/etc/squid/squid.conf** にブラックリストを拒否する記述をします。

    ```:設定例
    acl blacklist dstdomain "/etc/squid/blacklist"
    http_access deny blacklist
    ```

2. **/etc/squid/blacklist** ファイルにアクセスを禁止するドメインを記述します。

    ```:設定例
    .example.org
    ```

3. squid を再起動すると、blacklist ファイルに記述されたドメインのアクセスは遮断されます。
