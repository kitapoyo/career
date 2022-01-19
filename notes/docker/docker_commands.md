# Docker Commands
1. [概要](#anchor1)
2. [help コマンド](#anchor2)
3. コンテナ関連 ( container )
   - [コンテナの作成 ( run )](#anchor3a)
   - [稼働コンテナでコマンドを発行 ( exec )](#anchor3b)
   - [コンテナ確認 ( ls )](#anchor3c)
   - [コンテナのログ確認 ( logs )](#anchor3d)
   - [コンテナの統計確認 ( stats )](#anchor3e)
   - [コンテナの起動と停止 ( start , stop , restart )](#anchor3f)
   - [停止コンテナを一括削除 ( prune )](#anchor3g)
   - [全コンテナ一括削除 ( rm )](#anchor3h)
   - [コンテナのイメージ化 ( commit )](#anchor3i)
   - [ファイルのコピー ( cp )](#anchor3j)
4. イメージ関連 ( image )
   - [イメージの検索 ( search )](#anchor4a)
   - [イメージのダウンロード ( pull )](#anchor4b)
   - [ローカルイメージの一覧表示 ( ls )](#anchor4c)
   - [イメージの詳細を表示 ( inspect )](#anchor4d)
   - [イメージ削除 ( rm )](#anchor4e)
   - [名前無しイメージ一括削除 ( prune )](#anchor4f)
   - [\<none\> イメージ一括削除 ( rmi )](#anchor4g)
   - [イメージのレイヤー表示 ( history )](#anchor4h)
5. ネットワーク関連 ( network )
   - [ネットワーク一覧表示](#anchor5a)
   - [ネットワークの作成 ( create )](#anchor5b)
   - [ネットワークの削除 ( rm , prune )](#anchor5c)
   - [ネットワークに所属するコンテナ一覧の表示 ( inspect )](#anchor5d)
6. コンテナデータの保存 ( Bind , Volume )
   - [Bind マウント ( run --mount )](#anchor6a)
   - [Volume の作成 ( volume create )](#anchor6b)
   - [Volume マウント ( run --mount )](#anchor6c)
   - [Volume の一覧表示 ( ls )](#anchor6d)
   - [Volume の詳細情報を表示 ( inspect )](#anchor6e)
   - [Volume の削除 ( rm )](#anchor6f)

<a id="anchor1"></a>

## 1. 概要
 - Docker のコマンドは、**操作体系ごとにカテゴリ分け** されています。

    ```:コマンド体系
    docker < 操作カテゴリ > < 操作種類 >
    ```

<a id="anchor2"></a>

## 2. help コマンド
 - ` docker help ` コマンドや ` --help ` オプションでコマンドやオプションの存在を確認できます。

### コマンド体系確認

 ```:コマンド
 docker help
 ```

### カテゴリのヘルプ表示

 ```:コマンド
 docker < カテゴリ名 > help
 ```

### 実行コマンドのヘルプ表示

 ```:コマンド
 docker < カテゴリ名 > run --help
 ```

<a id="anchor3"></a>

## 3. コンテナ関連 ( container )

<a id="anchor3a"></a>

### コンテナの作成 ( run )

 ```:コマンド
 docker container run --name < コンテナ名 > -dit < イメージ名 > { < コンテナで発行するコマンド > }
 docker container run --name < コンテナ名 > -dit < イメージ名 > tail -f /dev/null
 ```

 - 指定したイメージをコンテナ化して起動します。<br>` docker container run ` は **docker start , docker image pull , docker create** の動作をまとめたコマンドです。
 - オプションの ` -dit ` は頻繁に使用します。<br>**バックグラウンドでキーボードからの入力を可能にする** と言う意味です。
 - ` < コンテナで発行するコマンド > ` は省略可能です。
 - ` tail -f /dev/null ` は **コンテナを終了させない** コマンドです。

    |オプション|説明|
    |---|---|
    |--name < コンテナ名 >|コンテナに名前を付けることができます。|
    |-i , --interactive|キーボードからの入力を可能にします。|
    |-t , --tty|TTY で接続端末のデバイスファイル名を割り当てます。<br>作成したコンテナを直接操作するために ` -it ` で使用されます。|
    |-d , --detach|バックグラウンドで起動します。<br>オプションを使用しない場合、コンソールをコンテナに奪われます。|
    |--rm|コンテナを停止したらコンテナを即座に破棄します。|
    |-p < ホストポート番号:コンテナポート番号 >|ホストのポート番号への通信をコンテナのポート番号にポートフォワーディングします。|
    |-e < 環境変数=値 >|環境変数を指定して起動します。|
    |--env-file < ファイル名 >|環境変数を指定したファイルを使用して起動します。<br> ` .env ` ファイルで利用することが多いです。|
    |--network < ネットワーク名 >|コンテナが接続するネットワークを指定します。|

<a id="anchor3b"></a>

### 稼働コンテナでコマンドを発行 ( exec )

 ```:コマンド
 docker container exec < コンテナ名 > < コンテナで発行するコマンド >
 ```

 - コンテナでコマンドを発行 ( execute ) するコマンドです。<br>**既に動作しているコンテナ** の設定ファイルの確認やシェルでログインする際に使用します。

#### 稼働コンテナにログイン

 ```:コマンド
 docker container exec -it < コンテナ名 > < bash | sh >
 ```

#### リダイレクトやパイプ処理

 ```:コマンド
 docker container exec < コンテナ名 > < bash | sh > -c "echo 'hello world' > /hello.txt"
 ```

 - シェル ( bash , sh ) に ` -c ` オプションを使用して、引用符で囲んで実行します。

<a id="anchor3c"></a>

### コンテナ確認 ( ls )

 ```:コマンド
 docker container ls -a { --format='table {{.ID}}\t{{.Names}}' }
 ```

 - イメージ名やコンテナ名と起動時間・発行したコマンドを出力します。
 - ` -a ` オプションを使用しないと **稼働中のコンテナ情報** しか表示されません。
 - ` --format ` オプションを使用すると **指定した項目のみ表示** することができます。

#### 指定したコンテナの詳細情報を表示

 ```:コマンド
 docker container inspect < コンテナ名 >
 ```

<a id="anchor3d"></a>

### コンテナのログ確認 ( logs )

 ```:コマンド
 docker container logs < コンテナ名 >
 ```

 - フォアグラウンドとバックグラウンドで動作しているコンテナのログを表示します。
 - ` -f ` オプションを使用すると **リアルタイム** でログを表示し続けることができます。<br>ログの出力を停止しても、コンテナは停止しません。

<a id="anchor3e"></a>

### コンテナの統計確認 ( stats )

 ```:コマンド
 docker container stats --no-stream
 ```

 - フォアグラウンドとバックグラウンドで動作しているコンテナの CPU 使用率やメモリ消費率を表示します。
 - デフォルトでリアルタイムに表示され続けます。 <br>` --no-stream ` オプションを使用するとコマンド結果が即反映されます。

<a id="anchor3f"></a>

### コンテナの起動と停止 ( start , stop , restart )

 ```:コマンド
 docker container < stop | start | restart > < コンテナ名 >
 ```

#### stop
 - 外部からコンテナにシャットダウン処理をする場合に利用します。
 - プロセスに対して ` SIGTERM シグナル ` で停止依頼をします。<br>停止されない場合は１０秒後に ` SIGKILL ` で強制停止します。
 - ` docker stop kill < コンテナ名 > ` コマンドは強制的に即停止するコマンドです。

#### start
 - 停止されたコンテナを再利用する際に利用します。
 - コンテナを作成した際のオプションのままコンテナを起動します。<br>**コンテナ上に書き込まれたデータは停止前の状態を引き継ぎます。**

#### restart
 - コンテナを再起動する際に利用します。
 - 使い捨ての利用というコンテナの本質に反する操作なので、多用は推奨されません。

<a id="anchor3g"></a>

### 停止コンテナを一括削除 ( prune )

 ```:コマンド
 docker container prune -f
 ```

<a id="anchor3h"></a>

### 全コンテナ一括削除 ( rm )

 ```:コマンド
 docker rm -f
 ```

<a id="anchor3i"></a>

### コンテナのイメージ化 ( commit )

 ```:コマンド
 docker container commit < コンテナ名 > < 作成するイメージ名 >
 ```

 - イメージは **複数の差分を持つ階層** から作られています。<br>そのため、コンテナに変更を加えた後にイメージ化すると、上書きがされます。

<a id="anchor3j"></a>

### ファイルのコピー ( cp )

 ```:コマンド
 docker container cp < コピーするファイルのパス > < コピー先のコンテナ名 >:< コピー先のパス >
 docker container cp < コピー元のコンテナ名 >:< コピー元のパス > < コピーするホストのパス >
 ```

## 4. イメージ関連 ( image )

<a id="anchor4a"></a>

### イメージの検索 ( search )

 ```:コマンド
 docker search < 検索イメージ名 | DESCRIPTION > { --no-trunc }
 ```

 - デフォルトで人気順 ( STARS ) でリポジトリが表示されます。
 - **OFFICIAL** という項目は公式リポジトリであることを意味します。
 - **AUTOMATED** という項目は ` Automated Build ` と呼ばれる機能でビルドされたことを意味します。
 - コマンドの検索対象は **イメージ名だけでなく DESCRIPTION も含まれます。**<br>` --no-trunc ` オプションを使用すると DESCRIPTION を省略せずにすべて表示します。

<a id="anchor4b"></a>

### イメージのダウンロード ( pull )

 ```:コマンド
 docker pull < イメージ名 >
 ```

 - イメージは利用されるタイミングで自動でダウンロードされます。<br>` pull ` コマンドでは任意のタイミングでイメージをダウンロードします。
 - 一度ダウンロードしたイメージはローカルにキャッシュされるため、２度目の ` pull ` ではダウンロードが発生しません。<br>ただし、同一タグのイメージが更新された場合は新しいイメージが再ダウンロードされます。

<a id="anchor4c"></a>

### ローカルイメージの一覧表示 ( ls )

 ```:コマンド
 docker image ls
 ```

 - イメージの実体は **ID** です。**TAG** はそのエイリアスです。<br>そのため、同一のイメージに２つ以上のタグが共有していることがあります。

<a id="anchor4d"></a>

### イメージの詳細を表示 ( inspect )

 ```:コマンド
 docker image inspect < IMAGE ID >
 ```

<a id="anchor4e"></a>

### イメージ削除 ( rm )

 ```:コマンド
 docker image rm < IMAGE ID >
 ```

 - 削除するイメージが **コンテナ ( 停止しているコンテナを含む ) に利用されている** と削除ができません。

<a id="anchor4f"></a>

### 名前無しイメージ一括削除 ( prune )

 ```:コマンド
 docker image prune -f { -a }
 ```

 - オプションなしの場合、 ` dangling ` と呼ばれる名前なしイメージを消すのみです。
 - ` -f ` オプションを使用すると確認無しで削除します。
 - ` -a ` オプションを使用すると **コンテナで参照されていないすべてのイメージ** を削除します。

<a id="anchor4g"></a>

### \<none\> イメージ一括削除 ( rmi )

 ```:コマンド
 docker images -f "dangling=true"
 docker rmi $(docker images -f "dangling=true" -q)
 ```

 - ` -f ( フィルタ ) ` オプションを使うと **\<none\>** イメージを抽出することができます。

<a id="anchor4h"></a>

### イメージのレイヤー表示 ( history )

 ```:コマンド
 docker image history < イメージ名 >
 ```

 - ` missing , none ` のイメージは、名前を失ったイメージや一時的なイメージです。

## 5. ネットワーク関連 ( network )
 - Docker ネットワークの基本は **NAT** です。<br>Docker ホストは自身が持つネットワークインターフェースを NAT の外部インターフェースとして使用します。
 - Docker コンテナ内の名前解決は、コンテナ自身がネームサーバーとなり、Docker エンジンに解決を依頼します。
 - Docker ネットワークドライバーの種類

    |DRIVER|説明|
    |---|---|
    |bridge|デフォルトの NAT 用ネットワークです。<br>ポートフォワーディングの設定をしないと、外部からのコンテナへの通信はできません。<br>作成した NAT ネットワークでは **内部のコンテナが他のコンテナの名前解決が可能** です。|
    |host|Docker ホストのネットワークをそのまま利用します。<br>利用するポート番号も共有されるので、同じポートは使用できません。|
    |none|none ネットワークに属するコンテナはネットワークインターフェースを持ちません。<br>内部の他のコンテナや外部との通信はできません。|


<a id="anchor5a"></a>

### ネットワーク一覧表示 ( ls )

 ```:コマンド
 docker network ls
 ```

<a id="anchor5b"></a>

### ネットワークの作成 ( create )

 ```:コマンド
 docker network create { -d < ネットワークタイプ > } < ネットワーク名 >
 ```

 - ` -d , --driver ` オプションを使用すると、作成するネットワークドライバーを指定できます。<br>デフォルトでは ` bridge ` ドライバーです。

<a id="anchor3c"></a>

### ネットワークの削除 ( rm , prune )

 ```:コマンド
 docker network rm { -f } < ネットワーク名 >
 docker network prune { -f }
 ```

 - **rm** ：コンテナが利用していないネットワークを削除する場合に利用します。
 - **prune** ：コンテナが利用していないすべてのネットワークを削除する場合に利用します。デフォルトネットワークは削除されません。

<a id="anchor3d"></a>

### ネットワークに所属するコンテナ一覧の表示 ( inspect )

 ```:コマンド
 docker network inspect < ネットワーク名 >
 ```

## 6. コンテナデータの保存 ( Bind , Volume )
 - コンテナ上のデータを保存するための手法で２つあります。

    |手法|説明|
    |---|---|
    |Bind|ホストの指定したディレリクトリをコンテナにマウントします。<br>コンテナとホストでディレクトリ内のデータを共有する形で利用します。<br>片方でデータを更新した場合は、片方のデータも更新されます。|
    |Volume|Docker エンジンが管理する **ボリューム ( Volume )** と呼ばれるストレージ領域を作成して、コンテナにマウントします。<br>名前によって領域を管理することができます。|

<a id="anchor6a"></a>

### Bind マウント ( run --mount )

 ```:コマンド
 docker container run -v < ホスト側の記憶領域のパス > : < コンテナの記憶領域のパス > < イメージ名 >
 docker container run --mount type=bind,source=< ホストのディレクトリ >,target=< コンテナのディレクトリ >,{ readonly } < イメージ名 >
 ```

 - デフォルトでは ` type=volume,readwrite ` でマウントされます。

<a id="anchor6b"></a>

### Volume の作成 ( volume create )

 ```:コマンド
 docker volume create < ボリューム名 >
 ```

 - ボリュームの作成位置は、**Docker Engine が適切に設定してくれます** ので意識しないで構いません。

<a id="anchor6c"></a>

### Volume マウント ( run --mount )

 ```:コマンド
 docker run -v < ボリューム名 > : < コンテナの記憶領域のパス >
 docker container run --mount source=< ボリューム名 >,target=< コンテナのディレクトリ > < イメージ名 >
 ```

<a id="anchor6d"></a>

### Volume の一覧表示 ( ls )

 ```:コマンド
 docker volume ls
 ```

<a id="anchor6e"></a>

### Volume の詳細情報を表示 ( inspect )

 ```:コマンド
 docker volume inspect < ボリューム名 >
 ```

<a id="anchor6f"></a>

### Volume の削除 ( rm )

 ```:コマンド
 docker volume rm < ボリューム名 >
 ```
