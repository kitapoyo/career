# Aruba 2930F
1. [Aruba Central](#anchor1)
   - 注意事項
   - Proxy 設定
   - CLI 設定モード
2. [Aruba 仕様](#anchor2)
3. [バックアップ と リストア](#anchor3)
4. [RADIUS 認証テスト](#anchor4)
5. VSF ( Virtual Switching Framework )
   - [VSF とは](#anchor5a)
   - [用語](#anchor5b)
   - [Aruba 2930F の制限事項](#anchor5c)
   - [Discover Configuration モード](#anchor5d)
   - [MAD ( Multiple Active Detection )](#anchor5e)
   - [VSF Link 設定](#anchor5f)
   - [Member Priority 設定](#anchor5g)
   - [VSF Domain 設定と VSF 有効化](#anchor5h)
   - [VSF 関連 Trap 送信有効化](#anchor5i)
   - [VSF 設定削除](#anchor5j)
   - [VSF 設定例](#anchor5k)
   - [VSF 状態確認](#anchor5l)
   - [VSF Link 確認](#anchor5m)
6. Multiple Spanning Tree Protocol ( 802.1s )
   - [概要](#anchor6a)
   - [ルール](#anchor6b)
   - [Rapid-pvst 利用時の注意事項](#anchor6c)
   - [MST インスタンス作成](#anchor6d)
   - [MST インスタンス削除](#anchor6e)
   - [モード設定](#anchor6f)
   - [転送遅延設定](#anchor6g)
   - [BPDU 送信間隔設定](#anchor6h)
   - [ホップカウント設定](#anchor6i)
   - [最大エージ設定](#anchor6j)
   - [プライオリティ設定](#anchor6k)
   - [PortFast 設定](#anchor6l)
   - [LoopGuard 設定](#anchor6m)
   - [パスコスト設定](#anchor6n)

<a id="anchor1"></a>

## 1. Aruba Central
 - [Aruba Central Login Page](https://portal-prod2.central.arubanetworks.com/platform/login/user)

### 注意事項
1. **Central に同期をすると、コンソールや telnet ログインでのコンフィグ変更はできません。**
2. Aruba 2930F で **SNMP** を運用で使用する際に、**Central** を設定するか注意しましょう。<br>**Firm 16.08.0015** 以下の場合、**SNMP 機能** は使用できません。

### Proxy 設定
 - Aruba Central 接続時に使用します。

 ```:設定コマンド
 proxy server http://[ < Domain name | IP Address > ]:< Port number >
 ```

### CLI 設定モード
 - コマンド実行時に **Warning** が表示されます。このコマンドは Save されません。

 ```:設定コマンド
 aruba-central support-mode enable
 ```

<a id="anchor2"></a>

## 2. Aruba 仕様
1. ` show run ` にて設定が表示されない場合は、デフォルト値が設定されている可能性があります。<br>そのため、**デフォルト値を設定する**ことでコンフィグに表示されなくなる ( 設定削除 ) 場合があります。<br>**no** や **delete** などでは入力できないコマンドが多々存在します。
2. **trunk** とは、リンクアグリケーションポートのことです。VLAN の幹線ではありません。
3. interface の Up / Down ( cisco の no shut / shut ) は ` enable / disable ` です。
4. Cisco の ` terminal length 0 ` に相当するコマンドは ` no page ` です。

<a id="anchor3"></a>

## 3. バックアップ と リストア
 - コンフィグバックアップ

 ```:コマンド
 copy config < ファイル名 > tftp < tftp server アドレス > < バックアップするファイル名 >
 ```
 - コンフィグリストア

 ```:コマンド
 copy tftp config < ファイル名 > < tftp server アドレス > < リストアするファイル名 >
 ```

<a id="anchor4"></a>

## 4. RADIUS 認証テスト
 - Catalyst では以下コマンドにて RADIUS サーバに L2 情報が登録されているかを確認できます。<br>` test aaa group radius server <RADIUS IP> test test legacy `
 - メーカに確認しましたが、**Aruba 2930F ではコマンドはございませんでした。**<br>他の機器でも存在しないと思われます。

## 5. VSF ( Virtual Switching Framework )

<a id="anchor5a"></a>

### VSF とは
 - Aruba 5400R x 最大２台、Aruba 2930F x 最大８台構成をサポートするスタック機能 ( 仮想シャーシ機能 ) です。
 - スイッチ間は **40G, 10G, 1G** といった汎用のポートを利用して接続を行います。
 - VSF 使用時の Port 1, 2 の表記は以下のようになります。<br>１台目： **1/1, 1/2**<br>２台目： **2/1, 2/3**<br>３台目： **3/1, 3/2**

<a id="anchor5b"></a>


### 用語

|用語|説明|
|---|---|
|Member ID|VSF ファブリックを構成するスイッチにつける ID です。同一 VSF ファブリック内で重複しないように設定します。|
|VSF Domain ID|VSF ファブリックを識別するための ID です。それぞれでユニークな ID を持つ必要があります。|
|VSF Link|VSF を構成するスイッチ間を接続するスタック用論理ポートです。<br>各スイッチは link 1 と link 2 の２つの論理ポートが用意され、これに物理ポートをアサインしてスタックポートとして利用します。|
|Member Priority|高い値を持ったスイッチが優先となり、Member Priority はデフォルト 128 で 1〜255 の間で設定可能です。|

<a id="anchor5c"></a>

### Aruba 2930F の制限事項
1. 最大8台まで構成可能です。
2. VSF Link として 1G, 10G ポートを利用可能です。 ( ただし、1G, 10G の混在不可 )
3. 各 VSF Link は最大8本までのポートを束ねる ( アサインする ) ことが可能です。
4. 同じ 2930F シリーズ内であれば異なるモデルを組み合わせて構成可能です。
5. VSF を構成するスイッチは直接接続する必要があります。
6. **VSF Port** は、ICMP 監視等ができません。**  MIB 値で監視する際は運用コストに注意しましょう。

<a id="anchor5d"></a>

### Discover Configuration モード
 - ２台目以降のスイッチを初期化状態で接続するだけで自動的に VSF ファブリックの設定を行う設定方法です。
 - １台目のスイッチは VSF Link, Member Priority, VSF Domain 等の設定を行います。
1. ２台目のスイッチ２を工場出荷時の状態にし、１台目のスイッチと接続を行います。
2. ２台目のスイッチは自動的に VSF の設定が行われ、１台目のスイッチから OS をダウンロードして再起動します。

<a id="anchor5e"></a>

### MAD ( Multiple Active Detection )
 - スタックリンク障害時も、VSF ファブリックを構成していた機器が存在することを認識します。
 - スプリットした片側のインターフェースを全てシャットダウンすることでスプリット時の通信への影響を防ぎます。

#### LLDP MAD
 - VSFファブリックのスイッチ跨ぎで Link Aggregation 接続されたスイッチ経由で VSF 構成機器の存在を確認します。<br>**IPV4_ADDR** : MAD Assist Switch の IP アドレス<br>**COMMUNITY-STR** : MAD Assist Switch の SNMP コミュニティ名

 ```:設定コマンド
 vsf lldp-mad ipv4 < IPV4_ADDR > v2c < COMMUNITY-STR >
 ```

 ```:確認コマンド
 show vsf lldp-mad parameters
 show vsf lldp-mad status
 ```

#### VLAN MAD
 - 専用の VLAN を用意し、その VLAN にアサインしたポートを接続することでお互いの存在を確認します。
 - VLAN MAD で使用する VLAN ポートでは基本的に**他の機能との併用**はできません。

 ```:設定コマンド
 vsf vlan-mad < vid >
 ```

 ```:確認コマンド
 show vsf vlan-mad
 ```

<a id="anchor5f"></a>

### VSF Link 設定

 ```:設定コマンド
 vsf member < MEMBER-ID > link < LINK-ID > < PORT-LIST >
 ```

<a id="anchor5g"></a>

### Member Priority 設定
 - デフォルトは 128 です。

 ```:設定コマンド
 vsf member < MEMBER-ID > priority < PRIORITY >
 ```

<a id="anchor5h"></a>

### VSF Domain 設定と VSF 有効化

 ```:設定コマンド
 vsf enable domain < DOMAIN-ID >
 ```

<a id="anchor5i"></a>

### VSF 関連 Trap 送信有効化
 - デフォルトは無効になっています。

 ```:設定コマンド
 snmp-server enable traps vsf
 ```

<a id="anchor5j"></a>

### VSF 設定削除
 - VSF 設定を削除するには VSF Link が全てダウンしている必要があります。

 ```:設定コマンド
 vsf disable
 ```

<a id="anchor5k"></a>

### VSF 設定例

 ```:設定例
 vsf
    enable domain 10
    member 1
       type "JL258A" mac-address xxxxxx-xxxxxx
       priority 200
       link 1 1/7-1/8
       link 1 name "I-Link1_1"
       link 2 name "I-Link1_2"
       exit
    member 2
       type "JL258A" mac-address yyyyyy-yyyyyy
       priority 128
       link 1 2/7-2/8
       link 1 name "I-Link2_1"
       link 2 name "I-Link2_2"
       exit
    port-speed 1g
    exit
 ```

<a id="anchor5l"></a>

### VSF 状態確認
 ```:確認コマンド
 show vsf [ detail ]
 ```

<a id="anchor5m"></a>

### VSF Link 確認

 ```:確認コマンド
 show vsf link detail
 ```

## 6. Multiple Spanning Tree Protocol ( 802.1s )

<a id="anchor6a"></a>

### 概要
 - 工場出荷時のデフォルト設定では、スパニングツリー操作はオフになっています。
 - 調整可能のため、各タイプのパラメータをデフォルト構成のままにしておくことを強くお勧めしているそうです。
 - VLAN を使用してネットワーク内に複数のスパニングツリーを作成します。ネットワークリソースの使用率が大幅に向上します。
 - MSTP 設定コマンドは RSTP とまったく同じように動作します。

<a id="anchor6b"></a>

### ルール
 - デフォルトの構成値を使用すると、スイッチは RSTP / STP デバイスと相互運用できます。
 - MSTP を設定すると、IST が自動的に設定され、設定されたすべての VLAN が IST インスタンスに配置されます。
 - 1 つのリージョンに最大 １６ の MST インスタンス ( 以降 MSTI ) を作成できます。
 - スイッチの優先度が同じである場合、MAC アドレスが最も小さいスイッチがそのリージョンのルートスイッチになります。
 - リンクアグリゲーションのポートを設定すると自動でコストが設定されます。<br>例： **spanning-tree instance 1 Trk1 priority 4**
 - Path Cost

|Port|STP ( 802.1d ) cost|RSTP and MSTP path cost|
|---|---|---|
|10 Mbps|100|2,000,000|
|100 Mbps|10|200,000|
|1 Gbps|5|20,000|

<a id="anchor6c"></a>

### Rapid-pvst 利用時の注意事項
 - VLAN の設定数が**閾値を超えないか**注意しましょう。

 ```:コマンド
 show spanning-tree system-limits rapid-pvst
 ```

<a id="anchor6d"></a>

### MST インスタンス作成
 - MSTI に設定する VLAN ID は 1 〜 4094 です。
 - MSTI に設定されている VLAN は、別の MSTI のメンバーになることはできません。

 ```:設定コマンド
 spanning-tree instance < 1-16 > vlan < vid-vid >
 ```

<a id="anchor6e"></a>

### MST インスタンス削除

 ```:設定コマンド
 no spanning-tree instance < 1-16 > vlan < vid-vid >
 ```

<a id="anchor6f"></a>

### モード設定

 ```:設定コマンド
 spanning-tree mode mstp
 ```

<a id="anchor6g"></a>

### 転送遅延設定
 - デフォルトタイムは 15 秒です。

 ```:設定コマンド
 spanning-tree forward-delay < 4-30 >
 ```

<a id="anchor6h"></a>

### BPDU 送信間隔設定
 - デフォルトタイムは 2 秒です。

 ```:設定コマンド
 spanning-tree hello-time < 1-10 >
 ```

<a id="anchor6i"></a>

### ホップカウント設定
 - デフォルトタイムは 20 秒です。
 ```
 spanning-tree max-hops < 1-40 >
 ```

<a id="anchor6j"></a>

### 最大エージ設定
 - デフォルトタイムは 20 秒です。

 ```:設定コマンド
 spanning-tree maximum < age time >
 ```

<a id="anchor6k"></a>

### プライオリティ設定
 - 優先度を 4096 の乗数（ 0 - 15 ）として指定します。実際の優先度は次のようになります。<br>**priority-multiplier x 4096**

 ```:設定コマンド
 spanning-tree priority < 1-15 >
 ```

<a id="anchor6l"></a>

### PortFast 設定
 - デフォルトは無効です。

 ```:設定コマンド
 spanning-tree < port-list > admin-edge-port
 ```

<a id="anchor6m"></a>

### LoopGuard 設定
  - デフォルトは無効です。

 ```:設定コマンド
 spanning-tree < port-list > loop-guard
 ```

<a id="anchor6n"></a>

### パスコスト設定
 - デフォルトは auto です。

 ```:設定コマンド
 spanning-tree < port-list > path-cost [ auto | 1-200000000 ]
 ```
 - パスコスト計算モード設定

 ```:設定コマンド
 spanning-tree path-cost [ mstp | rapid-pvst ]
 ```
