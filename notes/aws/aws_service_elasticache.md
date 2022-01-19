# ElastiCache
1. [概要](#anchor1)
2. [ElastiCache の作成](#anchor2)

<a id="anchor1"></a>

## 1. 概要
 - **Redis** や **Memcahed** などが導入されたキャッシュサーバーを提供するマネージドサービスです。
 - Key に対して Value を返す、キーバリュー型の仕組みを提供します。
 - **シャード** を構成すると、単一のノード障害が発生した時の耐障害性と読み込み時の性能向上ができます。
 - **クラスター** を構成すると、アベイラビリティーゾーンに障害が発生した時の耐障害性を向上できます。
 - ノードの数だけ **コスト** がかかります。

### 内部構造

|要素|別名|説明|
|---|---|---|
|ノード||ElastiCache の最小単位<br>キャッシュされるデータが実際に保存される場所を確保<br>ノードごとにキャッシュエンジン ( Redis , Memcached )|
|プライマリノード||データの更新と照会を行う|
|レプリカノード||プライマリノードに行った更新がコピーされて同じ状態を維持<br>データの照会は、プライマリノードと同様に実行され、ノードの数だけ性能が向上|
|シャード|ノードグループ|１つのプライマリノードと複数のレプリカノードにより構成<br>プライマリノードに障害が発生した場合でも、レプリカノードでデータの照会が可能|
|クラスター|レプリケーショングループ|複数のシャードで構成され、シャードの内容は共有される<br>マルチ AZ ( アベイラビリティーゾーン ) に対応し、障害時にフェイルオーバーが可能|

<a id="anchor2"></a>

## 2. ElastiCache の作成
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面上の ` Services ` から ` ElastiCache ` を選択します。
3. ` ElastiCache Dashboard ` から ` Redis ` > ` Create ` を選択します。
4. ` Create your Amazon ElastiCache cluster ` で、 ElastiCache の設定を行います。<br>設定項目を入力して、` Create ` をクリックして終了です。<br>ステータスが **available** になるまで数分かかります。

   |設定項目|値|説明|
   |---|---|---|
   |Cluster engine|Redis ( Cluster Mode enabled ) <br>Memcached|クラスターエンジンとクラスターモードの設定<br>複数のシャードを使用する場合は、Cluster Mode enabled にチェックを入れる|
   |Location|Amazon Cloud<br>On-Premises|ロケーションを設定<br>Amazon Cloud ：ElastiCache インスタンスに Amazon のクラウドを使用<br>On-Premises ：AWS Outpost で ElastiCache インスタンスを作成|
   |Redis settings|以下参照|Redis クラスターの基本設定|
   |Advanced Redis settings|以下参照|パフォーマンスや可用性の設定<br>クラスター作成後に変更可能|

   |Redis settings 項目|値 ( デフォルト値 )|説明|
   |---|---|---|
   |Name||Redis クラスターの名前|
   |Description||説明|
   |Engine version compatibility|6.2|エンジンバージョンの互換性|
   |Port|6379|ノードの接続ポート番号|
   |Parameter group|default.redis6.x||
   |Node type|cache.r6g.large ( 13.07 GiB )|メモリサイズなど性能を設定|
   |Number of replicas|2|シャードに対するレプリカの数|
   |Multi-AZ|Enable|マルチアベイラビリティーゾーンの有無|

   |Advanced Redis settings 項目|値 ( デフォルト値 )|説明|
   |---|---|---|
   |Subnet group|Create new|サブネットグループの作成|
   |Name||サブネットグループの名前|
   |Description||説明|
   |VPC ID||ElastiCache を作成する VPC|
   |Subnets||利用するサブネット|
   |Availability zones placement|No preference<br>Select zones|アベイラビリティーゾーンの設定<br>No preference ：自動的に分散<br>Select zones ：分散するアベイラビリティーゾーンを手動で選択|
   |Security|Security groups<br>Encryption at-rest<br>Encryption in-transit|セキュリティグループ名<br>保管時の暗号化有無<br>送信中の暗号化有無|
   |logs|Slow log|指定された実行時間を超えたクエリの Redis ログを提供|
   |Import data to cluster|Seed RDB file S3 location|RDB ファイルを保管する S3 の指定|
   |Backup|Enable automatic backups<br>Backup retention period<br>Backup window|自動バックアップの有効化<br>バックアップ保管期間<br>バックアップウィンドウの有無|
   |Maintenance|Maintenance window<br>Topic for SNS notification|メンテナンスウィンドウの有無<br>SNS 通知の有無|
   |Tags|Key<br>Value||
