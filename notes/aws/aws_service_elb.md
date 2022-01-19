# AWS ELB ( Elastic Load Balancing )
1. [概要](#anchor1)
2. [ロードバランサーの作成](#anchor2)
3. [SSL 証明書の設定](#anchor3)

<a id="anchor1"></a>

## 1. 概要
 - AWS にて、**ロードバランサー** の機能を提供するもので、３種類用意されています。

    |種類|特徴|用途|
    |---|---|---|
    |Application Load Balancer ( ALB )|HTTP/HTTPS アクセスを分散することに特化<br>SSL 処理を実施<br>URL のパターンなどの条件で分散処理|Web サイトの REST API を提供する場合|
    |Network Load Balancer|通信プロトコルに対応した分散処理<br>双方向通信 ( ソケット通信 ) での分散|ゲーム<br>チャット|
    |Classic Load Balancer|上記２種類が登場する前のロードバランサー|特になし|

### ロードバランサーの役割
1. リクエストの分散
2. SSL 処理
3. 不正リクエスト対策

### ロードバランサーのリクエストルーティング
 - 公開しているプロトコルとポート番号の組み合わせを、内側の Web サーバーで空けているプロトコルとポート番号に変換する機能です。
 - ポート番号 ０ ~ １０２４ 以上の番号を使用して Web サーバーを起動することでセキュリティを向上させます。

    ```:処理
    クライアント > 80 / 443 ロードバランサー 8080 / 3000 > 8080 / 3000 Web サーバー
    ```

<a id="anchor2"></a>

## 2. ロードバランサーの作成
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` EC2 ` を選択します。
3. ` EC2 Dashboard ` から画面左の ` ▶ Load Balancing ` > ` Load Balancers ` を選択します。
4. 画面の ` Create Load Balancer ` ボタンをクリックし、設定項目を入力します。

    |種類|用途|
    |---|---|
    |Application Load Balancer|HTTP , HTTPS によるアクセスを分散させるのに最適化<br>複雑な条件で分散が可能|
    |Network Load Balancer|様々な通信プロトコルに対応<br>基本的な分散処理に対応<br>リアルタイムゲームなどの双方向通信に使用|
    |Gateway Load Balancer|GENEVE をサポートするサードパーティの仮想アプライアンスのフリートを展開および管理する必要がある場合|
    |Classic Load Balancer|上記ロードバランサーが登場する前に使用されていたロードバランサー<br>新規で使用することはほとんどない|

5. 作成するロードバランサーの種類にある ` Create ` ボタンをクリックします。
6. ` Configure Load Balancer ` の項目から設定を行い、` Create load balancer ` ボタンをクリックします。

    |項目|値|説明|
    |---|---|---|
    |Load balancer name||作成するロードバランサーの名前|
    |Scheme|Internet-facing<br>Internal|インターネットを介してクライアントからの要求をターゲットにルーティングする<br>プライベートIPアドレスを使用してクライアントからターゲットにリクエストをルーティングする|
    |IP addess type|IPv4<br>Dualstack|サブネットで使用される IP<br>IPv4 , IPv4 and IPv6|
    |Network mapping|VPC<br>Mappings|ロードバランサーを紐づける VPC<br>ロードバランサーを紐づけるアベイラビリティーゾーン|
    |Security groups||ロードバランサーを紐づけるセキュリティグループ|
    |Listeners and routing|Protocol<br>Port<br>Default action|ロードバランサーで分散するプロトコル<br>ロードバランサーで分散するポート番号<br>ロードバランサーで分散する宛先|

### ロードバランサーの設定
 - **リスナー** と呼ばれる実際にクライアント ( 外部 ) からの処理を受け付ける機能を設定します。

### ターゲットグループの設定
 - どの Web サーバーにリクエストを分散させるかという、**ロードバランサーから Web サーバーへのアクセス** に対する設定をします。
 - １つのロードバランサーに複数のターゲットグループを設定することができます。

### セキュリティグループの選択

|タブ名|説明|
|---|---|
|default|ロードバランサーから VPC 内のリソースへの通信を許可する|

### ルーティングの確認
1. ` EC2 Dashboard ` から ` ▶ Load Balancing ` > ` Target Groups ` を選択します。
2. 対象のターゲットグループにチェックを入れて、` Targets ` タブの ` Status ` 項目を確認します。
3. ` healthy ` となっていれば、対象の Web サーバーへリクエストがルーティングされています。

### ブラウザでのアクセス
1. ` EC2 Dashboard ` から ` ▶ Load Balancing ` > ` Target Groups ` を選択します。
2. 対象のターゲットグループにチェックを入れて、` Description ` タブの ` DNS ` 項目を確認します。
3. 表示されているアドレスがドメイン名です。

<a id="anchor3"></a>

## 3. SSL 証明書の設定
 - ACM で発行した SSL 証明書を設定して HTTPS 通信を追加します。
1. ` EC2 Dashboard ` から ` ▶ Load Balancing ` > ` Load Balancers ` を選択します。
2. 証明書を設定する ELB にチェックを入れて、` Listeners ` > ` Add listener ` ボタンをクリックします。
3. 以下の設定項目を入力して、` Add listener ` ボタンをクリックして設定終了です。

    |項目|値|説明|
    |---|---|---|
    |Protocol : port|HTTPS 443|プロトコルとポート番号を指定|
    |Default action ( s )|ターゲットグループを指定|リスナーで指定する以外のルーティング方法を指定|
    |Security policy|ドロップダウンで選択|ELB で適用するセキュリティポリシーを設定|
    |Default SSL certificate|From ACM<br>証明名|発行された SSL 証明書を設定|
