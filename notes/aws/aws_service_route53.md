# AWS Route53 Note
1. [概要](#anchor1)
2. [ドメイン名の取得](#anchor2)
3. [外部 DNS にリソース情報を追加](#anchor3)
4. [内部 DNS の作成](#anchor4)
5. [RDS リソースの追加](#anchor5)

<a id="anchor1"></a>

## 1. 概要
 - AWS で DNS の役割を果たすマネージドサービスです。
 - 主に２つの機能があります。
1. ドメイン名の登録<br>上位のドメインを管理している組織に、自身のドメインを申請して登録してもらうことです。
2. DNS サーバー<br>外部 DNS サーバーと内部 DNS サーバーの役割を果たします。<br>EC2 などに DNS 機能を持たせることもできますが、管理が複雑になります。

    |項目|外部 DNS|内部 DNS|
    |---|---|---|
    |用途|システムで公開するサーバーのドメイン名の解決|システム内のサーバーの名前解決|
    |ドメイン名の取得|必要|不要|
    |解決するIP アドレス|グローバル IP アドレス|プライベート IP アドレス|

<a id="anchor2"></a>

## 2. ドメイン名の取得
 - AWS でドメイン名を取得する場合は、基本以下の形になります。<br>TLD とは、` .com ` ,`  .co.jp ` などです。
 - 所得したドメインに SSL 用の証明書を発行する場合は、` AWS Certificate Manager ( 別記事 ) ` を利用します。

    ```:ドメイン
    固有の名称 + トップレベルドメイン ( TLD )
    ```

1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面上の ` Services ` から ` Route53 ` を選択します。
3. ` Route53 Dashboard ` から ` ▶ Domains ` > ` Registered domains ` を選択します。
4. 画面の ` Register Domain ` ボタンをクリックし、設定項目を入力します。
5. ` Choose a domain name ` で、ドメイン名を決定します。<br> ` Check ` ボタンをクリックすることで、使用できるか調べることができます。<br>ドメイン名が蹴ってした場合は、` Add to cart ` ボタンをクリックして ` Continue ` ボタンをクリックします。
6. ` Contact Details for Your 1 Domain ` で、ドメインの連絡先を登録します。<br>登録が終わったら、` Continue ` ボタンをクリックします。<br>初めてドメインを取得する場合、不正なドメイン作成を防ぐために登録したメールアドレス宛に確認通知が来ます。

    |項目|値|説明|
    |---|---|---|
    |Contact Type|Person , Company<br>Association , Public Body|ドメインを取得するのが個人または法人なのかを選択|
    |住所等|中略|氏名 , 住所 , 連絡先|
    |Privacy Protection|Enable<br>Disable|ドメイン取得者が個人の場合に、本来公開される連絡先情報を非公開に設定する有無|

7. ` Check your contact details ` で、登録の確認をします。

    |項目|値|説明|
    |---|---|---|
    |Do you want to<br>automatically renew your domain?|enable<br>disable|ドメイン有効期限の自動で更新有無<br>使用量に支払いも発生|
    |Terms and Conditions|チェックボックス|規約の内容確認|

8. ` Complete Order ` ボタンをクリックしてドメイン取得は終了です。<br>ドメイン名取得には数時間 ~ 数日かかることがあります。<br>Route53 のダッシュボードで確認ができます。

<a id="anchor3"></a>

## 3. 外部 DNS にリソース情報を追加
 - Route53 でドメイン名を取得すると、自動的に取得したドメインを管理する外部 DNS サーバーが作成されます。<br>ここに、外部からアクセスする VPC 内のリソースのアドレスを設定します。
 - 外部サービスで取得したドメインを Route53 に含めることも可能です。
1. ` Route53 Dashboard ` から ` Hosted zones ` を選択します。
2. 作成したドメインを選択して、` Hosted zone details` ボタンをクリックします。
3. ` Hosted zone details ` 内の ` Create record ` ボタンをクリックします。
4. ` Routing policy ` を選択して、` Next ` ボタンをクリックします。<br>この手順では、シンプルルーティングを選択します。

    |項目|説明|
    |---|---|
    |Simple routing|トラフィックを１つのリソースにルーティングする場合|
    |Weighted|同じジョブを実行する複数のリソースに対してトラフィックの割合を指定する場合|
    |Geolocation|ユーザーの位置でトラフィックをルーティングする場合|
    |Latency|複数のリージョンにリソースが存在しレイテンシーが最適なリソースにトラフィックをルーティングする場合|
    |Failover|冗長化構成のルーティングをする場合|
    |Multivalue answer|１つの DNS クエリに対して最大８つのレコードをランダムに返す場合|

5. ` Define simple record ` ボタンをクリックしてリソース情報を設定します。

    |項目|説明|
    |---|---|
    |Record name|ドメイン名に設定する名前|
    |Record type|A , AAAA , CNAME , MX|
    |Value / Route traffic to|レコードタイプに応じた IP アドレスまたは別の値<br>リソースのグローバル IP アドレス|
    |TTL ( seconds )|レコードの設定をキャッシュする時間|

6. ` Define simple record ` ボタンをクリックして、` Create record ` ボタンをクリックして終了です。

<a id="anchor4"></a>

## 4. 内部 DNS の作成
 - 作成するドメイン名は、外部で公開されているドメイン名と重複しない設定にします。<br>本来の宛先と異なる回答が返ってくる可能性があるためです。
 - 重複しないことが保証されているドメイン名<br>**corp**<br>**home**<br>**mail**<br>**internal** ( AWS では、既に使用しているため NG )
1. 使用する VPC で DNS が使用できるか、VPC の ` Details ` で以下の設定を確認します。<br>有効でない場合は、` Actions ▼ ` から ` Edit DNS hostnames ` , ` Edit DNS resolution ` を選択して設定します。

    |項目|状態|
    |---|---|
    |DNS hostnames|Enabled|
    |DNS resolution|Enabled|

2. ` Route 53 Dashboard ` > ` Hosted zones ` > ` Create hosted zone ` ボタンをクリックします。
3. ` Hosted zone configuration ` 項目を設定して、` Create hosted zone ` ボタンをクリックして終了です。

    |項目|値|説明|
    |---|---|---|
    |Domain name|外部と重複しない値|ドメイン名|
    |Description - optional|省略可|説明|
    |Type|Public hosted zone<br>Private hosted zone|外部 DNS サーバーとして作成<br>内部 DNS サーバーとして作成<br>内部の場合は、以下の VPC の設定が必要|
    |VPCs to associate with the hosted zone|Region<br>VPC ID|リージョン<br>内部 DNS を使用する VPC ID |
    |Tags|省略可||

<a id="anchor5"></a>

## 5. RDS リソースの追加
 - RDS は固定された IP アドレスは参照ができません。<br>その代わり End point を使用して、DNS に登録をします。
1. 画面上の ` Services ` から ` RDS ` を選択して、あらかじめ作成した データベースにチェックを入れます。
2. ` Connect and Security ` タブから ` End point ` という項目を確認します。<br>この文字列が RDS のエンドポイントです。
3. 内部 DNS に RDS のレコードを追加します。

    |項目|値|
    |---|---|
    |Record name|ドメイン名に設定する名前|
    |Record type|CNAME|
    |Value / Route traffic to|レコードタイプに応じた IP アドレスまたは別の値<br>確認したエンドポイントの文字列|
    |TTL ( seconds )|300|

4. ` Create record ` ボタンをクリックして終了です。
