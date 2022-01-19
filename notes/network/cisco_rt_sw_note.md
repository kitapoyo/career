# Cisco RT & SW Note
1. [Third Party SFP の使用](#anchor1)
2. [Catalyst 3850 Password Recovery](#anchor2)
3. UDLD メカニズム
   - [単一方向リンク とは](#anchor3a)
   - [UDLD の動作モード](#anchor3b)
   - [UDLD の動作メカニズム](#anchor3c)
   - [UDLD リセットオプション](#anchor3d)
   - [UDLD のモニタおよびメンテナンス](#anchor3e)
   - [デバックコマンド](#anchor3f)
4. EEM ( Embedded Event Manager ) 設定
   - [EEM の概要](#anchor4a)
   - [EEM のアーキテクチャ](#anchor4b)
   - [EEM 関連コマンド](#anchor4c)
   - [設定例１ ( Interface Down )](#anchor4d)
   - [設定例２ ( Mail Send )](#anchor4e)
5. [Catalyst の RADIUS サーバ両系ダウン時の通信許可](#anchor5)

<a id="anchor1"></a>

## 1. Third Party SFP の使用
 - Cisco では基本的に純正以外のモジュールの使用を認めていません。<br>対処法は **gbic-invalid error** を無効にします。

    ```:コマンド
    (config)# no errdisable detect cause gbic-invalid
    (config)# service unsupported-transceiver
    ```

<a id="anchor2"></a>

## 2. Catalyst 3850 Password Recovery
1. 機器を再起動し、１５秒以内に全てのシステム LED が点灯し、同じ色になるまで **「Mode」** ボタンを押し続けます。
2. フラッシュファイルシステムを初期化します。

    ```:コマンド
    Switch: flash_init
    ```

3. スタートアップコンフィグレーションを無視するようにします。

    ```:コマンド
    Switch: SWITCH_IGNORE_STARTUP_CFG=1
    ```

4. フラッシュメモリの **packages.conf** ファイルでスイッチを起動します。

    ```:コマンドプロンプトが表示されたら、特権EXECモードに入ります。
    Switch: boot flash:packages.conf
    ```

5. プロンプトが表示されたら、ログインできることを確認してください。ひとまず、これでログインできます。
6. スタートアップコンフィグレーションをランニングコンフィグレーションにコピーします。<br>ここでパスワードを変更して、保存します。

    ```:コマンド
    Switch# copy startup-config running-config
    #パスワード設定処理#
    Switch# copy running-config startup-config
    ```

7. マニュアルブートモードであることを確認します。

    ```:コマンド
    show boot
    ```

    ```:表示結果
    BOOT variable = flash:packages.conf;
    Manual Boot = yes
    Enable Break = yes
    ```

8. 機器を再起動し、２と３で変更したブートローダのパラメータを元の値に戻します。

    ```:コマンド
    Switch: SWITCH_DISABLE_PASSWORD_RECOVERY=1
    Switch: SWITCH_IGNORE_STARTUP_CFG=0
    ```

9. フラッシュメモリの **packages.conf** ファイルで起動し、マニュアルブートを無効化します。

    ```:コマンド
    Switch: boot flash:packages.conf
    Switch(config)# no boot manual
    ```

## 3. UDLD メカニズム
 - 単一方向リンクを検出することができる L2 プロトコルです。
 - UDLD を有効化している場合、**UDLD パケット ( Echo ) を受信できないと、該当ポートを err-disable** にします。
 - UDLD の設定は **相互接続するデバイスの両端で設定する** 必要があります。( 他ベンダー同士は非推奨 )
 - UDLD 対応ポートが別の device の UDLD 非対応ポートに接続されている場合、このポートは単一方向リンクを検出できません。

<a id="anchor3a"></a>

### 単一方向リンク とは
 - 一方の機器でトラフィックを送信できるが受信できない状態
 - もう一方の機器でトラフィックを受信できるが送信できない状態

<a id="anchor3b"></a>

### UDLD の動作モード

#### ノーマル
 - 単一方向リンクの検出時、該当ポートを **undetermined** にするだけでポートを **err-disabled** しない。
 - 片方向と判断するための条件は、**空の Echo TLV を持った UDLD PDU を対向機器から受信すること** です。

#### アグレッシブ
 - 単一方向リンクの検出時、再確立が試みられるも、失敗した場合、該当ポートは **err-disabled** になります。
 - 片方向と判断するための条件は、**Link Up フェイズに移行後、８回の Probe 送信が完了後も対向機器から UDLD PDU を受信できないこと** です。

<a id="anchor3c"></a>

### UDLD の動作メカニズム
 - UDLD は検出メカニズムとして **Echo** を使用します。
1. 有効化されたポート上で **Hello パケット ( Probe )** を隣接の UDLD 対応機器に定期的に送信します。<br>ネイバー同士でネイバーに関する情報を常に維持できるようにします。
2. スイッチが **Hello パケット** を受信するとエージングタイムが経過するまで情報をキャッシュします。<br>古いキャッシュのエージングタイムが切れる前に、新しい **Hello パケット** を受信して、正常を確認します。
3. UDLD が有エコー送信側は返信エコーを受信するよう待機します。
4. エコーメッセージを受信できなかった場合は、該当ポートは動作モードによって各状態へ移行します。<br>エコーを受信できれば **Bidirectional** と見なされて、**detection フェーズ** から **advertisement フェーズ** に移行します。

<a id="anchor3d"></a>

### UDLD リセットオプション
 - インターフェイスが UDLD で **err-disable** された場合、次のオプションの内１つを使用して UDLD をリセットできます。
1. ` udld reset ` ：インターフェイス コンフィギュレーション
2. ` shutdown ` > ` no shutdown ` ：インターフェイス コンフィギュレーション
3. ` no udld {aggressive | enable} ` > ` udld {aggressive | enable} ` ：グローバル コンフィギュレーション
4. ` no udld port ` > ` udld port [aggressive] ` ：インターフェイス コンフィギュレーション
5. ` errdisable recovery cause udld ` ：UDLD の ` err- disable ` ステートから自動回復するタイマーをイネーブルにします。<br>` errdisable recovery interval < interval > ` ：udld err-disable ステートから回復する時間を指定します。

<a id="anchor3e"></a>

### UDLD のモニタおよびメンテナンス
 - UDLD の状態、各種パラメータやタイマーを表示

    ```:コマンド
    show udld [Interface Name | neighbors]
    ```

 - **Interface Name** ：特定のインターフェイス上のUDLD 情報のみ表示する場合<br>**neighbors** ：出力を簡略化します。

    ```:s表示例
    Catalyst-A#show udld gigabitethernet0/11
    Interface Gi0/11
    ---
    Port enable administrative configuration setting: Enabled ①
    Port enable operational state: Enabled ②
    Current bidirectional state: Bidirectional ③
    Current operational state: Advertisement - Single neighbor detected ④
    Message interval: 15 ⑤
    Time out interval: 5 ⑥
    ```

1. Catalyst 全体の UDLD の設定状況 ( Enabled/Disabled )
2. ポートの UDLD の設定状況 ( Enabled/Disabled )
3. UDLD State ( Bidirectional/Unidirectiona/Undetermined )
4. Operational State ( Inactive/Link Up/Detection/Advertisement )
5. 自分に設定されている Message Interval
6. Timout Interval ( ５秒固定 )

#### Current bidirectional state
 - UDLD の稼動状況を意味するステートで３種類あります。
1. **Bi-directional**<br>対向機器との間で Bidirectional ( 双方向 ) となっている状態です。
2. **Unidirectional**<br>対向機器との間で Unidirectional ( 片方向 ) が検出された状態です。
3. **Undetermined**<br>対向機器から UDLD PDU を受け取っていないか、受け取った後 Bi-directional となるまでの一時的な状態です。

#### Current operational state
 - UDLD のステート・マシン内のフェイズで、４種類あります。
1. **Inactive**<br>UDLD が無効となっているか、ポートがダウンしている状態です。
2. **Link Up**<br>ポートがリンク・アップして、まだ一つも UDLD PDU を受信していない状態です。
3. **Detection**<br>対向機器から UDLD PDU を受信して、Bi-directional となるまでの状態です。
4. **Advertisement**<br>対向機器との間で Bi-directional ( 双方向 ) が確立した状態です。安定動作中はこのフェイズに留まります。

<a id="anchor3f"></a>

### デバックコマンド

 ```:コマンド
 debug udld events
 ```

 ```:コマンド
 debug udld packets
 ```

## 4. EEM ( Embedded Event Manager ) 設定

<a id="anchor4a"></a>

### EEM の概要
 - Cisco が扱っている各 OS ( IOS、IOS XR、IOS XE、NX-OS ) に搭載された運用管理機能です。
 - 事前にイベントとアクションを設定することで、イベントを検出すると設定しておいたアクションを実行してくれます。<br>あるインタフェースを監視して、インタフェースがダウンしたら、管理者へメールを送信する<br>CPU 使用率を監視して、事前に決めた閾値を超えた場合に syslog で送信する
 - EEM を動作させると、**機器の CPU やメモリを消費**します。

<a id="anchor4b"></a>

### EEM のアーキテクチャ
 - EEM は **Event Detector** , **Policy** , **EEM サーバ** の３つの要素から成り立っています。<br>事前に定義したイベントとアクションを **Policy** と呼びます。<br>**Event Detector** で **Policy** に則ってイベントを監視し、アクションを実行させる場合に **EEM サーバ** へ通知します。
 - EEM は CLI を使った設定と、Tcl スクリプトを使ってプログラミングする方法の２種類があります。

<a id="anchor4c"></a>

### EEM 関連コマンド
 - バージョンを表示

    ```:コマンド
    show event manager version
    ```

 - 利用できる Event Detector の種類とバージョンを表示

    ```:コマンド
    show event manager detector all
    ```

 - 設定したポリシーの動作情報を表示

    ```:コマンド
    show event manager policy registered
    ```

<a id="anchor4d"></a>

### 設定例１ ( Interface Down )
 - **1.1.1.2** へ **GigabitEthernet1/0/1** からの疎通が途切れた場合に、該当インターフェースを Down

    ```:設定例１
    track 100 ip sla 1 reachability
    !
    ip sla 1
    icmp-echo 1.1.1.2 source-interface GigabitEthernet1/0/1
    frequency 10
    ip sla schedule 1 life forever start-time now
    !
    event manager applet Interface Down
    event syslog pattern "100 ip sla 1 reachability Up -> Down"
    action 1.0 cli command "enable"
    action 2.0 cli command "configure terminal"
    action 3.0 cli command "interface GigabitEthernet1/0/1"
    action 4.0 cli command "shutdown"
    !
    ```

<a id="anchor4e"></a>

### 設定例２ ( Mail Send )
 - 該当のログが発生した場合に、メールサーバー **1.1.1.1** へメールを送信

    ```:設定例２
    event manager applet ERROR
    event syslog pattern "err-disable" maxrun 1000
    action 1.1 syslog msg "### err-disable detected ###"
    action 1.2 wait 600
    action 1.3 info type snmp getid
    action 1.4 mail server "1.1.1.1" to "user@test.com" from "Admin@example.com" subject "Alert Detect" body "Error"
    action 1.5 syslog msg "### Sending err-disable mail process was completed ###"
    !
    ```

<a id="anchor5"></a>

## 5. Catalyst の RADIUS サーバ両系ダウン時の通信許可
 - RADIUS 認証が出来ない際に、全てのユーザを指定した VLAN ( untag ) に接続させ、復旧次第再認証をすることは可能です。

### 非認証 VLAN アサインコマンド
 - Switch と Radius の間の疎通がとれなくなった場合に、緊急用の VLAN にポートをアサインしなおすことが可能なコマンドです。<br>マルチ認証ポートにおいてアクセス不能バイパス機能をサポートするためのコマンドになります。
 - 新しいホストがクリティカルポートに接続しようとした時に、接続されているすべてのホストがユーザ指定のアクセス VLAN に移動されます。<br>**authorize** 部分を **reinitialize** とすると既に認証されているホストも CriticalVLAN に移動されます。

    ```：コマンド
    authentication event server dead action authorize vlan < vlan-id >
    ```

### RADIUS サーバが全滅した際の挙動など詳細な説明や設定方法は以下を参照
 - [cisco document](https://www.cisco.com/c/en/us/td/docs/switches/lan/catalyst2960x/software/15-2_7_e/b_1527e_consolidated_2960x_cg/m_sec_8021x_cg.html#ID778)<br>「アクセスできない認証バイパスを使用した 802.1x 認証 」

### 補足
 - アクセス不能バイパス機能が有効になっていると、SW は Critical Port にクライアントが接続を試みるたびに RADIUS サーバの状態を確認します。<br>**Critical Por** は、アクセス不能バイパス機能が有効になっているポートのことです。
 - 上記設定において、トランク VLAN の指定は不可能であり、実際にトランク VLAN を設定した場合、RADIUS が正常に動いていても認証がうまくいきません。

### 設定
 - [IEEE 802.1x ポートベース認証の設定](https://www.cisco.com/c/ja_jp/td/docs/sw/campuslanswt-access/cat2960-xrswt/cg/004/b_sec_152ex1_2960-xr/b_sec_152ex1_2960-xr_chapter_01111.html)<br>「アクセス不能認証バイパス機能の設定」

    ```:設定例
    aaa authentication dot1x default group radius interface gigabitethernet 0/1
      authentication event server dead action authorize vlan 10
      authentication event server alive action reinitialize
    !
    dot1x critical [ recovery action reinitialize | vlan vlan-id ]
    ```
