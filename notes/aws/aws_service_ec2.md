# AWS EC2 ( Elastic Compute Cloud ) Note
1. [概要](#anchor1)
2. [SSH Key Pairs 作成](#anchor2)
3. [EC2 インスタンス作成](#anchor3)
4. [EC2 接続](#anchor4)

<a id="anchor1"></a>

## 1. 概要
 - CPU, メモリ, ディスクなどが備わった、Linux や Windows OS をインストールできる **仮想サーバー** です。
 - EC2 で作成したリソースを **EC2 インスタンス** と呼びます。

<a id="anchor2"></a>

## 2. SSH Key Pairs 作成
 - EC2 に SSH で接続するための **Key Pairs ( キーペア )** を作成します。
 - キーペアの設定項目は以下の通りです。

   |項目|値|説明|
   |---|---|---|
   |名前|個人名|基本的に作業する人に所属するため、作業者の名前を使用することが多いです。|
   |キーペアタイプ|RSA<br>ED25519|ED25519 は、Linux, Mac インスタンスでのみ使用できます。<br>EC2 インスタンスコネクト, EC2 シリアルコンソールは使用できません。|
   |ファイル形式|pem<br>ppk|鍵のファイル形式を設定します。<br>PuTTY では ppk 形式<br>ssh コマンドでは pem 形式|

1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面上の ` Services ` から ` EC2 ` を選択します。
3. ` EC2 Dashboard ` から ` ▶ Network & Security ` > ` Key pairs ` を選択します。
4. 画面の ` Create key pair ` ボタンをクリックし、` Key pair ` 内で設定項目を入力します。
5. ` Create Key Pairs ` ボタンをクリックして作成が終了です。<br>**この時に、秘密鍵がダウンロードされます。** 作成したキーペアの秘密鍵を取得できる唯一の機会です。

### アクセスキーの漏洩対策
 - Git Hub のリポジトリにアクセスキーがプッシュされることを防ぐツールが用意されています。<br>[**git-secrets**](https://github.com/awslabs/git-secrets)

<a id="anchor3"></a>

## 3. EC2 インスタンス作成
1. ` EC2 Dashboard ` から ` ▶ Instances ` > ` Instances ` > ` Launch Instance ` を選択します。
2. AMI を選択します。
3. インスタンスタイプ ( CPU, メモリ, ストレージ ) を設定します。<br>` Next: Configure Instance Details ` ボタンをクリックして次に進みます。<br>※ ` Reviwe and Launch ` を選択すると、今後の設定をデフォルト値として作成がされてしまします。
4. インスタンスの詳細を選択します。<br>` Next: Add Storage ` ボタンをクリックして次に進みます。
5. EC2 インスタンスに割り当てるディスクを設定します。<br>` Next: Add Tags ` ボタンをクリックして次に進みます。
6. インスタンスを区別するためのタグを設定します。インスタンスの動作には影響しません。<br>` Next: Configure Security Group ` ボタンをクリックして次に進みます。
7. セキュリティグループを設定します。<br>` Reviwe and Launch ` ボタンをクリックして次に進みます。
8. 設定項目を確認して、` Launch ` ボタンをクリックして次に進みます。
9. 最後に、SSH 接続に使うキーペアを選択して ` Launch Instance ` ボタンをクリックして作成します。

### AMI ( Amazon Machine Image ) の選択
 - AMI の種類一覧から、使用する AMI の項目の ` Select ` ボタンをクリックして次に進みます。

   |タブ名|説明|
   |---|---|
   |Quick Start|AWS お勧めの AMI が用意 ( 無料版も存在 )|
   |My AMI|作成した EC2 インスタンスのバックアップ ( 運用者が自由に設定 )|
   |AWS Marketplace|サードパーティ製の AMI|
   |Community AMIs|有志によって作成された AMI|

### セキュリティグループの選択

|タブ名|説明|
|---|---|
|default|VPC 内のすべてのリソースからの通信を許可する|

<a id="anchor4"></a>

## 4. EC2 接続
1. ` EC2 Dashboard ` から ` ▶ Instances ` > ` Instances ` を選択します。
2. 接続するインスタンスにチェックを入れて ` Connect ` ボタンをクリックします。
3. SSH 接続するための ` Public IP Address ` と ` User Name ` が表示されます。
4. 上記情報で SSH ログインをします。

### SSH 多段接続
 - **config** という拡張子なしのファイルを作成して、共通の秘密鍵で対象のリソースにアクセスします。<br>ファイルは、秘密鍵と同様にホームディレリクトリの **.ssh/** に保存します。

    ```:ファイル形式
    Host bastion
        Hostname ( 踏み台サーバーの グローバル IP )
        User ( 踏み台サーバーにログインする際のユーザー名 )
        IdentityFile ( 秘密鍵ファイルのパス )

    Host web
        Hostname ( Web サーバーの プライベート IP )
        User ( Web サーバーにログインする際のユーザー名 )
        IdentityFile ( 秘密鍵ファイルのパス )
        ProxyCommand ( 経由する踏み台サーバーの情報 ) -W %h:%
    ```
    - Windows の場合： ` ProxyCommand ssh.exe ( 踏み台サーバー Host 名 ) -W %h:%p `
    - Linux , Mac の場合： ` ProxyCommand ssh ( 踏み台サーバー Host 名 ) -W %h:%p `
