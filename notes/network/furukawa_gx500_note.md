# Furukawa RT GX 500 Note
1. [特殊仕様](#anchor1)
2. [Interface](#anchor2)
3. [NTP](#anchor3)
4. [IPsec + Ether IP Tunnel](#anchor4)
   - Base ISAKMP / IPsec
   - IPsec Tunnel
   - Ether IP

<a id="anchor1"></a>

## 1. 特殊仕様
 - 作成が古川電工のため、通常の SiR 系とは少し OS が異なります。
 - ` show running- ` まで入力しないと、` show run ` は保管機能が使用できません。
 - ` no more ` は、Cisco の ` terminal length 0 ` に相当するコマンドです。
 - **grep** 機能は存在しません。
 - VRRP はデフォルトで **version 3** ( IPv6 ) で動きます。注意してください。
 - FTP の仕様で、必ずデフォルトゲートウェイセグメントの IP が送信先・元になります。

<a id="anchor2"></a>

## 2. Interface
 - IP アドレスを直接物理ポートに設定できません。以下のような手順が必要です。
1. 論理ポート ( Port-channel ) を作成し、そこに IP アドレスを設定する。
2. 物理ポートに論理ポートをアサインする。

    ```:設定例
    interface Port-channel 100
     description local
     ip address 192.168.1.1 255.255.255.0
    exit
    interface GigaEthernet 1/1
     description local
     channel-group 100
    !
    ```

 - LoopBack インターフェースは直接設定可能です。

    ```:設定例
    interface Loopback 97
     ip address 1.1.1.1 255.255.255.255
    exit
    ```

<a id="anchor3"></a>

## 3. NTP
 - NTP の送信元アドレスを指定する場合も論理ポートを指定します。

    ```:設定例
    ntp server 10.10.10.10 source port-channel 100
    ```

<a id="anchor4"></a>

## 4. IPsec + Ether IP Tunnel

### Base ISAKMP / IPsec

 ```:設定例
 crypto ipsec policy < ipsec-policy-hoge >
  set pfs < group5 >
  set security-association < always-up >
  set security-association < transform-keysize aes 256 256 256 >
  set security-association < transform esp-aes esp-sha512-hmac >
  set mtu < 1350 >
 exit
 !
 crypto ipsec selector < Selector >
  src 1 ipv4 any
  dst 1 ipv4 any
 exit
 !
 crypto isakmp policy < isakmp-policy-hoge >
  encryption  < aes >
  group < 5 >
  hash < sha-512 >
 exit
 ```

### IPsec Tunnel

 ```:設定例
 ip route 1.1.1.1 255.255.255.255 tunnel 50

 crypto isakmp profile < ipsec-tunnel-hoge >
  set isakmp-policy < isakmp-policy-hoge >
  set ipsec-policy < ipsec-policy-hoge >
  set peer < xxx.xxx.xxx.xxx >
  ike-version 1
  local-key < KEY >
 exit

 crypto map < map-hoge > ipsec-isakmp
  match address < Selector >
  set isakmp-profile < ipsec-tunnel-hoge >
 exit

 interface GigaEthernet 1/1
  vlan-id 10
  bridge-group < 10 >
 exit

 interface Tunnel 50
  tunnel mode ipsec map < map-hoge >
 exit
 ```

### Ether IP

 ```:設定例
 interface Tunnel 97
  tunnel mode ether-ip tunnel-profile < EtherIP-name >
  bridge-group < 10 >
 exit

 ether-ip tunnel-profile < EtherIP-name >
  tunnel source 2.2.2.2
  tunnel destination 1.1.1.1
 exit
 ```
