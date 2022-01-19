# Docker Compose
1. [Docker Compose とは](#anchor1)
2. [コンテナ起動 ( docker-compose up )](#anchor2)
3. [コンテナ確認 ( docker-compose ps )](#anchor3)
4. [コンテナ停止・再起動 ( docker-compose stop , start )](#anchor4)
5. [コンテナ停止・破棄 ( docker-compose down )](#anchor5)
6. [イメージ作成 ( ビルド ) ( docker-compose build )](#anchor6)
7. [環境変数の参照](#anchor7)

<a id="anchor1"></a>

## 1. Docker Compose とは
 - 複数コンテナの実行・停止・削除をまとめて実行する定義ファイルを作成し、実行する仕組みです。
 - ` docker run ` コマンドの集合体で、作成するものは **コンテナ** と **周辺環境** です。
 - **Dockerfile** はイメージを作成するものなので、明確に異なります。
 - **Kubernetes** のような管理機能はありません。
 - **Python** で書かれたプログラムなので実行環境が必要です。
 - デフォルトの定義ファイル名は **docker-compose.yml** です。<br>これ以外のファイル名を使用する場合は ` -f ` オプションでファイル名を指定する必要があります。<br>YAML ( YAML Ain't a Markup Language ) 形式で記述します。
### 公式 Link
 - [Docker Compose Docs](https://docs.docker.jp/compose/index.html)
 - [Rails Quick Start](https://docs.docker.com/samples/rails/)

### Docker Compose の項目

|大項目|説明|
|----|----|
|version: < バージョン >|YAML 形式のバージョンを指定します。<br>指定したバージョンで使用できる文法で記述します。|
|services:<br>　< サービス ( コンテナ群 ) 名 >:<br>　　< 以下コンテナ詳細設定 >|アプリのサービス名 ( コンテナ群 ) を指定します。|
|networks:<br>　< ネットワーク名 >:<br>　　driver: < ドライバータイプ >|作成するネットワークを指定します。<br>下の階層でネットワーク名とドライバーを指定します。|
|volumes:<br>　< ボリューム名 >:<br>　　driver: < ドライバータイプ >|作成するボリュームを指定します。<br>下の階層でボリューム名とドライバーを指定します。|

|services サービス名 項目|説明|
|----|----|
|image: < イメージ名 >|利用する Docker image の指定をします。<br>ビルド指定のないサービスでイメージを指定すると、そのイメージ ( 必要であれば Pull ) でコンテナを起動します。|
|networks:<br>- < ネットワーク名 >|コンテナが所属する大項目で指定したネットワーク名を指定します。<br>同じネットワークの場合は、デフォルトネットワークではないので名前解決ができます。|
|network_mode: < ネットワークタイプ >|ネットワークのタイプ ` bridge , host , none ` などを指定します。|
|ports:<br>- < ホストポート >:< コンテナポート >|ポートフォワーディングの設定をハイフンによるリスト形式で指定します。|
|enviroment:<br>　:< 環境変数 >: < 値 > |環境変数を指定します。|
|restart: < 処理内容 >|コンテナが異常停止した場合の処理を指定します。<br>デフォルトは ` none ` で停止します。<br>` unless-stopped ` を指定すると再起動します。|
|depends_on:<br>- < コンテナ名 >|指定したコンテナが起動するまで起動されません。<br>コンテナの起動順序を指定する際に利用します。|
|build:<br>　context: < Dockerfile の相対パス ><br>　dockerfile: < Dockerfile 名 >|イメージをビルドする際に利用します。<br>` context ` で docker-compose.yml から見た Dockerfile の相対パスを指定します。<br>**コンテキストとして指定したディレクトリを基準に Dockerfile のパス指定が行われます。**<br>` dockerfile ` で利用する Dockerfile を指定します。|
|container_name: < コンテナ名 >|作成されるコンテナ名を指定します。<br>コンテナを自動命名させたくない場合に利用します。|
|command: [ "コマンド", "コマンド", "コマンド" ]|デフォルト以外の起動コマンドを指定する際に利用します。<br>例：` [ "tail", "-f", "/dev/null" ] `|
|tty: < true \| false >|run コマンドの ` -it ` と同様の指定で、コンソールがコンテナに行きます。|
|env_file: < ファイル名 >|run コマンドの ` --env-file ` と同様の設定で、` 名前.env ` ファイルを読み込んで環境変数を参照します。|
|stop_signal: < シグナルタイプ >|コンテナ停止のシグナルを指定します。<br>デフォルトは ` SIGTERM ` です。|

<a id="anchor2"></a>

## 2. コンテナ起動 ( docker-compose up )

 ```:コマンド
 docker-compose { -f < docker-compose.yml のパス > } up -d
 ```
 - カレントディレリクトリに定義ファイルが存在する場合は ` -f ` オプションを省略できます。
 - ` -d ` オプションでバックグラウンドで実行するように指定できます。
 - ネットワーク名やコンテナ名を指定していない場合は<br>**docker-compose.yml ファイルが格納されているディレクトリ名とサービス名が名付けられます。**

<a id="anchor3"></a>

## 3. コンテナ確認 ( docker-compose ps )

 ```:コマンド
 docker-compose ps
 ```

 - docker-compose.yml で定義しているコンテナの実行状況を確認できます。<br>定義ファイルに無い他のコンテナはこのコマンドでは出力されません。

<a id="anchor4"></a>

## 4. コンテナ停止・再起動 ( docker-compose stop , start)

 ```:コマンド
 docker-compose { -f < docker-compose.yml のパス > } stop
 docker-compose { -f < docker-compose.yml のパス > } start
 ```

 - コンテナを停止したり、再起動する際に利用します。

<a id="anchor5"></a>

## 5. コンテナ停止・破棄 ( docker-compose down )

 ```:コマンド
 docker-compose { -f < docker-compose.yml のパス > } down
 ```

 - 起動しているコンテナを停止して、コンテナを削除する場合に利用します。<br>**作成されたネットワークも削除されます。**<br>**作成されたボリュームは削除されません。**` docker volume rm ` コマンドで手動削除する必要があります。

<a id="anchor6"></a>

## 6. イメージ作成 ( ビルド ) ( docker-compose build )

 ```:コマンド
 docker-compose build
 ```

 - ビルドするイメージ名を指定しない場合は ` ディレクトリ名_サービス名 ` という名前が付けられます。
 - ビルドコマンドはイメージのビルドを行うだけで **コンテナの作成・起動はされません。**
 - ` docker-compose up -d --build ` のように常にビルドさせることもできます。

<a id="anchor7"></a>

## 7. 環境変数の参照
 - Docker-Compose ファイルは、内部で利用するパラメータを **環境ファイル ( .env )** から読み込むことができます。
 - ` $ { 変数名 } ` を記述することで、**Docker-Compose ファイルと同じディレクトリにある環境ファイル** から値を参照します。

    ```:docker-compose
    version: '3.7'
    services:
      web:
      image: alpine:3.10.3
      container_name: ${CONTAINER_NAME}
    ```
    ```:.env
    CONTAINER_NAME=hogehoge
    ```
