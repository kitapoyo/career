# CI / CD ( Continuous Integration / Continuous Deployment )
1. [CI / CD とは](#anchor1)
2. [Jenkins とは](#anchor2)
3. [Jenkinsfile とは](#anchor3)

<a id="anchor1"></a>

## 1. CI / CD とは
 - 継続的に開発 / デプロイ ( 公開 ) を行うための自動化手法です。
 - SCM ( Source Code MAnagemet ) の **GitHub** や パイプラインの **Jenkins** が有名です。
 - SCM を使用することで、過去から現在までのソースコードを複数人で管理・開発することが容易になります。
 - パイプラインを導入することで、アプリのビルドからデプロイまでを自動化できます。
 - 公開一歩手前のステージング環境で確認した後、手動で本番環境にデプロイする **ブルー / グリーンデプロイ手法** が有名です。

### CI / CD の流れ
1. ローカル環境で開発されたコードを SCM ( GitHub ) に Push して Merge する。
2. SCM にコードが Push されると、CI / CD パイプライン ( Jenkins ) が起動する。
3. パイプラインの定義ファイルが実行されて、記載されている作業を順番に処理する。
4. Jenkins が作成した Docker Image をレジストリにデプロイする。
5. 本番環境にデプロイする。

### Docker CI / CD ( DevOps ) 環境
 - 各ステップを実現するために、本来は様々なソフトウェアを組み合わせる必要があります。
 - Docker の場合は、各ソフトウェアの代わりに、Docker を様々なステップで利用することができます。
1. Docker
2. GitHub
3. Jenkins

<a id="anchor2"></a>

## 2. Jenkins とは
 - **Jenkins は コンパイルが必要なアプリのビルドを目的として多くの用途で利用されているソフトです。**
 - Jenkins が SCM のコードを自動でビルド・テストすることで **コードに変更を加えた段階で全体の整合性を確認できます。**

### パイプライン処理のトリガー
 - **SCM ポーリング**<br>定期的に Jenkins から SCM を監視して、Push があるとビルドを実行する方式。
 - **Web Hook**<br>SCM に変更があった場合に、即ビルドを実行する方式です。SCM から Jenkins に接続する設定が必要です。

<a id="anchor3"></a>

## 3. Jenkinsfile とは
 - Jenkins にパイプライン処理を定義する **パイプライン定義書** です。
 - Jenkins から所得する SCM のリポジトリに Jenkinsfile を載せることで、パイプライン処理を実施するタイミングで<br>アプリのソースコードと一緒に Jenkinsfile を SCM から取得し、そこに記述されたパイプライン処理を実施します。
 - **Groovy** と呼ばれるスクリプト言語でパイプライン処理を記述します。

### 項目

|項目|説明|
|----|----|
|environment|変数の定義|
|stages , stage|パイプライン処理 ( ビルド , テスト , デプロイ ) の処理単位|
|steps|具体的な処理内容|

### 設定例

 ```:jenkinsfile
 pipeline {
   agent any
   // 変数定義
   environment {
     DOCKERHUB_USER = "hogehoge"
     BUILD_HOST = "root@1.1.1.1"
     PROD_HOST = "root@2.2.2.2"
     BUILD_TIMESTAMP = sh(script: "date +%Y%m%d-%H%M%S", returnStdout: true).trim()
   }
   stages {
     // 事前チェック
     stage('Pre Check') {
       steps {
         // Dockerhub 接続確認
         sh "test -f ~/.docker/config.json"
       }
     }
     // ビルド環境でイメージの作成
     stage('Build') {
       steps {
         sh "docker-compose -H ssh://${BUILD_HOST} -f docker-compose.build.yml build"
         sh "docker-compose -H ssh://${BUILD_HOST} -f docker-compose.build.yml up -d"
       }
     }
     // ビルド環境でテストを実施
     stage('Test') {
       steps {
         sh "docker -H ssh://${BUILD_HOST} container exec docker_test . test.sh"
         sh "docker-compose -H ssh://${BUILD_HOST} -f docker-compose.build.yml down"
       }
     }
     // Dockerhub へ Image を登録
     stage('Register') {
       steps {
         sh "docker -H ssh://${BUILD_HOST} tag test_web ${DOCKERHUB_USER}/test_web:${BUILD_TIMESTAMP}"
         sh "docker -H ssh://${BUILD_HOST} push ${DOCKERHUB_USER}/test_web:${BUILD_TIMESTAMP}"
       }
     }
     // 本番環境にデプロイ
     stage('Deploy') {
       steps {
         sh "docker-compose -H ssh://${PROD_HOST} -f docker-compose.prod.yml up -d"
       }
     }
   }
 }
 ```
