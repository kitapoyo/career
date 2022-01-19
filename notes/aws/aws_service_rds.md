# AWS RDS ( Relational Database Service )
1. [概要](#anchor1)
2. [パラメータグループの作成](#anchor2)
3. [オプショングループの作成](#anchor3)
4. [サブネットグループの作成](#anchor4)
5. [データベースの作成](#anchor5)
6. [接続](#anchor6)

<a id="anchor1"></a>

## 1. 概要
 - RDS は、利用する製品や性能を指定するだけで、簡単にデータベースサーバーを構築できます。
1. データベース製品のインストールが不要
2. EC2 などの OS そのものの管理が不要
3. 不測の障害発生時の対応が不要

### マネージドサービス
 - RDS のように、OS や動作するサーバーを意識せずに必要なサービスを構築できる仕組みです。

### RDS ４つの構成要素

|要素|説明|
|---|---|
|データベースエンジン|実際のデータが保存されたり、問い合わせに応じるデータベース本体<br>性能の向上や耐障害性を高めるために、内部的に複数のインスタンスで構成が可能<br>MySQL , PostgreSQL etc|
|パラメータグループ|データベースエンジンの固有の設定を行うもの<br>使用言語 , データのチューニング etc|
|オプショングループ|RDS 固有の設定を行うもの<br>AWS によるデータベースの監視設定 etc|
|サブネットグループ|サブネットを２つ以上含んだグループ<br>データベースサーバーを複数のアベイラビリティーゾーンに分散して設置する場合の設定を行う<br>複数のデータベースサーバーを分散して用意するサブネットを、サブネットグループとして設定|

<a id="anchor2"></a>

## 2. パラメータグループの作成
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` RDS ` を選択します。
3. ` RDS Dashboard ` から ` ▶ Parameter groups ` > ` Create parameter group ` ボタンをクリックします。
4. ` Create parameter group ` 項目を設定して、` Create ` ボタンをクリックして作成終了です。

    |項目|値|説明|
    |---|---|---|
    |Parameter group family|MySQL<br>Postgre<br>auroa|適用するデータベースとバージョンを選択|
    |Type|DB Parameter Group<br>DB Cluster Parameter Group|パラメータグループの種類を選択|
    |Group name||パラメータグループを一意に識別する名前|
    |Description||作成するパラメータグループの説明|

<a id="anchor3"></a>

## 3. オプショングループの作成
1. ` RDS Dashboard ` から ` ▶ Option groups ` > ` Create group ` ボタンをクリックします。
2. ` Create option group ` 項目を設定して、` Create ` ボタンをクリックして作成終了です。

    |項目|値|説明|
    |---|---|---|
    |Name||オプショングループを一意に識別する名前|
    |Description||作成するオプショングループの説明|
    |Engine||オプショングループを適用するデータベースの種類を選択|
    |Major Engine Version||オプショングループを適用するデータベースのバージョンを選択|

<a id="anchor4"></a>

## 4. サブネットグループの作成
 - RDS を作成する際はサブネットグループを指定します。<br>どのサブネットに作成されるかは AWS が指定します。
 - **マルチ AZ** という機能があり、自動的に複数のアベイラビリティーゾーンにデータベースを作成して、<br>耐障害性を向上させます。
 - 外部に公開されているサブネットをデータベースのサブネットに含ませるとセキュリティ上の懸念が生じます。
1. ` RDS Dashboard ` から ` ▶ Subnet groups ` > ` Create DB subnet group ` ボタンをクリックします。
2. ` Subnet group details ` 項目を設定します。

    |項目|値|説明|
    |---|---|---|
    |Name||サブネットグループを一意に識別する名前|
    |Description||作成するサブネットグループの説明|
    |VPC||サブネットグループに含めるサブネットが含まれる VPC を選択|

3. ` Add subnets ` 項目を設定して、` Create ` ボタンをクリックして作成終了です。

    |項目|値|説明|
    |---|---|---|
    |Availability Zones||追加するサブネットが含まれるアベイラビリティーゾーンを選択|
    |Subnets||追加するサブネットを選択|

<a id="anchor5"></a>

## 5. データベースの作成
1. ` RDS Dashboard ` から ` ▶ Databases ` > ` Create database ` ボタンをクリックします。
2. ` Choose a database creation method ` 項目でデータベースの作成方法を選択します。

    |項目|説明|
    |---|---|
    |Standard create|すべての項目を手動で作成|
    |Easy create|推奨されるベストプラクティス設定を適用|

3. ` Configuration ` 項目でデータベースの種類を設定します。

    |項目|値|説明|
    |---|---|---|
    |Engine type|Aurora<br>MySQL<br>MariaDB<br>PostgreSQL<br>Oracle<br>Microsoft SQL Server|データベースエンジンを選択|
    |Edition||エディションの選択|

4. ` Templates ` 項目でデータベースの使用用途を設定します。

    |項目|説明|
    |---|---|
    |Production|本番稼働用|
    |Dev/Test|開発・テスト用|
    |Free tier|学習用|

5. ` Settings ` 項目でユーザー名とパスワード情報を設定します。

    |項目|説明|
    |---|---|
    |DB cluster identifier|現在のリージョンのアカウントが所有するすべての DB クラスターで一意の名前|
    |Master username|ログインマスターユーザー名|
    |Master password|ログインマスターパスワード<br>Auto generate a password にチェックを入れると自動生成|

6. ` DB instance class ` 項目でインスタンスの性能を設定します。<br>選択したテンプレートによって選択内容が異なります。<br>後に変更ができますが、データベースが再起動します。

    |項目|説明|
    |---|---|
    |DB instance class|インスタンスのクラスを指定|
    |Multi-AZ deployment|マルチアベイラビリティーゾーンの有無|


7. ` Storage ` 項目でストレージを設定します。

    |項目|説明|
    |---|---|
    |Storage type|データベースサーバーが使用するストレージタイプを選択|
    |Allocated storage|データベースサーバーが使用するストレージサイズを選択|
    |Enable storage autoscaling|指定したストレージサイズを超える場合は自動でストレージを増やす|
    |Maximum storage threshold|自動でストレージを増やす際の最大閾値|

8. ` Connectivity ` 項目で接続情報の設定します。

    |項目|説明|
    |---|---|
    |Virtual private cloud ( VPC )|DB インスタンスの定義する VPC を選択|
    |Subnet group|選択した VPC で DB インスタンスが使用するサブネットグループを選択|
    |Public access|外部からアクセスするかの選択|
    |VPC security group|データベースへのアクセス許可設定|
    |Availability Zone|DB インスタンスを作成する現在のリージョンからアベイラビリティーゾーンを選択|
    |Database port|アプリケーションの接続に使用するポート番号|

9. ` Database authentication ` 項目で認証の設定します。データベースの認証方法を選択します。

    |項目|説明|
    |---|---|
    |Password authentication|パスワード認証|
    |Password and IAM database authentication|パスワード認証と IMA 認証|
    |Password and Kerberos authentication|Kerberos 認証|

10. 最後に ` Additional configuration ` 項目を設定します。<br>パラメータグループとオプショングループはここで指定します。
11. ` Create database ` ボタンをクリックして作成終了です。作成には数分かかります。

<a id="anchor6"></a>

## 6. 接続
 - **MySQL** の場合は、Amazon Linux2 にデフォルトでインストールされていないので、別途インストールが必要です。

    ```:コマンド
    sudo yum - y install mysql
    ```

1. ` RDS Dashboard ` から画面左の ` ▶ Databases ` > 接続するデータベースにチェックを入れます。
2. ` Connectivity & security ` タブを選択し、` Endpoint & port ` が接続先の情報です。
3. 接続先の情報で以下のコマンドを実行します。**mysql is alive** と表示されれば接続が成功です。

    ```:コマンド
    mysqladmin ping -u < username > -p -h < Endpoint >
    Enter password: < password >
    ```
