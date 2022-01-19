# Aruba 2930f Config
1. 基本設定
   - [ホスト名](#anchor1a)
   - [ユーザー & パスワード](#anchor1b)
   - [セッションタイムアウト](#anchor1c)
   - [タイムゾーン](#anchor1d)
   - [NTP](#anchor1e)
   - [L3 機能有効化](#anchor1f)
   - [デフォルトゲートウェイ](#anchor1g)
   - [ダイレクトブロードキャス](#anchor1h)
   - [SNMP](#anchor1i)
   - [DHCP Relay](#anchor1j)
   - [Syslog](#anchor1k)
   - [Proxy](#anchor1l)
2. ACL ( access-list )
   - [ルール](#anchor2a)
   - [Extended ACL 作成](#anchor2b)
   - [物理インターフェースへ適用](#anchor2c)
   - [VLAN インターフェースへ適用](#anchor2d)
   - [ACL シーケンス番号の再振り](#anchor2e)
   - [Extended ACL の確認](#anchor2f)
   - [ACL リソースの確認](#anchor2g)
   - [ACL の統計表示 ( 許可 , 拒否 )](#anchor2h)
3. ポリシールーティング
   - [ポリシーの作成](#anchor3a)
   - [ポリシーの適用](#anchor3b)
   - [ポリシールーティングの統計表示](#anchor3c)
4. ミラーポート
   - [ミラーセッションの作成](#anchor4a)
   - [ポートモニタ設定](#anchor4b)
   - [ミラー確認](#anchor4c)
5. Link-keepalive ( UDLD )
   - [動作メカニズム](#anchor5a)
   - [UDLD 有効化](#anchor5b)
   - [コントロールパケット送信間隔設定](#anchor5c)
   - [最大リトライ数設定](#anchor5d)
   - [コントロールパケット送信の tag 指定](#anchor5e)
   - [UDLD 有効ポートのサマリ情報を表](#anchor5f)
   - [UDLD 有効ポートの統計情報を表示](#anchor5g)
   - [統計情報のクリア](#anchor5h)
   - [ブロック時の log](#anchor5i)
   - [MIB 値](#anchor5j)
6. Loop Protect
   - [ループ検知動作](#anchor6a)
   - [ループ検知モード設定](#anchor6b)
   - [ポート単位のループ検知設定](#anchor6c)
   - [ループ検知パケット ( PDU ) 送信間隔設定](#anchor6d)
   - [ポートシャットダウン間隔設定](#anchor6e)
   - [ループ検知時の Trap 送信設定](#anchor6f)
   - [設定例](#anchor6h)
   - [検出情報の表示](#anchor6i)
   - [ループ検知時に表示されるログの表示例](#anchor6j)
7. Fault Finder ( ブロードキャストストーム )
   - [ブロードキャストストーム検知の有効化とアクション設定](#anchor7a)
   - [検知感度設定](#anchor7b)
   - [設定例](#anchor7c)
   - [ポート障害検出の情報表示](#anchor7d)
   - [設定と検知状況の表示](#anchor7e)
   - [ブロードキャストストーム検知時のログの表示例](#anchor7f)
8. RADIUS 認証
   - [ルール](#anchor8a)
   - [サーバー設定](#anchor8b)
   - [トラッキング](#anchor8c)
   - [サーバーデッドタイム](#anchor8d)
   - [サーバーグループ](#anchor8e)
   - [トラッキング専用ユーザー作成](#anchor8f)
   - [トラッキング対象設定](#anchor8g)
   - [トラッキングパケット数](#anchor8h)
9. MAC authentication
   - [認証メカニズム](#anchor9a)
   - [ルール](#anchor9b)
   - [再認証強制コマンド](#anchor9c)
   - [認証事前準備](#anchor9d)
   - [設定項目](#anchor9e)
   - [認証有効化](#anchor9f)
   - [認証の最大数](#anchor9g)
   - [MAC 認証済み制御下ポート間の MAC アドレス移動](#anchor9h)
   - [割り当て VLAN](#anchor9i)
   - [ログオフ時間](#anchor9j)
   - [認証の試行回数](#anchor9k)
   - [認証の待機時間](#anchor9l)
   - [再認証期間](#anchor9m)
   - [サーバー応答の待機期間](#anchor9n)
   - [認証前 VLAN](#anchor9o)
   - [RADIUS サーバーグループ](#anchor9p)
   - [Wake-on-LAN](#anchor9q)
   - [認証と非認証](#anchor9r)
10. Critical Authentication
    - [ルール](#anchor10a)
    - [代替 VLAN の割り当て](#anchor10b)
    - [設定削除](#anchor10c)
    - [ユーザーロールの割り当て](#anchor10d)
    - [クライアント状態確認](#anchor10e)
    - [認証状況](#anchor10f)
11. sFlow
    - [注意事項](#anchor11a)
    - [Destination 設定](#anchor11b)
    - [Sampling 設定](#anchor11c)
    - [Polling 設定](#anchor11d)
    - [スイッチエージェント情報を表示](#anchor11e)
    - [sFlow サンプリングポーリングデータの送信先の管理ステーションに関する情報を表示](#anchor11f)
    - [スイッチでの sFlow のサンプリングとポーリングに関する情報を表示](#anchor11g)

## 1. 基本設定

<a id="anchor1a"></a>

### ホスト名

 ```:設定コマンド
 sysname < username >
 ```

<a id="anchor1b"></a>

### ユーザー & パスワード
 - 管理者

 ```:設定コマンド
 password manager user-name < username > plaintext < password >
 ```
 - 一般

 ```:設定コマンド
 password operator user-name < username > plaintext < password >
 ```

<a id="anchor1c"></a>

### セッションタイムアウト
 - デフォルトは **0** ( 自動ログアウトしない ) です。
 - SSH / Telnet

 ```:設定コマンド
 console idle-timeout < 0-7200 >
 ```
 - USB console

 ```:設定コマンド
 console idle-timeout serial-usb < 0-7200 >
 ```

<a id="anchor1d"></a>

### タイムゾーン
 - **540 = Japan** です。

 ```:設定コマンド
 time timezone < -720-840 >
 ```

<a id="anchor1e"></a>

### NTP

 ```:設定コマンド
 timesync ntp
 ntp unicast
 ntp server < NTP Server IP Address >
 ntp enable
 ```

<a id="anchor1f"></a>

### L3 機能有効化

 ```:設定コマンド
 ip routing
 ```

<a id="anchor1g"></a>

### デフォルトゲートウェイ

 ```:設定コマンド
 ip default-gateway < Destination IP Address >
 ```

<a id="anchor1h"></a>

### ダイレクトブロードキャスト

 ```:設定コマンド
 ip directed-broadcast
 ```

<a id="anchor1i"></a>

### SNMP
 - **snmpv3 engineid** がデフォルトで設定されます。<br>**response-source** を設定しない場合は、デフォルトルートの IP で返します。<br>**restricted ( only read )** がデフォルトです。

 ```:設定コマンド
 snmp-server community "< community name >"
 snmp-server response-source < Source IP Address >
 ```

<a id="anchor1j"></a>

### DHCP Relay
 - **(vlan-10)#** など、該当のインターフェースモードで実行します。<br>複数設定で上から順に処理するといった冗長化が可能です。

 ```:設定コマンド
 ip helper-address < DHCP Server1 Address >
 ip helper-address < DHCP Server2 Address >
 ```

<a id="anchor1k"></a>

### Syslog
 - Syslog サーバの設定

 ```:設定コマンド
 logging < Server IP Address >
 ```
 - 送信するイベント重大度の設定

 ```:設定コマンド
 logging severity < major | error | warning | info | debug >
 ```

<a id="anchor1l"></a>

### Proxy
 - Aruba Central 接続時に使用します。

 ```:設定コマンド
 proxy server http://< Domain name | IP Address >:< Port number >
 ```

## 2. ACL ( access-list )
 - VLAN ACL ( VACL )<br>VACL は VLAN にアサインしてスイッチに入出力されるトラフィックに対してフィルタリングを行います。<br>フィルタリングの対象は、**VLAN に入ってくるトラフィックとなります。**
 - Routed ACL ( RACL )<br>RACL は VLAN にアサインしてスイッチに入出力されるトラフィックのうち、ルーティングされるトラフィックに対してフィルタリングを行います。

<a id="anchor2a"></a>

### ルール
1. １つの ACL を複数のインターフェースへ適用することができます。
2. **192.168.1.0/24** と **192.168.1.0 0.0.0.255** は同じです。どちらも適用できます。
3. **host ( 0.0.0.0 )** , **any ( 255.255.255.255 )** を使用できます。
4. **暗黙の DENY は存在します。**
5. １つのリスト内に、**同じ設定の permit と deny が存在した場合、若番の設定が優先**され、老番は削除されます。
6. Cisco のような、**コンフィグ適用時に自動で番号の再設定をする**などは行われません。

<a id="anchor2b"></a>

### Extended ACL 作成

 ```:書式
 < deny | permit > < ip | ip-protocol | number > < Source IP > < eq Port > < destination IP > < eq Port >
 ```
 - **ip** ： 全てのIPパケット
 - **ip-protocol** ：ip-in-ip , ipv6-in-ip , gre , esp , ah , ospf , pim , vrrp , allias-src , icmp , igmp , sctp , tcp , udp
 - **number** ：プロトコル番号で指定

#### 192.168.1.0/24 から 192.168.2.0/24 へ SSH 許可 , ICMP / TELNET 拒否 の場合

 ```:設定例
 ip access-list extended "< ACL name >"
      10 deny icmp 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255
      20 deny tcp 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255 eq 23
      30 permit tcp 192.168.1.0 0.0.0.255 192.168.2.0 0.0.0.255 eq 22
 ```

<a id="anchor2c"></a>

### 物理インターフェースへ適用
 - ACL を物理ポートへ適用した場合、**トラフィック制御の対象となるのは物理ポートで送受信されるパケット**となります。

 ```:書式
 interface < port number > ip access-group < ACL name > < in | out >
 ```
 - **in** : ポートで受信されるトラフィックに適用
 - **out** : ポートで送信されるトラフィックに適用

<a id="anchor2d"></a>

### VLAN インターフェースへ適用

 ```:書式
 vlan < vid > ip access-group < ACL name > < in | out | vlan-in | vlan-out >
 ```
 - **in** : VLAN で受信されるルーティングトラフィックに適用 ( RACL , 同一 VLAN 内の通信には適用されない )
 - **out** ：VLAN で送信されるルーティングトラフィックに適用 ( RACL , 同一 VLAN 内の通信には適用されない )
 - **vlan-in** : VLAN で受信されるトラフィックに適用 ( VACL )
 - **vlan-out** : VLAN で送信されるトラフィックに適用 ( VACL )

<a id="anchor2e"></a>

### ACL シーケンス番号の再振り
 - すべて一律に **increment number** で指定した値ごと再付与されます。

 ```:コマンド
 ip access-list resequence < ACL name > < start number > < increment number >
 ```

<a id="anchor2f"></a>

### Extended ACL の確認

 ```:コマンド
 show access-list < ACL name | 100-199 >
 ```

<a id="anchor2g"></a>

### ACL リソースの確認

 ```:コマンド
 show access-list resource
 ```

<a id="anchor2h"></a>

### ACL の統計 ( 許可 , 拒否 )

 ```:コマンド
 show statistics aclv4 < ACL name > vlan < vid > < in | out | vlan-in | vlan-out >
 ```

## 3. ポリシールーティング

<a id="anchor3a"></a>

### ポリシーの作成
 - **192.168.1.0/24** から **10.0.0.0/8** 以外の通信はポリシールーティングをする場合

 ```:設定例
 class ipv4 "< policy name >"
      10 ignore ip 192.168.1.0 0.0.0.255 10.0.0.0 0.255.255.255
      20 match ip 192.168.1.0 0.0.0.255 0.0.0.0 255.255.255.255
    exit
 ```

<a id="anchor3b"></a>

### ポリシーの適用
 - 該当セグメントにポリシーを設定します。<br>**(vlan-10)#** など、該当のインターフェースモードで実行します。

 ```:設定コマンド
 service-policy "< policy name >" in
 ```

<a id="anchor3c"></a>

### ポリシールーティングの統計表示

 ```:コマンド
 show statistics policy < policy name > vlan < vid > in
 ```

## 4. ミラーポート
 - リンクアグリケーションポートには設定できません。
 - コピー元ポートは複数設定できます。

<a id="anchor4a"></a>

### ミラーセッションの作成
 - **SESSION** は **1 – 4** の範囲から指定します。
 - **Destination Port number** は**コピー先のポート**を指定します。

 ```:設定コマンド
 mirror < SESSION > port < Destination Port number >
 ```

<a id="anchor4b"></a>

### ポートモニタ設定
 - **< in | out | both >** のいずれかを指定することで、コピーするトラフィックを指定できます。

 ```:設定コマンド
 interface < number > monitor all < in | out | both > mirror < SESSION >
 ```

#### interface 1 - 4 の送受信トラフィックを interface 10 にコピーする場合

 ```:設定例
 mirror 1 port 10
 interface 1-4 monitor all both mirror 1
 ```

<a id="anchor4c"></a>

### ミラー確認

 ```:コマンド
 show monitor
 ```

## 5. Link-keepalive ( UDLD )
 - デフォルトで Link-keepalive は無効です。
 - Link-keepalive を有効化した場合は、対向ポートについても Link-keepalive を有効化する必要があります。( 他ベンダーは不可能 )
 - リンクアグリゲーションで Link-keepalive を設定する場合は、グループ内の個別のポートに対して Link-keepalive 有効化の設定をします。

<a id="anchor5a"></a>

### 動作メカニズム
1. キープアライブ間隔内にもう一方の端にあるポートからヘルスチェックパケットを受信しない場合、ポートはさらに設定間隔待機します。
2. ポートがヘルスチェックパケットを受信しない場合、ポートはリンクに障害が発生したと判断し対応ポートをブロックします。

<a id="anchor5b"></a>


### UDLD 有効化

 ```:設定コマンド
 interface < port-list > link-keepalive
 ```

<a id="anchor5c"></a>

### コントロールパケット送信間隔設定
 - デフォルト値は 50 ( 5秒 ) で **10 – 100** の範囲で指定します。

 ```:設定コマンド
 link-keepalive interval < 10 - 100 >
 ```

<a id="anchor5d"></a>

### 最大リトライ数設定
 - デフォルト値は 5 で **3 – 10** の範囲で指定します。

 ```:設定コマンド
 link-keepalive retries < 3 - 5 >
 ```

<a id="anchor5e"></a>

### コントロールパケット送信の tag 指定

- **(eth-1)#** など、該当のインターフェースモードで実行します。

 ```:設定コマンド
 link-keepalive vlan < vid >
 ```

<a id="anchor5f"></a>

### UDLD 有効ポートのサマリ情報を表示

 ```:コマンド
 show link-keepalive
 ```

<a id="anchor5g"></a>

### UDLD 有効ポートの統計情報を表示

 ```:コマンド
 show link-keepalive statistics
 ```

<a id="anchor5h"></a>

### 統計情報のクリア

 ```:コマンド
 clear link-keepalive statistics
 ```

<a id="anchor5i"></a>

### ブロック時の log

 ```:表示例
 W 00834 udld: Link state on port '1' is changed to failure after maximum retries.
 I 00435 ports: port 1 is Blocked by UDLD
 ```

<a id="anchor5j"></a>

### MIB 値
 - 論理的なインタフェースの状態 ifAdminStatus ( 1:up 2:down )<br>**1.3.6.1.2.1.2.2.1.7.(ifIndex)**
 - 物理的なインタフェースの状態 ifOperStatus ( 1:up 2:down )<br>**1.3.6.1.2.1.2.2.1.8.(ifIndex)**

## 6. Loop Protect
 - 送信元 MAC アドレスを書き換える機能を持つ機器では有効に動作しません。
 - Loop Protect の設定はポート単位または VLAN 単位で設定ができます。<br>ポートと VLAN の両方に設定することはできません。

<a id="anchor6a"></a>

### ループ検知動作
1. 有効ポートはループ保護プロトコルデータユニット ( PDU ) をマルチキャスト宛先アドレス「09:00:09:09:13:A6」に送信します。
2.  ポート が PDU を受信すると、送信元 MAC アドレスと自身の MAC アドレスを比較します。
3.  MAC アドレスが一致すると、ループが検出され、設定された処理が実行されます。

<a id="anchor6b"></a>

### ループ検知モード設定
 - ポート単位にループ検知を行うモードがデフォルトです。

 ```:設定コマンド
 loop-protect mode < port | vlan >
 ```

<a id="anchor6c"></a>

### ポート単位のループ検知設定
 - **send-disable** : ループ検知時にループ検知パケットを送信したポートをシャットダウンします。( デフォルト )
 - **no-disable** : ループを検知してもポートをシャットダウンしません。
 - **send-recv-dis** : ループ検知時にループ検知パケットを送信したポート、受信したポートの両方をシャットダウンします。

 ```:設定コマンド
 loop-protect < Port-List > [ receiver-action < send-disable | no-disable | send-recv-dis > ]
 ```

<a id="anchor6d"></a>

### ループ検知パケット ( PDU ) 送信間隔設定
 - デフォルトは **5 秒** です。

 ```:設定コマンド
 loop-protect transmit-interval < 1-10 >
 ```

<a id="anchor6e"></a>

### ポートシャットダウン間隔設定
 - デフォルトは **0 秒** になっており、ループ検知でシャットダウンされたポートは自動復旧しません。

 ```
 loop-protect disable-timer < 0-604800 >
 ```

<a id="anchor6f"></a>

### ループ検知時の Trap 送信設定

 ```:設定コマンド
 loop-protect trap loop-detected
 ```

<a id="anchor6g"></a>

### 設定例
 - ポート 1～10 で Loop-Protect を有効<br>ループ検出時ポートをシャットダウンし、60 秒後に自動復旧<br>3 秒毎にループパケットを送信<br>ループ検知時には SNMP Trap 送信

 ```
 loop-protect 1-10
 loop-protect disable-timer 60 transmit-interval 3
 loop-protect trap loop-detected
 ```

<a id="anchor6h"></a>

### 検出情報の表示

 ```:コマンド
 show loop-protect < Port-List | vlan list >
 ```

<a id="anchor6i"></a>

### ループ検知時に表示されるログの表示例

 ```:表示例
 Aruba# show logging
  Keys: W=Warning I=Information
  M=Major D=Debug E=Error
   ---- Event Log listing: Events Since Boot ----
   I 05/31/17 10:51:24 00076 ports: port 1 is now on-line
   I 05/31/17 10:51:24 00076 ports: port 2 is now on-line
   W 05/31/17 10:51:25 00884 loop-protect: port 1 disabled - loop detected.
   I 05/31/17 10:51:25 00898 ports: Loop Protect(62) has disabled port 1 for 60 seconds
 ```

## 7. Fault Finder ( ブロードキャストストーム )

<a id="anchor7a"></a>

### ブロードキャストストーム検知の有効化とアクション設定
 - action パラメータ<br>**warm** : イベント通知のみ<br>**warm-and-disable** : イベント通知とポートのシャットダウン<br>**Seconds** : ポートをシャットダウンする時間を指定 ( 0 - 604800 秒 ) **0** にすると自動解除はしません。

 ```:設定コマンド
 fault-finder broadcast-storm < Port-List > action [ warn | warn-and-disable ] < Seconds > [ pps Number | percent Number ]
 ```

<a id="anchor7b"></a>

### 検知感度設定
 - sensitivity パラメータ<br>low** : 低感度<br>medium** : 中感度 ( デフォルト )<br>high** : 高感度

 ```:設定コマンド
 fault-finder broadcast-storm sensitivity < low | medium | high >
 ```

<a id="anchor7c"></a>

### 設定例
 - 高感度でポート 1 〜 10 でブロードキャストストームが 60% を超えたらイベント通知と 600 秒間ポートをシャットダウンする場合

 ```:設定例
 fault-finder broadcast-storm 1-10 action warm-and-disable 600 percent 80
 fault-finder broadcast-storm sensitivity high
 ```

<a id="anchor7d"></a>

### ポート障害検出の情報表示

 ```:コマンド
 show fault-finder
 ```

<a id="anchor7e"></a>

### 設定と検知状況の表示

 ```：komanndo
 show fault-finder broadcast-storm
 ```

<a id="anchor7f"></a>

### ブロードキャストストーム検知時のログの表示例

 ```:表示例
 Aruba# show logging
  Keys: W=Warning I=Information
  M=Major D=Debug E=Error
   ---- Event Log listing: Events Since Boot ----
    W 12/25/17 16:09:28 02676 FFI: port 1-Excessive Broadcasts. Broadcast-storm control threshold 5 percent exceeded.
    M 12/25/17 16:09:28 02673 FFI: port 1-Port disabled by Fault-finder.
 ```

## 8. RADIUS 認証
 - クライアントデバイスの MAC アドレスをユーザー名とパスワードの両方として構成します。
 - MAC アドレスの形式は、RADIUS サーバーが使用するのと同じ形式で設定します。
 - クライアントがスイッチ等の場合は、デバイスに割り当てられたベース MAC アドレスを使用します。<br>また、スイッチ は設定されたすべての VLAN に単一の MAC アドレスを適用します。

<a id="anchor8a"></a>

### ルール
1. 最大１５台の RADIUS サーバーを使用した認証とアカウンティングが可能です。
2. **show radius コマンド** でリストされている順序でサーバーにアクセスします。
3. 最初のサーバーが応答しない場合、スイッチは次のサーバーを試行します。
4. EAP RADIUS は **MD5** と **TLS** を使用して RADIUS サーバーからのチャレンジへの応答を暗号化します。
5. 認証要求用の UDP 宛先ポートはデフォルト値 **1812** です。
6. アカウンティング要求用の UDP 宛先ポートはデフォルト値 **1813** です。

<a id="anchor8b"></a>

### サーバー設定
 - 最大３つの RADIUS サーバーアドレスを構成できます。

 ```:設定コマンド
 radius-server host < 宛先 IP アドレス > key < RADIUS 共通パスワード >
 ```

<a id="anchor8c"></a>

### トラッキング
 - RADIUS サーバーの死活監視を行います。デフォルトで無効です。

 ```:設定コマンド
 radius-server tracking [ enable | disable ]
 ```
 - 死活監視の間隔を秒単位で設定します。

 ```:設定コマンド
 radius-server tracking interval < 60 ~ 86400 >
 ```

<a id="anchor8d"></a>

### サーバーデッドタイム
 - サーバーデッドタイムとは障害発生したサーバーに認証要求を送らない時間です。分単位で設定します。<br>トラッキングが有効な場合は、デッドタイム値を設定できません。

 ```:設定コマンド
 radius-server dead-time [ infinite | 1 ~ 1440 ]
 ```

<a id="anchor8e"></a>

### サーバーグループ
 - RADIUS サーバーをサーバーグループに関連付けます。

 ```:設定コマンド
 aaa server-group radius < グループ名 > host < RADIUS サーバー IP アドレス >
 ```

<a id="anchor8f"></a>

### トラッキング専用ユーザー作成
 - RADIUS サーバーの可用性を追跡するために使用されるダミーのユーザー名を構成します。<br>デフォルトでは、**radius-tracking-user** です。<br>パスワードは設定を省略できます。

 ```:コマンド
 radius-server tracking user-name < ユーザー名 > [ password < パスワード > ]
 ```

<a id="anchor8g"></a>

### トラッキング対象設定
 - デフォルトでは、設定されているすべての RADIUS サーバに対してトラッキングが実行されます。<br>以下の設定により、機能していない ( デッド ) サーバーのみが追跡されます。

 ```:設定コマンド
 radius-server tracking dead-servers-only
 ```

<a id="anchor8h"></a>

### トラッキングパケット数
 - デフォルト値は **3** です。許可される値は **1 ~ 5** です。

 ```:設定コマンド
 radius-server tracking request-packet-count < 1 - 5 >
 ```

## 9. MAC authentication

<a id="anchor9a"></a>

### 認証メカニズム
1. デバイスが直接リンクまたはネットワークを介してスイッチに接続すると、スイッチは認証のためにデバイスの MAC アドレスを RADIUS サーバーに転送します。
2. RADIUS サーバーは、デバイスの MAC アドレスをユーザー名とパスワードとして使用し、ネットワークアクセスを許可または拒否します。<br>このプロセスでは、クライアントデバイス構成もログオンセッションも使用しません。
3. スイッチは、認証のために認証資格情報としてクライアントの MAC アドレス（ addr-format で指定された形式 ）を RADIUS サーバーにすぐに送信します。
4. クライアントが認証され、ポートはネットワークアクセス用の静的なタグなし VLAN に割り当てられます。<br>割り当てられたポート VLAN は、セッションが終了するまでそのまま残ります。
5. クライアントは、一定期間後 ( **reauth-period** ) またはセッション中の任意の時点 **reauthenticate** に再認証を強制される場合があります。
6. 一定時間 ( **logoff-period** ) 経過してもクライアントからのアクティビティがない場合は、暗黙のログオフ期間を設定できます。
7. また、ポートのリンクが失われるとセッションが終了し、すべてのクライアントの再認証が必要になります。
8. そして、クライアントが１つのポートから別のポートに移動し、クライアントの移動がポートで有効になっていない場合 ( **addr-moves** ) に、セッションは終了し、クライアントはネットワークアクセスのために再認証する必要があります。
9. セッションが終了すると、ポートは事前認証状態に戻ります。
10. 認証されたポートである間に行われたポートの VLAN メンバーシップへの変更は、セッションの終了時に有効になります。

<a id="anchor9b"></a>

### ルール
 - クライアント制限は、MAC 認証と Web 認証のポートあたり **２５６ クライアント**です。
 - MAC 認証および Web 認証の制限は、スイッチ全体に **１６,３８４ 未満 の認証クライアントがある場合**にのみ適用されます。
 - クライアントの制限に達した後は、どの方法でもどのポートでも追加の認証クライアントは許可されません。
 - ポートで認証方法のいずれかを構成する場合は、ポートで LACP を無効にする必要があります。
 - デフォルトの構成では、スイッチは RADIUS サーバーが認証しないすべてのクライアントへのアクセスをブロックします。

<a id="anchor9c"></a>

### 再認証強制コマンド
 - ただし、認証そのものをリセットするだけで、再認証のシーケンス自体は発生しません。( 差認証には端末側でのアクションが必要 )

 ```:コマンド
 aaa port-access mac-based < 再認証するポート番号 > reauthenticate [ mac-address < 該当クライアントのMAC > ]
 ```
<a id="anchor9d"></a>

### 認証事前準備
1. スイッチでローカルユーザー名とパスワードを設定します。
2. MAC 認証で複数の VLAN を使用する場合は、VLAN がスイッチで構成されていること、および適切なポート割り当てが行われていることを確認してください。
3. RADIUS サーバーとスイッチが通信できることを確認します。
4. RADIUS サーバーにアクセスするための正しい IP アドレスと暗号化キーを使用してスイッチを構成します。
5. 使用するポートを使用してMAC認証用にスイッチを構成します。

<a id="anchor9e"></a>

### 設定項目 ( 必須ではありません )
 -
 - **server-timeout** ：タイムアウトする前にスイッチが RADIUS サーバからの応答の受信を待機する時間を設定します。
 - **maxrequests** ：認証が失敗する前に RADIUS サーバーがタイムアウトになる可能性のある認証の試行回数を指定します。
 - **quiet-period** ：クライアントからの新しい認証要求を処理する前に、指定された時間待機します。
 - **unauth-vid** ：認証されていないクライアントを特定の静的なタグなし VLAN に割り当てて、特定のアクセスを提供できます。

<a id="anchor9f"></a>

### 認証有効化
 - 指定されたポートで MAC 認証を有効にします。指定されたポートで MAC 認証を無効にするには、コマンドの **no** を使用します。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 >
 ```

<a id="anchor9g"></a>

### 認証の最大数
 - ポートで許可する認証済み MAC の最大数を指定します。<br>デフォルト値は **1** です。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > addr-limit < 1 ~ 256 >
 ```

<a id="anchor9h"></a>

### MAC 認証済み制御下ポート間の MAC アドレス移動
 - 有効にすると、スイッチは再認証を必要とせずにアドレスを移動できます。<br>デフォルトは、無効です。移動が発生すると、ユーザーは再認証を強制されます。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > addr-moves
 ```

<a id="anchor9i"></a>

### 割り当て VLAN
 - 許可されたクライアントに使用する VLAN を指定します。RADIUS サーバーはこの値を上書きできます。
 - auth-vid が **0** の場合、RADIUS サーバーが値を提供しない限り VLAN の変更は発生しません。デフォルト値は、**0** です。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > auth-vid < アサインする VLAN >
 ```

<a id="anchor9j"></a>

### ログオフ時間
 - スイッチが暗黙的なログオフに対して強制する期間を秒単位で指定します。デフォルト値は、**300** です。<br>このパラメータは、従来のスイッチの意味での MAC エージング間隔と同等です。<br>スイッチがアクティビティを認識しない場合、クライアントは事前認証状態に戻ります。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > logoff-period < 60 ~ 9999999 >
 ```

<a id="anchor9k"></a>

### 認証の試行回数
 - 認証が失敗する前にタイムアウトする必要がある認証の試行回数を指定します。デフォルト値は、**2** です。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > max-requests < 1 ~ 10 >
 ```

<a id="anchor9l"></a>

### 認証の待機時間
 - 認証に失敗した MAC アドレスからの認証要求を処理する前にスイッチが待機する期間 ( 秒単位 ) を指定します。デフォルト値は、**60** です。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > [quiet-period <1-65535>]
 ```

<a id="anchor9m"></a>

### 再認証期間
 - スイッチがクライアントに再認証を強制する期間 ( 秒単位 ) を指定します。 再認証が行われている間、クライアントは認証されたままです。<br>**0** に設定すると、再認証は無効になります。デフォルト値は、**300** です。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > reauth-period < 0 ~ 9999999 >
 ```

<a id="anchor9n"></a>

### サーバー応答の待機期間
 - スイッチが認証要求に対するサーバーの応答を待機する期間を秒単位で指定します。デフォルト値は、**300** です<br>設定された時間枠内に応答がない場合、スイッチは認証の試行がタイムアウトしたと見なします。<br>現在の max-requests 値に応じて、スイッチは新しい要求を送信するか、認証セッションを終了します。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > server-timeout < 1 ~ 300 >
 ```

<a id="anchor9o"></a>

### 認証前 VLAN
 - 認証されていないクライアントの VLAN にポートを移動する前にスイッチが待機する時間を設定します。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > unauth-period < 0 ~ 255 >
 ```

<a id="anchor9p"></a>

### RADIUS サーバーグループ
 - MAC 認証を行こうにするポートごとに RADIUS サーバーグループを構成します。

 ```:設定コマンド
 aaa port-access mac-based < 有効にするポート番号 > server-group < RADIUS サーバーグループ名 >
 ```

<a id="anchor9q"></a>

### Wake-on-LAN
 - 設定の制御された方向により、Wake-on-LAN トラフィックが認証されていないポートを介してスイッチを通過できるようになります。<br>ただし、Wake-on-LAN パケットが宛先に到着することは保証されません。

 ```:設定コマンド
 aaa port-access < 有効にするポート番号 > controlled-direction < both | in >
 ```
 - **both** ：デフォルト 認証が行われる前に、着信フレームの受信と発信フレームの送信の両方を無効にする指定をします。
 - **in** ：認証が行われる前に、着信フレームの受信のみを無効にする指定をします。<br>宛先アドレスが不明な発信トラフィックは、認証されていないポートでフラッディングされます。

<a id="anchor9r"></a>

### 認証と非認証
 - 認証されていないユーザーと認証されたユーザーが同じポートで許可されるかどうかを設定します。

 ```:設定コマンド
 aaa port-access < 有効にするポート番号 > mixed
 ```

## 10. Critical Authentication
 - タグ無しトラフィックを送信するクライアントが、リモート認証サーバーに到達できない場合に代替 VLAN を割り当てる設定です。<br>認証不可によってブロックされなくなります。

<a id="anchor10a"></a>

### ルール
1. ポートごとに 1 つの Critical VLAN のみ設定できます。
2. この機能はポートごとに構成可能であり、RADIUS ベースの認証メカニズムにのみ適用されます。
3. Web ベースの認証は、Web 対応のクライアントに適用できます。
4. 電話または電話の後ろの PC に接続されているポートで Web ベースの認証が有効になっている場合、スイッチはすべてのデバイスに対してWebベースの認証を開始します。
5. RADIUS が復旧した際に再認証させる場合は、**radius-server tracking** を設定する必要があります。

<a id="anchor10b"></a>

### 代替 VLAN の割り当て
 - **< port >** ：Critical VLAN を設定するポート
 - **< vid >** ：Critical VLAN とする VLAN

 ```:設定コマンド
 aaa port-access < port > critical-auth data-vlan < vid >
 ```

<a id="anchor10c"></a>

### 設定削除

 ```:削除コマンド
 no aaa port-access < port > critical-auth data-vlan < vid >
 ```

<a id="anchor10d"></a>

### ユーザーロールの割り当て

 ```:設定コマンド
 aaa port-access < port > critical-auth user-role < ROLE-NAME >
 ```

<a id="anchor10e"></a>

### クライアント状態確認

 ```:コマンド
 show port-access clients
 ```

 ```:表示例
 switch# show port-access clients
 Port Access Client Status
 Port Client Name MAC Address IP Address User Role Type VLAN
 ----- ------------- -------------- ---------- ---------- ----- ----
 A1 xxxxxxxxxxxx xxxxxx-xxxxxx n/a critical_role MAC
 A2 yyyyyyyyyyyy yyyyyy-yyyyyy n/a open-auth_role MAC
 ```

<a id="anchor10f"></a>

### 認証状況

 ```:コマンド
 show port-access mac-based clients
 show port-access authenticator clients
 ```

 ```:表示例
 switch# show port-access authenticator clients
 Port Access Authenticator Client Status
 Port Client Name MAC Address IP Address Session Status
 ----- ------------- -------------- --------- -------------
 A1 xxxxxxxxxxxx xxxxxx-xxxxxx n/a critical
 A2 yyyyyyyyyyyy yyyyyy-yyyyyy n/a open-auth

 switch# show port-access mac-based clients
 Port Access MAC-Based Client Status
 Port Client Name MAC Address IP Address Session Status
 ----- ------------- ------------- ---------- --------------
 A1 xxxxxxxxxxxx xxxxxx-xxxxxx n/a critical-auth
 A2 yyyyyyyyyyyy yyyyyy-yyyyyy n/a open-auth
 ```

 ```
 (config)# show logging
 Keys:   W=Warning   I=Information
         M=Major     D=Debug E=Error
 ----  Event Log listing: Events Since Boot  ----
 I 07/14/21 15:40:59 00421 radius: Can't reach RADIUS server 192.168.1.1
 I 07/14/21 15:41:19 00421 radius: Can't reach RADIUS server 192.168.1.2
 I 07/14/21 15:41:34 05705 auth: Critical auth data VLAN 10 is configured on port 9.
 ```

## 11. sFlow
 - [Management and Configuration Guide](https://support.hpe.com/hpesc/public/docDisplay?docLocale=en_US&docId=a00091307en_us)<br>P.204 CLI-configured sFlow with multiple instances を参照ください。

<a id="anchor11a"></a>

### 注意事項
 - 特定のレシーバーインスタンスに結合されたサンプリングインスタンスとポーリングインスタンスは動的に割り当てられるため、<br>インスタンス番号が常に一致するとは限りません。
 -  注意すべき重要な点は、以下の２つです。
1. **ポートでサンプリングまたはポーリングが有効**になっているかこと。
2. **各ポートで構成されているレシーバーインスタンスのサンプリングレートまたはポーリング間隔。**
 - **receiver-instance** は **1 ~ 3** の範囲で設定します。
 - デフォルトは、udp 宛先ポート番号 **6343** です。

<a id="anchor11b"></a>

### Destination 設定

 ```:書式
 [ no ] sflow < receiver-instance > destination < ip-address > [< udp-port-num >]
 ```
 - sFlow レシーバー / 宛先 を無効にする場合

 ```:設定コマンド
 no sflow receiver-instance
 ```

<a id="anchor11c"></a>

### Sampling 設定

 ```:書式
 sflow < receiver-instance > sampling < port-list > < sampling rate >
 ```

<a id="anchor11d"></a>

### Polling 設定

 ```:書式
 sflow < receiver-instance > polling < port-list > < polling interval >
 ```

<a id="anchor11e"></a>

### スイッチエージェント情報を表示
 - バージョン情報には、sFlow バージョン、MIB サポート、およびソフトウェアバージョンが表示されます。
 - エージェントアドレスは、通常スイッチに設定されている最初の VLAN の IP アドレスです。

```:コマンド
show sflow agent
```

 ```:表示例
 (config)# show sflow agent

 SFlow Agent Information

 Version             : 1.3;Aruba;WC.16.10.0012
 Agent Address       : 192.168.1.1
 Source IP Selection : Outgoing Interface
 ```

<a id="anchor11f"></a>

### sFlow サンプリングポーリングデータの送信先の管理ステーションに関する情報を表示
 - 管理ステーションの宛先アドレス、レシーバーポート、および所有者に関する情報が含まれます。
 - **Destination Address** ：構成されていない限り空白のままです。
 - **Datagrams Sent** ：スイッチエージェントが最後に有効にされてから、管理ステーションに送信されたデータグラムの数を示します。
 - **Timeout** ：スイッチエージェントが自動的に Flow を無効にするまでの残り秒数を表示します。
 - **Max Datagram Size** ：現在設定されている値を示します。( 通常はデフォルト値です )

 ```:コマンド
 show sflow x destination
 ```

 ```:表示例
 (config)# show sflow 1 destination

 SFlow Destination Information

 Destination Instance      : 1
 sflow                     : Enabled
 Datagrams Sent            : 0
 Destination Address       : 192.168.1.1
 Receiver Port             : 6343
 Owner                     : Administrator, CLI-Owned, Instance 1
 Timeout (seconds)         : 2147483454
 Max Datagram Size         : 1400
 Datagram Version Support  : 5
 OOBM Support              : Disabled
 ```

<a id="anchor11g"></a>

### スイッチでの sFlow のサンプリングとポーリングに関する情報を表示

 ```:設定コマンド
 show sflow < receiver instance > sampling-polling < port-list/range >
 ```

 ```:表示例
 (config)# show sflow 1 sampling-polling

 SFlow Sampling Information

         | Sampling                    Dropped | Polling
   Port  | Enabled      Rate Header    Samples | Enabled Interval
   ----- + -------  -------- ------ ---------- + ------- --------
   47      Yes(1)         50    128          0   Yes(1)        20
 ```
