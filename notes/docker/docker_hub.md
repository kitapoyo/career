# Dockerhub
1. [Dockerhub とは](#anchor1)
2. [イメージにタグ名を付与 ( tag )](#anchor2)
3. [Dockerhub にアップロード ( push )](#anchor3)

<a id="anchor1"></a>

## 1. Dockerhub とは
 - Docker 社が提供する一般的な公開サービスのパブリックレジストリです。
 - [Dockerhub 公式](https://hub.docker.com/)

    |用語|説明|
    |---|---|
    |レジストリ|Docker のイメージを格納する場所です。<br>イメージはファイルとしても管理できますが、レジストリという仕組みを使って管理ができます。<br>レジストリ上には複数のイメージを置くリポジトリが用意され、異なるバージョンのイメージを複数管理します。|
    |リポジトリ|レジストリをさらに区切った単位のことです。<br>プライベートなリポジトリも作成できます。無料版の場合は１つです。|
    |タグ|同一リポジトリ内の異なるイメージを識別するための目印です。<br>イメージ名にコロンとタグを記載し ` lubuntu:18.04 ` などで表記されます。<br>バージョンを指定しない場合は、最新を表す **latest** になります。|

<a id="anchor2"></a>

## 2. イメージにタグ名を付与 ( tag )
 - Dockerhub レジストリに登録するには、以下の形式にイメージ名を改名する必要があります。

    ```形式
    ユーザー名/イメージ名:{ タグ名 }
    ```
    - タグ名は省略可能です。その場合、デフォルトの **latest** になります。

### イメージ名とタグの変更
 - 元のイメージにタグ名を付けて複製しています。<br>作成したイメージの実体 ( IMAGE ID ) はすべて同じになります。

    ```:コマンド
    docker image tag < 元のイメージ名 > < 新しいイメージ名 >
    ```

<a id="anchor3"></a>

## 3. Dockerhub にアップロード ( push )

### 1. Dockerhub にログイン

 ```:コマンド
 docker login
 Username: #ユーザー名入力
 Password: #パスワード入力
 ```

### 2. イメージをアップロード

 ```:コマンド
 docker image push < イメージ名 >
 ```