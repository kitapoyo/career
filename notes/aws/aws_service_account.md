# AWS Account
1. [概要](#anchor1)
2. [ルートユーザーのアクセスキー ( Access keys ) 削除](#anchor2)
3. [ルートユーザーの MFA ( 多要素認証 : Multi-Factor Authentication ) 設定](#anchor3)
4. [IAM ユーザーの作成](#anchor4)
5. [IAM グループの作成](#anchor5)
6. [IAM パスワードポリシーの設定](#anchor6)


<a id="anchor1"></a>

## 1. 概要
 - 別の AWS アカウントで作成した環境のサーバーは操作できません。
 - AWS の利用料金は、**AWS アカウント単位** でまとめられます。
 - **AWS サービス**<br>AWS が提供している様々な機能のことです。
 - **AWS リソース**<br>AWS サービスを使用して作成されたもののことです。

### アカウント作成に必要なもの
1. メールアカウント
2. 電話番号
3. クレジットカード ( 無料のサービスしか使用しない場合でも必要です )<br>[AWS Educate](https://aws.amazon.com/education/awseducate/) という学習用アカウントでは、クレジットカードは不要です。

### ルートユーザー ( Root user )
 - AWS アカウントを作成すると、自動で作成されるアカウントです。
 - AWS アカウント関連の操作をすべて操作できる **強力な権限** のアカウントです。<br>AWS の解約やユーザーの管理など特殊な作業以外では、使用しない方が安全です。
 - [AWS セキュリティ認証情報ドキュメント](https://docs.aws.amazon.com/ja_jp/general/latest/gr/root-vs-iam.html)

### IAM ( Identity and Access Management )
 - AWS リソースを安全に使用するために、**認証** と **アクセス許可** の機能を実現する仕組みです。
 - ユーザー単位、またはグループ単位でアクセス許可を設定できます。<br>グループ単位でアクセス許可を設定する方が効率的です。

### リージョン
 - AWS は世界中に展開されている拠点単位で提供されており、その拠点を **リージョン** と呼びます。
 - **指定しているリージョンが異なる場合、異なるリージョンのリソースは画面に表示されません。**<br>起動したまま放置すると、料金が発生しますので注意しましょう。

<a id="anchor2"></a>

## 2. ルートユーザーのアクセスキー ( Access keys ) 削除
 - プログラムなどから AWS アカウントにアクセスする場合に **アクセスキー** が使用されます。<br>ルートユーザーにプログラムでログインすることは推奨されないので、アクセスキーを無効化します。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` ユーザーアカウント名 ▼ ` から ` Security credentials ` を選択します。
3. ` Access keys for CLI, SDK, & API access ` で有効になっているアクセスキーが存在することを確認できます。
4. ` Actions ` > ` Make Inactive ` を選択することで無効化できます。

<a id="anchor3"></a>

## 3. ルートユーザーの MFA ( 多要素認証 : Multi-Factor Authentication ) 設定
 - 認証アプリは **Google Authenticator** を使用します。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` ユーザーアカウント名 ▼ ` から ` Security credentials ` を選択します。
3. ` MFA の有効化 ` > ` 仮想 MFA デバイス ` を選択します。
4. 表示された QR コードを読み込んで、` MFA コード ` を入力します。
5. **仮想 MFA が正常に割り当てられました** と表示されたら成功です。

###  スマートフォンの故障・紛失時の処置
 - ルートユーザーの **メールアドレス** , **電話番号** を使用して復旧ができます。
1. MFA コードの入力画面にて ` MFA の トラブルシューティング `
2. ` 別の要素を使用したサインイン `

<a id="anchor4"></a>

## 4. IAM ユーザーの作成
 - 日常的な開発の操作を行うために、一般的な権限のユーザーを作成します。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` IAM ` を選択します。
3. ` IAM dashboard ` から ` ▶ Access management ` を選択します。
4. ` Users ` を選択し、` Add users ` ボタンをクリックします。
5. ` User name* ` に他のユーザーと重複しない名前を入力します。
6. ` Select AWS access type ` にアクセスする種類を選択します。<br>必ずどちらかを選択する必要があります。<br>` Access key - Programmatic access `<br>` Password - AWS Management Console access `
7. アクセス種類を選択後、` Set permissions ` でアクセス許可を設定します。<br>` Create group ` ：ユーザーとグループの作成を同時に行います。
8. アクセス許可を設定した後の、タグの設定は任意です。
9. 確認画面で設定内容に誤りが無ければ、` Create user ` を選択してユーザーの作成は完了です。<br>MFA の設定も必須ではないですが有効化しておきましょう。

<a id="anchor5"></a>

## 5. IAM グループの作成
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` IAM ` を選択します。
3. ` IAM dashboard ` から ` ▶ Access management ` を選択します。
4. ` User groups ` を選択し、` Create group ` ボタンをクリックします。
5. ` User group name ` 項目にグループ名を入力します。
6. ` Add users to the group ` 項目でユーザーを設定します。<br>既に作成している場合、ユーザーを作成中のグループに追加することができます。
7. ` Attach permissions policie ` 項目で、グループに設定する **アクセス許可のポリシー** を選択します。<br>**PowerUserAccess** ：AWS 内のリソースへの全アクセスを許可します。<br>**IAMFullAccess** ：IAM に関する全アクセスを許可します。
8. 確認画面で設定内容に誤りが無ければ、` Create group ` を選択してグループの作成は終了です。

### IAM ユーザーログイン情報
 - ` IAM dashboard ` に ` AWS Account ` の項目が存在しています。
1. **Account ID** ：ID と パスワードでログインする場合の ID です。
2. **Sign-in URL for IAM users in this account** ：IAM ユーザーログイン URL です。

<a id="anchor6"></a>

## 6. IAM パスワードポリシーの設定
 - 安易なパスワードの使用を制限するため、パスワードの内容や期限に制限を加えます。
1. ルートユーザーで ` AWS Management Console ` にログインします。
2. 画面の ` Services ` から ` IAM ` を選択します。
3. ` IAM dashboard ` から ` ▶ Access management ` を選択します。
4. ` Account settings ` を選択し、` Change password policy ` ボタンをクリックします。
5. ` Set password policy ` から、設定する内容にチェックを入れて ` Save ` ボタンをクリックして終了です。
