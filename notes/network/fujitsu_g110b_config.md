# Fujitsu Si-R G110, Si-R G110B Config
1. [はじめに](#anchor1)
2. [管理者パスワード](#anchor2)
3. [ログインプロンプト](#anchor3)
4. [ログインタイムアウト](#anchor4)
5. [物理インターフェース VLAN アサイン](#anchor5)
   - Trunk ポート ( tag )
   - Access ポート ( untag )
6. [IP アドレスとデフォルトゲートウェイ](#anchor6)
7. [SNMP サーバー](#anchor7)
8. [NTP サーバー](#anchor8)
9. [プロキシ DNS](#anchor9)
10. [ホスト情報の登録](#anchor10)
11. [IPsec](#anchor11)
    - IPsec Path Through
12. [Ether IP Tunne](#anchor12)
    - 設定例
13. [PPPoE](#anchor13)
14. [NAT ( IP マスカレード )](#anchor14)
15. [BGP](#anchor15)
16. [再配送](#anchor16)
17. [シェーピング](#anchor17)

<a id="anchor1"></a>

## 1. はじめに
 - **設定を入れる前に必ず初期化**しましょう。初期コンフィグが設定されています。

    ```:コマンド
    configure
    clear all
    ```

<a id="anchor2"></a>

## 2. 管理者パスワード
 - ` show running-config ` などでは暗号化されて表示されます。

    ```:コマンド
    password admin set < Password >
    ```

<a id="anchor3"></a>

## 3. ログインプロンプト
 - **< Login >** に任意のログインプロンプトを設定します。<br>例： ` terminal prompt login "\Login\p" `

    ```:コマンド
    terminal prompt login "\< Login >\p"
    terminal prompt user "\h \c\w\p"
    terminal prompt admin "\h \c\w\p"
    ```

<a id="anchor4"></a>

## 4. ログインタイムアウト ( デフォルト 300s )

 ```:コマンド
 consoleinfo autologout < time > < s, m, h >
 telnetinfo autologout < time > < s, m, h >
 ```

<a id="anchor5"></a>

## 5. 物理インターフェース VLAN アサイン

### Trunk ポート ( tag ) の場合
 - 物理インターフェース ether 1 1 に Vlan tag 10, 20, 30 と untag 1 をアサインする場合

    ```:コマンド
    ether 1 1 vlan tag 10,20,30
    ether 1 1 vlan untag 1
    ```

### Access ポート ( untag ) の場合
 - 物理インターフェース ether 1 1 に Vlan untag 1 をアサインする場合

    ```:コマンド
    ether 1 1 vlan untag 1
    ```

<a id="anchor6"></a>

## 6. IP アドレスとデフォルトゲートウェイ
 - ether 1 1 に LAN 1 192.168.1.1/24, VLAN 1, GW 192.168.1.254 を設定する場合

    ```:コマンド
    ether 1 1 vlan untag 1
    lan 1 ip address 192.168.1.1/24 3
    lan 1 ip route 0 default 192.168.1.254 1 1
    lan 1 vlan 1
    ```

<a id="anchor7"></a>

## 7. SNMP サーバー
 - **< Index >** に設定定義番号を設定します。<br>**< SNMPserver address >** に SNMP サーバーのアドレスを設定します。<br>[ public | < community > ] にコミュニティ名を設定します。**public** の場合、任意のSNMPマネージャと通信します。<br>[ off | v1 | v2 ] に トラップ送信設定をします。**v1** ：SNMPv1-Trap , **v2** ：SNMPv2-Trap<br>[ enable | disable ] にマネージャーからの書き込みを許可するか設定します。

    ```:コマンド
    snmp service [ enable | disable ]
    snmp agent sysname < sysname >
    snmp manager < Index > < SNMPserver address > [ public | < community > ] [ off | v1 | v2 ] [ enable | disable ]
    ```

<a id="anchor8"></a>

## 8. NTP サーバー
 - [ time | sntp | dhcp ]<br>**time** ：TIME プロトコル ( TCP ) を使用<br>**sntp**：簡易 NTP プロトコル ( UDP ) を使用<br>**dhcp**：DHCP サーバから広報される TIME プロトコルまたは簡易 NTP に従う
 - [ < time > | start ]<br>**start** ：電源投入時、リセット時に１度のみ実行

    ```:コマンド
    time auto server < ntp server address > [ time | sntp | dhcp ]
    time auto interval [ < time > | start ]
    time zone [ 0900 | 0 ]
    ```

<a id="anchor9"></a>

## 9. プロキシ DNS
 - 正引き・逆引きどちらも全セグメントに対して行います。

    ```:コマンド
    proxydns domain 0 any * any static 8.8.8.8 8.8.8.4
    proxydns address 0 any static 8.8.8.8 8.8.8.4
    ```
 - フィルターをする場合 ( 送信元 192.168.1.0/24 のみ 代理で名前解決する場合 )

    ```:コマンド
    acl 10 ip 192.168.1.0/24 any any any
    serverinfo dns filter 0 accept acl 10
    serverinfo dns filter default reject
    ```

<a id="anchor10"></a>

## 10. ホスト情報の登録

 ```
 host 0 name google.com
 host 0 ip address 8.8.8.8
 ```

<a id="anchor11"></a>

## 11. IPsec

 ```:設定例
 remote 10 name IPsec
 remote 10 mtu 1454
 remote 10 ap 0 datalink type ipsec
 remote 10 ap 0 ipsec type ike
 remote 10 ap 0 ipsec ike protocol esp
 remote 10 ap 0 ipsec ike encrypt aes-cbc-256
 remote 10 ap 0 ipsec ike auth hmac-sha512
 remote 10 ap 0 ipsec ike pfs modp1536
 remote 10 ap 0 ike mode main
 remote 10 ap 0 ike shared key text < key >
 remote 10 ap 0 ike proposal 0 encrypt aes-cbc-256
 remote 10 ap 0 ike proposal 0 hash hmac-sha512
 remote 10 ap 0 ike proposal 0 pfs modp1536
 remote 10 ap 0 tunnel local < local IP address >
 remote 10 ap 0 tunnel remote < remote IP address >
 remote 10 ip route 0 < tunnel route >
 remote 10 ip msschange 1414
 ```

### IPsec Path Through

 ```:設定例
 remote 10 ip nat wellknown 0 500 off
 ```

<a id="anchor12"></a>

## 12. Ether IP Tunnel
 - トンネリング技術を使用して、IP レベルを超えた L2 通信を可能にします。
 - 暗号化はされないため、IPsec と併用して設定しましょう。

### 設定例
 - 母屋と別棟で VLAN 20 の L2 トンネリング設定します。<br>お互いにトンネルアドレス宛ての経路は所持している想定です。
 - 母屋側<br>トンネルIP：**1.1.1.1**
 - 別棟側<br>VLAN 20 トンネルIP：**2.2.2.2**

#### 母屋側

 ```:設定例
 # BridgeGroup 設定
 vlan 20 bridgegroup use on
 vlan 20 bridgegroup group 2

 bridgegroup 2 ip routing off
 bridgegroup 2 ipv6 routing off

 # Tunnel Interface 設定
 remote 20 name VL002
 remote 20 ap 0 name EoIP
 remote 20 ap 0 datalink type ip
 remote 20 ap 0 tunnel local 1.1.1.1
 remote 20 ap 0 tunnel remote 2.2.2.2
 remote 20 bridgegroup use on
 remote 20 bridgegroup group 2

 # Tunnel IP の設定
 remote 1 ap 0 datalink type discard
 remote 1 ip address local 1.1.1.1
 ```

#### 別棟側

 ```:設定例
 # BridgeGroup 設定
 vlan 20 bridgegroup use on
 vlan 20 bridgegroup group 2

 bridgegroup 2 ip routing off
 bridgegroup 2 ipv6 routing off

 # Tunnel Interface 設定
 remote 20 name VL002
 remote 20 ap 0 name EoIP
 remote 20 ap 0 datalink type ip
 remote 20 ap 0 tunnel local 2.2.2.2
 remote 20 ap 0 tunnel remote 1.1.1.1
 remote 20 bridgegroup use on
 remote 20 bridgegroup group 2

 # Tunnel IP の設定
 remote 2 ap 0 datalink type discard
 remote 2 ip address local 2.2.2.2
 ```

<a id="anchor13"></a>

## 13. PPPoE
 - NAPT でインターネットに出ていく想定の設定です。<br>NAT はデフォルトパスで設定されています。

 ```
 remote 1 name PPPoE
 remote 1 mtu 1454
 remote 1 ap 0 name Internet
 remote 1 ap 0 datalink bind vlan 1
 remote 1 ap 0 ppp auth send < username > < password >
 remote 1 ap 0 keep connect
 remote 1 ppp ipcp vjcomp disable
 remote 1 ip address local < local ip >
 remote 1 ip route 0 default 1 1
 remote 1 ip nat mode multi any 1 5m
 remote 1 ip msschange 1414
 ```

<a id="anchor14"></a>

## 14. NAT ( IP マスカレード )

 ```:設定例
 lan 1 ip address 1.1.1.1/30 3
 lan 1 ip nat mode multi any 1 5m
 lan 1 ip nat static default pass
 lan 1 ip filter 0 pass any any 192.168.1.1/24 any any yes any reverse any any
 lan 1 ip filter default reject
 ```

<a id="anchor15"></a>

## 15. BGP

 ```:設定例
 bgp as < local AS >
 bgp neighbor 0 address < Neighbor IP address >
 bgp neighbor 0 as < Neighbor AS >
 bgp neighbor 0 timers < keepalive > < hold timer >
 bgp neighbor 0 ip filter 0 act pass out
 bgp neighbor 0 ip filter 0 route 192.168.10.0/24 exact
 bgp neighbor 0 ip filter 0 set medmetric 1000
 bgp neighbor 0 ip filter 1 act reject out
 bgp neighbor 0 ip filter 1 route any
 ```

<a id="anchor16"></a>

## 16. 再配送

```:設定コマンド
 routemanage ip redist [ rip | bgp, ospf ] [ 配送元 ] [ on | off ]
```

<a id="anchor17"></a>

## 17. シェーピング

```:設定コマンド
 lan 0 shaping on < rate >
 lan 0 ip priority 0 any any any any any any express
```
