# AWS S3 ( Simple Storage Service ) Note
1. [概要](#anchor1)
2. [バケットの作成](#anchor2)
3. [バケットに対するロールの作成](#anchor3)
4. [EC2 インスタンスにロールを適用](#anchor4)
5. [EC2 からファイルのアップロード](#anchor5)
6. [IAM AmazonS3FullAccess](#anchor6)

<a id="anchor1"></a>

## 1. 概要
 - ストレージの管理を行うマネージドサービスで、簡単に専用のストレージを用意できます。
 - 障害耐久性やコストの面で圧倒的な優位性があります。
 - あくまでストレージなので、ファイルシステムとしてマウント等はできません。

### S3 へのアクセス
 - S3 は、**VPC の外側** に作成するものです。<br>そのため、アクセス方法は基本的に以下の２つです。
1. インターネットからの直接アクセス
2. VPC リソースからのアクセス ( S3 に対するアクセス権の設定が必要です。)

### バケット ( Bucket )
 - S3 にデータを保存するために、**バケット ( Bucket )** という管理するデータをひとまとまりにした単位を作成する必要があります。
 - バケットの中に保存するデータを、**オブジェクト** と呼びます。<br>画像 , 音声 , 動画などファイルとして扱える、ものはすべて、S3 オブジェクトとして扱えます。
 - フォルダーを作成して、データを構造的に管理することもできます。

<a id="anchor2"></a>

## 2. バケットの作成
 - バケット名は、**同じリージョン内で重複しない名前** である必要があります。<br>別の AWS アカウントで使用されているバケット名は使用できません。<br>バケット名は、ドメイン名などを含めることが望ましいです。
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` S3 ` を選択します。
3. ` Amazon S3 ` ダッシュボードから ` Buckets ` > ` Create bucket ` ボタンをクリックします。
4. ` General configuration ` 内で設定項目を入力します。

    |項目|値|説明|
    |---|---|---|
    |Bucket name|任意|バケット名は一意<br>スペース、大文字は使用不可|
    |AWS Region|Asia Pacific ( Tokyo )|バケットを作成するリージョンを指定|
    |Copy settings from existing bucket - optional|Choose bucket|既存のバケットの設定を踏襲する場合|

5. ` Block Public Access settings for this bucket ` で、データに対するアクセス権項目を設定します。<br>デフォルトでは、` Block all public access ` です。
6. ` Create bucket ` のボタンをクリックして作成終了です。

<a id="anchor3"></a>

## 3. バケットに対するロールの作成
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` IAM ` を選択します。
3. ` IAM Dashboard ` から ` ▶ Access management ` > ` Roles ` を選択します。
4. ` Create role ` ボタンをクリックして、` Create role ` 項目を設定します。
5. ` Select type of trusted entity ` で、ロールに割り当てるエンティティの種類を選択します。

    |種類|説明|
    |---|---|
    |AWS Service|EC2 , Lambda など|
    |Another AWS Account|サードパーティ|
    |Web identity|Cognito , Open ID provider|
    |SGML 2.0 federation|企業ディレリクトリ|

6. ` Choose a use case ` で、ユースケースを選択して、` Next: Permissions ` ボタンをクリックします。
7. ` Attach permissions policies ` で、ロールに割り当てるアクセス権を設定します。<br>` AmazonS3FullAccess ` ：今後作成する S3 すべてにアクセス権を付与
8. ` Next: Tags ` ボタンをクリックして、` Next: Review ` ボタンをクリックします。
9. 最後に、ロール名を入力後 ` Create role ` ボタンをクリックして作成終了です。

<a id="anchor4"></a>

## 4. EC2 インスタンスにロールを適用
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` EC2 ` を選択します。
3. 対象のインスタンスにチェックを入れて、` Actions ` > ` Instance Settings ` > ` Attach / Replace IAM Role ` を選択します。
4. 作成したロールを選択して終了です。

<a id="anchor5"></a>

## 5. EC2 からファイルのアップロード

 ```:コマンド
 aws s3 cp < コピー元ファイル > s3:< バケット名 >
 ```

<a id="anchor6"></a>

## 6. IAM AmazonS3FullAccess
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` IAM ` を選択します。
3. ` IAM ` ダッシュボードから ` Policies ` > ` AmazonS3FullAccess ` の + ボタンをクリックします。
4. JSON 表記で現在の設定が確認できます。

    ```:設定例
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*",
                    "s3-object-lambda:*"
                ],
                "Resource": "*"
            }
        ]
    }
    ```

    - **Effect** ：以下の設定の許可 / 拒否
    - **Action** ：S3 に対する操作 ( \* ：すべての操作 )
    - **Resource** ：対象の S3 バケット ( \* ：すべての S3 バケット )

### 特定のバケットのみ許可する場合
 - 新たにポリシーを作成します。

    ```:設定例
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*",
                    "s3-object-lambda:*"
                ],
                "Resource": [
                   "arn:aws:s3:::(バケット名)",
                   #=> S3 バケット自身を指定
                   "arn:aws:s3:::(バケット名)/*"
                   #=> S3 バケットの中身を指定
                ]
            }
        ]
    }
    ```
