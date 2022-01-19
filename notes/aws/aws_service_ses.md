# AWS SES ( Simple Email Service )
1. [概要](#anchor1)
2. [ドメインの設定](#anchor2)
3. [検証済みメールアドレスの追加](#anchor3)
4. [SMTP によるメール送信](#anchor4)
5. [S3 に受信メールを保存](#anchor5)
6. [サンドボックス外に移動](#anchor6)

<a id="anchor1"></a>

## 1. 概要
 - メールの送受信を行う機能を提供するマネージドサービスです。
 - 通常のメールサーバーとは異なり、**アプリがメールを送受信するのに都合がよい機能** が備わっています。

    |項目|メールサーバー|AWS SES|
    |---|---|---|
    |メール送信|SMTP|IAM ユーザー|
    |メール受信|POP3<br>IMAP4|アクション|

### メールの送信
 - アプリからメールを送信するために、特別なアカウント ( IAM ) を使用してメールを送信します。
 - SES に接続する際は ID , Password ではなく、以下の方法で認証を行います。
1. **Amazon SES API**<br>SES が用意している API を経由して、直接やり取りする方法です。<br>使用しているプログラミング言語の SDK ( ソフトウェア開発キット ) や AWS コマンドラインインターフェースを使用してメールを送信します。
2. **Amazon SES SMTP インターフェース**<br>通常のメールサーバーと同様に SMTP を使用してメールを送信します。

### メールの受信
 - SES では、メールを受信した際に **アクション** と呼ばれる処理が実行されます。<br>このアクションを使用して、独自 API などを起動できるので、ユーザーから届いたメールをリアルタイムで処理できます。

    |アクション|動作|
    |---|---|
    |S3 アクション|届いたメールを S3 に保存する|
    |SNS アクション|届いたメールを Amazon SNS トピックに公開する<br>( メール受信時に、メールや携帯のプッシュ通知を送る )|
    |Lambda アクション|Lambda 関数を実行する<br>( アプリ独自の API を実行する )|
    |バウンスアクション|送信者にバウンス応答 ( 無効なメールなど ) を返す|
    |停止アクション|届いたメールを無視する|

### サンドボックス
 - 外部に閉胸を与えないように閉じられた環境のことです。
 - SES を作成した際に悪用を防ぐためにサンドボックス内に配置され、以下の制限が行われます。<br>制限を解除するためには、AWS サポートセンターにリクエストを送信する必要があります。
1. メールの送信先は、検証済みのアドレスのみ可能
2. メールの送信元は、検証済みのアドレスか登録したドメインのみ可能
3. 送信できるメールの数は、` 200 通 / 24 時間 ` でかつ ` 1 通 / 1 秒 ` に制限

### ダッシュボード
 - ` Use the classic console ` での作成手順で記載します。
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面上の ` Services ` から ` SES ` を選択します。
3. ` SES Dashboard ` から ` Use the classic console ` を選択します。

<a id="anchor2"></a>

## 2. ドメインの設定
 - メールサーバーで管理するドメインの設定をします。
1. ` SES Home ` から ` Domains ` を選択し、` Verify a New Domain ` ボタンをクリックします。
2. ` Verify a New Domain ` 項目を入力して、` Verify This Domain ` ボタンをクリックします。

    |項目|説明|
    |---|---|
    |Domains|新しく追加するドメイン名|
    |Generate DKIM Settings|DKIM ( DomainKeys Identified Mail ) といなりすまし対策の有無<br>無料で利用可能|

3. ` Verify a New Domain ` 項目に DNS サーバーに登録すべき設定一覧が表示されます。<br>Route53 が使用可能である場合、` Use Route 53 ` ボタンが表示されますので、クリックします。
4. クリックした場合、すべての DNS レコードが追加されます。<br>MX レコードに関しては、上書きするかの警告が表示されます。

<a id="anchor3"></a>

## 3. 検証済みメールアドレスの追加
 - SES はサンドボックス内に存在するため、検証済みのメールアドレスしか送受信できません。
1. ` SES Home ` から ` Email Addresses ` を選択し、` Verify a New Email Address ` ボタンをクリックします。
2. 追加するメールアドレスを入力して、` Verify This Email Address ` ボタンをクリックします。
3. 入力したメールアドレス宛に、検証用のメールが送信されます。<br>記載されている URL をクリックして、検証用のメールアドレスが追加されます。

### 管理コンソールからのテストメールの送信
1. ` SES Home ` から ` Domains ` を選択し、作成したドメインを選択して、` Send a Test Email ` クリックします。
2. メールの内容を入力して、` Send Test Email ` ボタンをクリックすると、メールが送信されます。

<a id="anchor4"></a>

## 4. SMTP によるメール送信
 - Amazon SES SMTP インターフェースを使用してメールを送信します。
 - SMTP では、通常 ` Port 25 ` ですが、EC2 はデフォルトでアクセスが制限されています。<br>代用として ` Port 465 ` を指定したりします。
1. ` SES Home ` から ` SMTP Settings ` を選択し、` Create My SMTP Credentials ` ボタンをクリックします。
2. SMTP 認証を行うための、IAM ユーザーを作成します。<br>` IAM User Name: ` 項目に、アプリから送られるメール送信者の名前の入力して ` Create ` ボタンをクリックします。<br>名前は ` no-reply ` など
3. 認証ユーザーが作成されますので、` Download Credentials ` ボタンをクリックして、認証情報をダウンロードします。

    |認証情報項目|説明|
    |---|---|
    |IAM User Name|メール送信者の名前|
    |Smtp Username|SMTP 認証のユーザー|
    |Smtp Password|SMTP 認証のパスワード|

4. SMTP でメールを送信する準備は終了です。プログラムを使用したりしてメールを送信することができます。

<a id="anchor5"></a>

## 5. S3 に受信メールを保存
1. ` SES Home ` から ` Rule Sets ` を選択し、` Create a Receipt Rule ` ボタンをクリックします。
2. 受信可能なメールアドレスを設定します。<br>メールアドレスを入力して ` Add Receipt ` ボタンをクリックし、` Next Step ` ボタンをクリックします。
3. メール受信時のアクションを設定します。<br>` Add action ` で ` S3 Action ` を選択します。
4. ` S3 bucket ` で受信したメールを保存する S3 を選択して、` Next Step ` ボタンをクリックします。
5. ルールの詳細情報を設定します。<br>` Rule name ` を入力して、その他の設定はデフォルトで ` Next Step ` ボタンをクリックします。
6. 最後に、入力情報を確認して ` Create Rule ` ボタンをクリックして設定終了です。

<a id="anchor6"></a>

## 6. サンドボックス外に移動
1. ` SES Home ` から ` Sending Statistics ` を選択し、` Edit your account details ` ボタンをクリックします。
2. メールサーバーの制限解除のために各種情報を入力して、AWS の承認を待ちます。<br>入力が終了したら、` Submit for review ` ボタンをクリックします。

    |項目|説明|
    |---|---|
    |Enable Production Access|本番用の有無|
    |Mail type|メールの用途 ( 業務 , プロダクション )|
    |Website URL|メールサーバーを利用する Web サイトの URL|
    |Use case description|メールサーバーの利用手段|
    |Additional contact addresses|メールサーバーから送られるメールに対する問い合わせ先|
    |Preferred contact language|制限解除申請のやり取りの言語 ( 英語 , 日本語 )|

3. 申請が承認されると、サンドボックス外に SES が移動された通知のメールが送信されます。
