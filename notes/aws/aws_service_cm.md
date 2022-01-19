# ACM ( AWS Certificate Manager ) Note
1. [概要](#anchor1)
2. [ドメイン検証済 ( DV ) 証明書の発行](#anchor2)

<a id="anchor1"></a>

## 1. 概要
 - SSL サーバー証明書を発行する認証機関としての機能です。
 - 認証するもののレベルによって審査の厳しさやコストが増減します。
1. ドメイン検証済 ( DV ) 証明書<br>ドメインの正しさを証明します。
2. 組織認証済 ( OV ) 証明書<br>ドメインの正しさとドメインを管理する会社の名前を保証します。
3. 拡張認証 ( EV ) 証明書<br>ドメインを管理する会社の実在や信頼性を保証します。

<a id="anchor2"></a>

## 2. ドメイン検証済 ( DV ) 証明書の発行
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` AWS Certificate Manager ` を選択します。
3. ` AWS Certificate Manager Dashboard ` から ` Request certificate ` > `を選択します。
4. ` Certificate type ` を選択して、 ` Next ` ボタンをクリックします。<br> ` Request a public certificate ` を選択します。
5. ` Request public certificate ` 項目を選択します。<br>証明書を発行するために、検証方法の指定が必要です。

    |項目|値|説明|
    |---|---|---|
    |Domain names|FQDN|クライアントからアクセスする際のドメイン名を指定|
    |Select validation method|DNS validation - recommended<br>Email validation|DNS の検証 ( DNS サーバーを管理している場合 )<br>E メールによる検証|
    |Tags|省略可||

6. ` Request ` ボタンをクリックして終了です。数分で発行されます。<br>検証で DNS の検証を指定した場合は、具体的な検証方法の設定が必要です。<br>Route53 の場合は、自動で設定してくれる項目が存在します。
