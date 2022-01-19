# Docker Notes

## Note Index

|Item|File name|Description|
|---|---|---|
|Docker in CentOS7|docker_install_in_centos7.md|CentOS7 に Docker をインストール|
|Docker in Ubuntu|docker_install_in_ubuntu.md|Ubuntu に Docker をインストール|
|Dockerfile|docker_dockerfile.md|Dockerfile の使い方|
|Docker Commands|docker_commands.md|Docker コマンド一覧|

## Tool & Library Index

|Item|File name|Description|
|---|---|---|
|Docker Compose|docker_compose.md|Docker Compose の使い方|
|Docker Hub|docker_hub.md|Docker Hub の使い方|
|Docker CI / CD|docker_cicd.md|Docker CI / CD 基礎|
|Kubernetes|docker_k8s.md|Kubernetes 基礎|

## Memo

### Docker プロセス
 - **起動時のコマンドがすべてのプロセスの原点** となります。<br>Process ID 1 が停止するとコンテナが停止します。

### supervisor
 - プロセスを管理するソフトウェアで１つのコンテナに複数のアプリを動かすことができます。

### リモート Docker ホスト
 - SSH を使用して Docker コマンドを別のサーバーに対して実施することができます。
 - Dcoker-Compose でも条件がありますが、リモートの操作が可能です。

    ```:コマンド
    docker -H ssh://< ユーザー名 >@< 宛先 IP | ホスト名 > < コマンド >
    docker-compose -H ssh://< ユーザー名 >@< 宛先 IP | ホスト名 > up -d
    ```

 - **Ansible** という構成管理ツールを使用することで Docker ホストを構築できます。<br>定義ファイルは **PlayBook** と呼ばれており、YAML 形式で定義します。

    ```:インストール
    yum -y install epel-release ansible
    ```

### ホットリロード
 - コンテナのデメリットで **ソースコードの変更結果がすぐに確認できない** ことがあります。
 - **イメージが参照するコードの領域にバインドマウントで上書きしてコンテナを起動する** ことで変更を即確認できます。

### KVS
 - キー ( Key ) と バリュー ( Value ) の組み合わせを管理して、それを操作する手段を提供する技術です。<br>プログラミングの辞書型や Hash に近いです。

   |操作|説明|
   |---|---|
   |SET|新しくキーとバリューのペアを登録します。<br>**既に存在しているキーに ` SET ` した場合は、古いバリューが新しいバリューに上書きされます。**|
   |GET|キーを指定して、対応するバリューを取得します。|
   |DELETE|キーを指定して、指定したキーと対応するバリューを削除します。|

### REST API
 - **HTTP ベースの API** です。
 - アプリサーバーがクライアントからの HTTP メソッドを 変換して REST API に命令します。
