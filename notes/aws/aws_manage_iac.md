# Infrastructure as Code
1. [概要](#anchor1)
2. [AWS CLI のインストール](#anchor2)
3. [CloudFormation 実行](#anchor3)

<a id="anchor1"></a>

## 1. 概要
 - 構築するインフラをテンプレートファイルとすることで、様々なリソースを自動でインフラに反映することができます。
 - AWS では、以下の２つが用意されています。<br>これら２つを組み合わせることで<br>**開発 PC から CloudFormation 用のテンプレートファイルを AWS CLI を使用して、AWS リソースを自動作成**<br>などが可能になります。
1. CloudFormation ( AWS CloudFormation )
2. AWS CLI ( コマンドラインインターフェース )


### CloudFormation
 - AWS リソースを **YAML** 形式で作成されたテンプレートファイルで作成・変更するサービスです。

### AWS CLI
 - AWS マネジメントコンソールの機能を、**PowerShell** などのコマンドを通じて実行できるツールです。

## 2. AWS CLI のインストール
1. [インストール](https://aws.amazon.com/cli/) の URL から、各 OS 毎に異なるインストーラーをダウンロードします。
2. ダウンロードした ` .msi ` ファイルを実行します。
3. 以下のコマンドをコマンドプロンプトなどから実行ができれば正しくインストールされています。

    ```:コマンド
    aws --version
    ```

4. IAM のダッシュボードで作業するユーザーの ` Access Key ` を生成します。<br>` Access keys for CLI, SDK, & API access ` > ` Create access key `
5. 認証情報とリージョンの設定をするために以下のコマンドを実行します。

    ```:コマンド
    C:\Users\hoge>aws configure
    AWS Access Key ID [None]: < access key >
    AWS Secret Access Key [None]: < secret access key >
    Default region name [None]: ap-northeast-1
    Default output format [None]: yaml
    ```

6. 特にエラーが表示されなければインストールは終了です。

## 3. CloudFormation 実行
 - テンプレートファイルとして ` myconfig.yaml ` ファイルを作成します。<br>[テンプレートファイルの文法](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/template-reference.html)
 - インフラ構築に利用したテンプレートファイルは、マネジメントコンソールの ` CloudFormation ` > ` Stacks ` で確認できます。

    ```:設定例
    AWSTemplateFormatVersion: "2010-09-09"
    Description: A sample template VPC
    Resources:
      vpc2:
        Type: "AWS::EC2::VPC"
        Properties:
          CidrBlock: 10.1.0.0/16
          Tags:
            - Key: Name
              Value: hogehoge-vpc2
    ```

 - リソースの作成

    ```:コマンド
    aws cloudformation create-stack --stack-name cfstack --template-body file://myconfig.yaml
    ```

 - リソースの更新

    ```:コマンド
    aws cloudformation update-stack --stack-name cfstack --template-body file://myconfig.yaml
    ```

 - リソースの削除

    ```:コマンド
    aws cloudformation delete-stack --stack-name cfstack
    ```
