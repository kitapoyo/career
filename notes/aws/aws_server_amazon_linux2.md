# Amazon Linux 2
1. [概要](#anchor1)
2. [EC2 インスタンスの作成](#anchor2)
   - SSH アクセス
3. [IAM ロール でアクセス権限を設定](#anchor3)
   - EC2 インスタンス にロールをアタッチ
   - インスタンスへアクセス
4. [S3](#anchor3)
5. [EBS ( Amazon Elastic Block Store )](#anchor5)
6. [EFS ( Amazon Elastic File System )](#anchor6)
   - セキュリティグループ作成
   - ファイルシステム作成
7. [Amazon RDS](#anchor7)
8. [AWS CodeCommit ( Git )](#anchor8)

<a id="anchor1"></a>

## 1. 概要
 - **Amazon Elastic Computer Cloud ( EC2 )** を使用します。
 - Linux OS は **Amazon Linux 2 AMI** を使用します。ディストリビューションは **Red Hat 系** です。

<a id="anchor2"></a>

## 2. EC2 インスタンスの作成
1. ` Launch instance ` > ` Amazon Linux 2 ` > ` Select ` > ` Configure Security Group `
2. キーの作成ダイアログが表示されるので ` Create a new key pair ` を選択します。<br> **[ Download Key Pair ]** ( SSH 接続に必要なファイルなので削除しないでください )
3. インスタンスの状態が **running** と表示されれば成功です。

### SSH アクセス
 - **Public IPv4 address** が接続するための IPアドレス です。
 - ログインする際は、ユーザー名 **ec2-user** を指定してください。<br>**ec2-user** は、Amazon Linux 2 起動時に作成されるユーザーです。
 - 秘密鍵は、先ほど **( EC2 インスタンスの作成 項番 4 )** でダウンロードした **.pem** を使用してください。

<a id="anchor3"></a>

## 3. IAM ロール でアクセス権限を設定
1. ` IAM ` > ` Roles ` > ` Create role ` > ` Common use cases ` > **EC2** を選択します。
2. ` Attach permissions policies ` > ` AmazonSSMManagedInstanceCore ` > ` Review ` > ` Role name ` > ` [ Create role ] `

### EC2 インスタンス にロールをアタッチ
1. ` EC2 ` > ` Instances ` > ` Modify IAM role ` に作成したロールを割り当てます。
2. インスタンスを再起動します。

### インスタンスへアクセス
1. ` AWS Systems Manager ` > ` Session Manager ` > ` [ Get started ] `<br>コンソール画面が表示されたら成功です。

<a id="anchor4"></a>

## 4. S3
1. ` Identity and Access Management ( IAM ) `> ` Roles `> ` [ Attach policies ] `> ` AmazonS3FullAccess `
2. **aws configure** を実行し、以下内容で登録します。

    ```:設定項目
    AWS Access Key ID [None]:
    AWS Secret Access Key [None]:
    Default region name [None]: ap-northeast-1 # 東京を指定します。
    Default output format [None]: json
    ```

3. S3 バケットを作成します。<br>S3 バケットは、世界で一意の名前で登録する必要があります。<br>例として **hogehoge**で記載しています。

    ```:コマンド
    aws s3 mb s3://hogehoge
    ```

 - ファイルのアップロード

    ```:コマンド
    aws s3 cp test.txt s3://hogehoge
    ```

 - ファイル削除

    ```:コマンド
    aws s3 rb s3://hogehoge/test.txt --force
    ```
    - **--force** を指定すると、オブジェクトも合わせて削除します。<br>**rb = remove backet** の意味です。

<a id="anchor5"></a>

## 5. EBS ( Amazon Elastic Block Store )
 - EC2 にアタッチされているブロックストレージのサービスが EBS です。
1. ` EC2 ` > ` Elastic Block Store `> ` Volumes `> ` Modify Volume `
2. 再起動することでボリュームの変更が反映されます。<br>` df -h ` コマンドを実行して **/dev/xvda1** が対象のボリュームです。

<a id="anchor6"></a>

## 6. EFS ( Amazon Elastic File System )
 - 複数の EC2 インスタンスから、共通のファイルシステムとしてマウントできるサービスです。

### セキュリティグループ作成
1. ` EC2 `> ` Security Groups `> ` Create security group `> ` inbound `> ` NFS `> ` インスタンス sg `

### ファイルシステム作成
1. ` EFS ` > ` [ Create file system ] `
2. 表示されている **fs- から始まる ファイルシステム ID** をコピーしておきます。
3. ` Network ` > ` Security groups ` を作成したインスタンスで設定します。
4. 使用するインスタンスで、インストールします。

    ```:コマンド
    sudo yum install -y amazon-efs-utils
    ```

5. 共有するフォルダーを作成します。フォルダ名は任意ですが、例として **efs** としています。

    ```:コマンド
    sudo mkdir /mnt/efs
    ```

6. ファイルシステムをマウントします<br>**fs-xxxxxx** の箇所はコピーしたファイルシステム ID です。

    ```:コマンド
    sudo mount -t efs -o tls fs-xxxxxxxx:/ /mnt/efs/
    ```

<a id="anchor7"></a>

## 7. Amazon RDS
1. インスタンスにインストールします。

    ```:コマンド
    sudo yum -y install mysql
    ```

2. データベースを作成します。<br>` [ Create database ] `<br>**Auto generate a password** の設定をした際は ` [ View credential details ] ` でパスワードを確認してください。
3. セキュリティグループを作成します。<br>` [ Create security group ] ` > ` Outbound rules Type ` > ` MYSQL/Aurora ` > ` Connectivity `
 - ログイン

    ```:コマンド
    sudo mysql -h database-2.xxxxxx.ap-northeast-1.rds.amazonaws.com -u admin -p <password>
    ```

<a id="anchor8"></a>

## 8. AWS CodeCommit ( Git )
1. インスタンスにインストールします。

    ```:コマンド
    sudo yum -y install git
    ```

2. 権限の付与します。
    - ` IMA Roles ` > **AWSCodeCommitPowerUser** の権限をアタッチします。

3. Git の設定をします。

    ```:設定例
    # ユーザー名を hoge で作成しています。
    git config --global credential.helper '!aws --region ap-northeast-1 codecommit credential-helper $@'
    git config --global credential.UseHttpPath true
    git config --global user.name "hoge"
    ```

4. リポジトリを作成します。リポジトリ名を **MyDemoRepo** で作成しています。

    ```:設定例
     aws codecommit create-repository \
     --repository-name MyDemoRepo \
     --repository-description "My demonstration repository"
    ```
