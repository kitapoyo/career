# Billing and Cost Management
1. [概要](#anchor1)
2. [AWS 料金見積もりツール](#anchor2)
3. [予算の作成](#anchor3)
4. [Cost Explorer](#anchor4)
5. [請求書の確認](#anchor5)
1. [概要](#anchor1)


<a id="anchor1"></a>

## 1. 概要
 - AWS のリソースに対して見積もりや予算に関連する機能を提供します。
 - AWS では、利用した分の料金 ( 使用料 ) を払う仕組みになっています。

### 料金と機能

|料金|対応機能|
|---|---|
|見積もり|[AWS 料金見積もりツール](https://calculator.aws/#/)|
|予算|予算|
|月途中の料金|コストエクスプローラーアラート|
|判断|請求 ( CloudWatch )|
|改善|-|

<a id="anchor2"></a>

## 2. AWS 料金見積もりツール
 - ツールの使用時に、AWS アカウントやログインは不要です。
 - 誰でも無料で利用できます。
1. [AWS 料金見積もりツール](https://calculator.aws/#/) の URL を開きます。
2. ` Create estimate ` ボタンをクリックします。
3. ` Select service ` 利用する予定のサービスを選択します。
4. 利用するサービスの詳細情報を選択します。<br>利用するサービスによって選択項目が変わります。
5. ` Add to my estimate ` ボタンをクリックして、サービス料金が合計金額に加算されます。
6. 必要なサービスの数だけ 3 ~ 5 を実行して、最後に ` Share ` ボタンをクリックして終了です。<br>作成した見積もりは、表示された URL から誰でも閲覧できます。

## 3. 予算の作成
 - IAM ユーザーでは権限が足りずに実行できません。<br>**ルートユーザー** でログインする必要があります。
 - 予算に対して実績や予想が上振れしそうなときは、アラートを発生させることもできます。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` AWS Budgets ` を選択します。
3. ` Create a budget ` ボタンをクリックします。
4. ` Choose budget type ` 項目で予算の種類を選択して、` Next ` ボタンをクリックします。

   |種類|説明|
   |---|---|
   |Cost budget - Recommended|金額ベースの予算|
   |Usage budget|使用量ベースの予算|
   |Savings Plans budget|貯蓄プランの予算|
   |Reservation budget|予約に関連する使用率またはカバレッジを追跡する予算|

5. ` Set your budget ` 項目で予算の詳細を選択して、` Next ` ボタンをクリックします。

   |項目|値|説明|
   |---|---|---|
   |Period|Monthly<br>Daily<br>quarterly<br>annually|予算の単位を設定|
   |Budget effective date|Recurring budget<br>Expiring budget|作成する予算の有効期限の設定|
   |Start month|mm , yyyy|開始月|
   |Enter your budgeted amount ( $ )||指定した間隔での予算上限値|
   |Budget name||予算に付ける名前|

6. ` Configure alerts ` 項目から ` Add an alert threshold ` ボタンをクリックしてアラートの設定をします。<br>設定を入力して、` Next ` ボタンをクリックします。

   |項目|値|説明|
   |---|---|---|
   |Threshold|0 ~ 100 %<br>% of budgeted amount or Absolute value|アラートを発生させる閾値を設定|
   |Trigger|actual ( 実数 )<br>forecasted ( 予測 )|アラートトリガーの発生条件|
   |Email recipients||アラートの送信先のメールアドレス|
   |Amazon SNS Alerts |Choose an Amazon SNS ARN|アラートが発生した際の SNS を指定|

7. 最後に ` Review ` で内容を確認して、` Create budgets ` ボタンをクリックして作成終了です。

<a id="anchor4"></a>

## 4. Cost Explorer
 - 時間単位でリソースがどの程度実行されているかを確認する機能です。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` AWS Budgets ` を選択します。
3. ` Cost Explorer ` 項目を選択して、` Launch Cost Explorer ` ボタンをクリックします。

<a id="anchor5"></a>

## 5. 請求書の確認
 - AWS では一か月ごとに使用した料金の請求書がアカウントに登録されているメールアドレスに送られてきます。
 - ` Billing & Cost Management Dashboard ` の ` Bills ` からも確認ができます。
