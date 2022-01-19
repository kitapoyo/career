# VPC ( Amazon Virtual Private Cloud )
1. [概要](#anchor1)
2. [VPC の作成](#anchor2)
3. [サブネットの作成](#anchor3)
4. [インターネットゲートウェイの作成](#anchor4)
5. [NAT ゲートウェイの作成](#anchor5)
6. [ルートテーブルの作成](#anchor6)
7. [セキュリティグループの作成](#anchor7)

<a id="anchor1"></a>

## 1. 概要
 - ネットワーク機器の持つ機能をソフトウェアを使用して、**物理的な機器を使わずに仮想ネットワークを構築** できます。
 - VPC 同士は独立していて、お互いに干渉しません。
 - VPC 内には、**必ず1つのサブネットを作成する** 必要があります。<br>サブネットを作成すると、CIDR ブロックは変更できません。
 - **アベイラビリティーゾーン** ( リージョン内の複数の独立した拠点 ) を設定することができます。<br>複数のアベイラビリティーゾーンを設定することで、耐障害性を向上できます。

### Elastic IP
 - AWS では、リソースにグローバル IP アドレスを直接持たせることはできません。
 - グローバル IP を管理する **Elastic IP** という機能を AWS リソースに割り当てることで、間接的にグローバル IP を持たせます。
 - Elastic IP は NAT ゲートウェイなどを削除しても残り、未使用でも **使用料金が発生** します。<br>EC2 ダッシュボードからリリースする必要があります。

<a id="anchor2"></a>

## 2. VPC の作成
1. IAM ユーザーで ` AWS Management Console ` にログインします。
2. 画面上の ` Services ` から ` VPC ` を選択します。
3. ` VPC Dashboard ` から ` ▶ VIRTUAL PRIVATE CLOUD ` > ` Your VPCs ` を選択します。<br>Name 項目が **-** の VPC は、**デフォルト VPC** です。削除しても問題ありません。
4. 画面右上の ` Create VPC ` ボタンをクリックし、` Create VPC ` 内で設定項目を入力します。

    |項目|値|説明|
    |---|---|---|
    |Name tag - optional|hogehoge-vpc|VPC を識別するための名前です。<br>後から変更可能です。|
    |IPv4 CIDR ( IPv4 CIDR block ) |10.0.0.0/16 ~ <br>172.16.0.0/16 ~<br>192.168.0.0/16 ~|VPC で使用する IPv4 プライベートネットワークアドレスです。<br>**サブネットで指定できるのは最大１６ビットです。**|
    |IPv6 CIDR ( IPv6 CIDR block ) ||VPC で使用する IPv6 プライベートネットワークアドレスです。|
    |テナンシー ( Tenancy )|Default ( 共有 )<br>Dedicated ( 専用 )|VPC 上のリソースを専用のハードウェアで実行するかを設定します。<br>専用の場合は、追加でコストが発生します。|

5. ` Create VPC ` ボタンをクリックして作成終了です。

<a id="anchor3"></a>

## 3. サブネットの作成
1. ` VPC Dashboard ` から ` ▶ VIRTUAL PRIVATE CLOUD ` > ` Subnets ` を選択します。<br>Name 項目が **-** の サブネットは、**デフォルト VPC のサブネット** です。
2. 画面の ` Create subnet ` ボタンをクリックし、` Create subnet ` 内で設定項目を入力します。<br>複数のサブネットを同時に作成する場合は、 ` Add new subnet ` ボタンをクリックして追加します。

    |項目|値|説明|
    |---|---|---|
    |VPC ID||サブネットを作成する VPC の名前|
    |Subnet name||サブネットに付ける名前|
    |Availability Zone|No preference<br>Subnet name|Amazon が選択するアベイラビリティーゾーンを利用<br>作成したサブネットのアベイラビリティーゾーンの利用|
    |IPv4 CIDR block||VPC のアドレス範囲内の CIDR ブロックネットワークアドレス|

3. ` Create subnet ` ボタンをクリックして作成が終了です。

<a id="anchor4"></a>

## 4. インターネットゲートウェイの作成
 - インターネットゲートウェイとは、VPC で作成されたネットワークとインターネットの間の通信を可能にします。<br>これがないと VPC 内のリソースは、インターネットと相互に通信ができません。
 - VPC にインターネットゲートウェイを設定することを **アタッチする** といいます。
1. ` VPC Dashboard ` から ` ▶ VIRTUAL PRIVATE CLOUD ` > ` Internet Gateways ` を選択します。<br>Name 項目が **-** の サブネットは、**デフォルト VPC のインターネットゲートウェイ** です。
2. 画面の ` Create internet gateway ` ボタンをクリックし、` Create internet gateway ` 内で設定項目を入力します。<br>` Name tag ` ：インターネットゲートウェイに付ける名前
3. ` Create internet gateway ` ボタンをクリックして作成が終了です。
4. 作成したインターネットゲートウェイの画面右にある ` Actions ▼ ` から ` Attach to VPC ` を選択します。
5. ` Available VPCs ` 項目に、インターネットゲートウェイをアタッチする VPC 名 を選択して、` Attach internet gateway ` ボタンをクリックします。<br>` State ` が **Attached** , ` VPC ID ` が ` アタッチする VPC 名 ` になっていればアタッチされています。

<a id="anchor5"></a>

## 5. NAT ゲートウェイの作成
 - NAT 技術を使用するために、AWS では NAT ゲートウェイが用意されています。<br>パブリックなサブネットに対して作成します。
 - NAT ゲートウェイに Elastic IP をアサインした場合は、NAT ゲートウェイを削除しても Elastic IP は解放されません。<br>EC2 ダッシュボードから ` Elastic IPs ` を選択して、` Release ` する必要があります。
1. ` VPC Dashboard ` から ` ▶ VIRTUAL PRIVATE CLOUD ` > ` NAT Gateways ` を選択します。
2. 画面の ` Create NAT gateway ` ボタンをクリックし、` Create NAT gateway ` 内で設定項目を入力します。

    |項目|値|説明|
    |---|---|---|
    |Name - optional||NAT ゲートウェイに付ける名前|
    |Subnet||NAT ゲートウェイを作成するサブネット|
    |Connectivity type|Public<br>Private|外部ネットワーク<br>内部ネットワーク|
    |Elastic IP allocation ID|Select an Elastic IP ( 作成した IP )<br>Allocate Elastic IP ( 自動生成 )|NAT ゲートウェイに割り当てる Elastic IP を指定|

3. ` Create NAT gateway ` ボタンをクリックして作成が終了です。<br>NAT ゲートウェイは有効になるまで、少し時間がかかります。

<a id="anchor6"></a>

## 6. ルートテーブルの作成
 - サブネット間の通信経路を設定するための機能です。<br>ルートテーブルを作成すると、ルーターに相当するものが自動で作成されるイメージです。
 - **送信先 ( Destination )** ：送信先の IP アドレスを指定します。
 - **ターゲット ( Target )** ：経由する箇所を指定します。

    |ターゲット ( Target )|用途|
    |---|---|
    |ローカル|同一 VPC 内のリソースにアクセスするとき|
    |インターネットゲートウェイ|パブリックサブネットに作成されたリソースがインターネットと通信するとき|
    |NAT ゲートウェイ|プライベートサブネットに作成されたリソースがインターネットと通信するとき|
    |VPN ゲートウェイ|VPN で接続された独自ネットワーク上と通信するとき|
    |VPN ピアリング|接続が許可された他の VPC リソースと通信するとき|

1. ` VPC Dashboard ` から ` ▶ VIRTUAL PRIVATE CLOUD ` > ` Route Tables ` を選択します。
2. 画面の ` Create route table ` ボタンをクリックし、` Create route table ` 内で設定項目を入力します。<br>` Name ` ： ルートテーブルに付ける名前<br>` VPC ` ：ルートテーブルを設定するサブネットが含まれる VPC 名
3. ` Create route table ` ボタンをクリックして、ルートテーブルを作成します。
4. ` Route Tables` ダッシュボードから、作成したルートテーブルにチェックを入れて ` Routes ` タブを選択します。
5. ` Edit routes ` ボタンをクリックして、` add routes ` ボタンをクリック後、ルートテーブルの設定項目を入力します。
6. ` Save changes ` ボタンをクリックしてルート情報を保存します。
7. 作成したルート情報に所属するサブネットを指定するため、` subnet associations ` タブの ` Edit subnet associations ` ボタンをクリックします。
8. ` Available subnets ` 項目で、所属させるサブネットを指定して ` Save associations ` ボタンをクリックして保存します。

<a id="anchor7"></a>

## 7. セキュリティグループの作成
 - 外部からのアクセスを **ポート番号** と **IP アドレス** の２つの概念で制限する機能です。<br>リソース ( EC2, RDS ) などに対して設定します。
 - 似たようなアクセス制御で、**ネットワーク ACL** という機能も存在します。<br>サブネットに対して設定をします。サブネットに含まれるリソースすべてが対象となります。
1. ` VPC Dashboard ` から ` ▶ SECURITY ` > ` Security Groups ` を選択します。
2. 画面の ` Create security group ` ボタンをクリックします。
3. ` Basic details ` 項目で以下の内容を設定します。

    |項目|説明|
    |---|---|
    |Security group name|セキュリティグループの名前|
    |Description|セキュリティグループの説明|
    |VPC|セキュリティグループを作成する VPC 名|

4. ` Inbound / outbound rules ` 項目で ` Add rule ` ボタンをクリックしてアクセス制御を設定します。

    |項目|説明|
    |---|---|
    |Type|アプリケーション|
    |Protocol|TCP / UDP|
    |Port range|ポート番号
    |Source / Destination|適用するネットワークアドレス|
    |Description|アクセス制御の説明|

5. ` Create security group ` ボタンをクリックして保存します。
