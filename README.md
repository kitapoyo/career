# 職務経歴書
1. [基本情報](#anchor1)
2. [使用機器サマリー](#anchor2)
3. [使用技術サマリー](#anchor3)
4. 職務経歴
   - [拠点ルータのリプレース](#anchor4a)
   - [新規事務所ネットワークの構築](#anchor4b)
   - [新規拠点ネットワークの構築](#anchor4c)
   - [拠点ネットワーク機器のリプレース](#anchor4d)
   - [公共団体ネットワークの無線 LAN 導入](#anchor4e)
5. [保有資格](#anchor5)
6. [学習していること](#anchor6)

<a id="anchor1"></a>

## 1. 基本情報

|Key|Value|
|---|---|
|Nowadays|2022 04|
|Name|北野 泰隆 ( Kitano Yasutaka )|
|Age|30 ( 1992 02 ) |

### 概要
 - 主にオンプレミスのルーター ( 以後 RT ) , スイッチ ( 以後 SW ) の設計・構築業務を2年間担当。
 - 直近では上記の業務を評価していただき、無線 LAN の案件に参加。
 - ネットワークの業務経験を武器にして、クラウド案件に参加できるよう学習中。

<a id="anchor2"></a>

## 2. 使用機器

|ベンダー|RT|L3SW|L2SW|Others|
|---|---|---|---|---|
|Cisco|ISR4431/K9|WS-C3850-24S|WS-C2960X-48TS-L||
|Hewlett Packard||Aruba 3810M<br>Aruba 2930F 8G<br>Aruba 2930F 48G|Aruba 2530 24G||
|Fujitsu|Si-R G210<br>Si-R G110B<br>Si-R G100B<br>Si-R GX500||SR-X316T2||
|HCNET||||Account@Adapter+|
|Apresia||Apresia15000-32XL|Apresia3424GT-SS||
|Fortinet||||FortiGate-50E<br>FortiGate-100F<br>FortiAP-231F|
|Soliton||||NetAttest-EPS<br>NetAttest-EPS-ap|

<a id="anchor3"></a>

## 3. 使用技術

|ベンダー|技術|
|---|---|
|Cisco|BGP, RIP, HSRP, Route-Map<br>Rapid-PVST+, RADIUS Mac Base Authentication ( Account@Adapter+ ), UDLD|
|Hewlett Packard|Policy Base Routing, VRRP<br>VSF ( Virtual Switching Framework ), LAC ( Link Aggregation ), Rapid-PVST+, MSTP<br>Fault-finder ( Storm Control ), Loop-protection<br>RADIUS Mac Address Based Authentication ( Account@Adapter+ ), Link-keepalive ( UDLD )<br>Aruba Central|
|Fujitsu|BGP, RIP, NAPT, IPsec, Ether IP Tunnel|
|Fortinet|HA, Wireless-controller Bridge-mode, RADIUS Authentication, WPA2-Enterprise|
|Soliton|EAP-TLS|
|Others|GitHub Enterprise<br>Virtual Box<br>Lubuntu 18.04, 20.04<br>Ruby 3.0.1<br>Python 3.9.1|

## 4. 職務経歴
1. 大学卒業後、新卒として地元のスーパーマーケットに正社員として入社。
    - 業務<br>シフト作成, 接客, 発注
2. 新卒入社した会社を退社後、約３年間東京でフリーターとして生活。
    - 業務<br>アミューズメント施設での接客,売上締め作業, 入金, 発注, シフト作成, アルバイト雇用の面接, アルバイトの入社処理
3. 2019年の7月に未経験として現在の派遣会社に入社。
    - 4ヶ月は自社の研修に参加

<a id="anchor4a"></a>

### 拠点 RT のリプレース ( 2019/12 ~ 2020/05 )
 |プロジェクトと担当業務|内容|
 |---|---|
 |プロジェクト概要|約160拠点の RT 及び、FreeWiFi 用 RT の設計構築<br>期間：半年<br>機器：Si-R G110B, Si-R GX500<br>技術：IPsec, Ether IP Tunnel, BGP<br>人員：２名 ( プロパー１名, 本人 )|
 |基本設計|IPsec や 既存と互換性のある技術を選定<br>要件を満たす機能をまとめた基本設計書作成|
 |詳細設計|パラメータシートの作成|
 |移行設計|既存環境移行手順書の作成|
 |コンフィグ作成|各機器のコンフィグ作成|
 |場内テスト|単体試験書作成及び実施<br>結合試験書作成及び試験環境の構築と結合試験の実施|
 |展開作業|データセンター内でのサーバーラック ( 19インチラック ) 搭載等の現地作業|
 |展開後の追加要件対応|アクセスリストの追加<br>新規経路受信用の BGP Filter の追加<br>拠点と拠点を繋ぐレイア２トンネル構築の設計と展開<br>社内ネットワークをインターネットに向けるための NAT トラバーサルの追加|

<a id="anchor4b"></a>

### 新規事務所ネットワークの構築 ( 2020/07 ~ 2020/12 )
 |プロジェクトと担当業務|内容|
 |---|---|
 |プロジェクト概要|L2SW 10台, 無線アクセスポイント ( 以後 AP ) 15台規模の新規事務所ネットワーク構築<br>期間：5ヶ月<br>機器：Aruba 2930F 8G PoE+ 2SFP+, Aruba 2930F 48G, Aruba 2530 24G, Account@Adapter+<br>技術：VSF, Policy Base Routing, Loop-protection, LAC, RADIUS Authentication, Aruba Central<br>人員：２名 ( プロパー１名, 本人 )
 |基本設計|既存環境と新規ネットワークに接続するための Policy Base Routing 設計<br>VSF ( スタック ) を使用したネットワーク設計書の作成|
 |コンフィグ作成|各機器のコンフィグ作成
 |場内テスト|単体試験書作成及び実施<br>結合試験書作成及び試験環境の構築と結合試験の実施<br>Lubuntu の試験環境設定 ( SNMP, Proxy, PPPoE, DNS, NAT )|
 |展開作業|ネットワーク機器のインストール・キッティング<br>運用ネットワークからの遠隔作業|
 |運用マニュアルの作成|各 SW と Aruba Central の運用手順の作成|
 |展開後の追加要件対応|Policy Base Routing の対象追加<br>アクセスリストの追加<br>Teams 遅延の原因調査<br>Aruba Central でのファームアップ作業|

<a id="anchor4c"></a>

### 新規拠点ネットワークの構築 ( 2020/09 ~ 2020/12 )
 |プロジェクトと担当業務|内容|
 |---|---|
 |プロジェクト概要|RT 2台の新規拠点ネットワークの構築<br>期間：3ヶ月<br>機器：Si-R G210<br>技術：BGP, RADIUS Authentication, VRRP<br>人員：２名 ( プロパー１名, 本人 )|
 |コンフィグ作成|各機器のコンフィグ作成|
 |場内テスト|単体試験書作成及び実施<br>結合試験書作成及び試験環境の構築と結合試験の実施|
 |展開作業|ネットワーク機器のインストール・キッティング<br>ロット展開のコンフィグ作成ツールを Python３ で作成|
 |不具合の検証|VRRP と同時に認証 VLAN が動作しない現象を調査|

<a id="anchor4d"></a>

### 拠点ネットワーク機器のリプレース ( 2021/01 ~ 2021/12 )
 |プロジェクトと担当業務|内容|
 |---|---|
 |プロジェクト概要|Aruba 機器で拠点ネットワークのリプレース<br>期間：１年<br>機器：Aruba 3810M 16SFP+ 2slot, Aruba 2930F 48G, Aruba 2530 24G<br>技術：VRRP, Rapid-PVST+, MSTP, Fault-finder, Loop-protection, LAC, RADIUS Authentication<br>人員：５名 ( プロパー1名, 本人, 展開チーム3名 )
 |基本設計|既存環境の際に発覚した問題点の洗い出しと対策の調査<br>ベンダー独自の仕様や処理性能の調査<br>既存の踏襲と追加要件を考慮したアクセスリストの設計書作成|
 |コンフィグ作成|各機器のコンフィグ作成<br>既存のアクセスリストを導入機器に移植できるコンバートツールを Ruby で作成<br>コンフィグ作成ツールを Python３ で作成|
 |場内テスト|単体試験書作成及び実施<br>結合試験書作成及び試験環境の構築と結合試験の実施|
 |展開作業|ネットワーク機器のインストール・キッティング<br>展開手順書作成<br>展開作業での立ち合い|
 |既存環境増設対応|STP, UDLD, LLDP, Loop-protection, RADIUS 等の異なるベンダー間での動作検証|

<a id="anchor4e"></a>

### 公共団体ネットワークの無線 LAN 導入 ( 2021/12 ~ 2022/03 )
 |プロジェクトと担当業務|内容|
 |---|---|
 |プロジェクト概要|既存ネットワークへの新規無線 LAN セグメント構築<br>期間：4ヶ月<br>機器：FortiGate-100F, FortiAP-231F, NetAttest-EPS-ST05, NetAttest-EPSAP-ST05, AX2130SS-24P<br>技術：HA, Wireless-controller, RADIUS Authentication, EAP-TLS, PoE<br>人員：2名 ( プロパー1名, 本人 )|
 |事前動作確認|基本設計の要件を満たすことの事前動作確認 ( EAP-TLS など )|
 |詳細設計|パラメータシートの作成<br>既存ファイアウォールのポリシー精査|
 |場内テスト|単体試験書作成及び実施<br>結合試験書作成及び試験環境の構築と結合試験の実施<br>無線クライアント証明書発行アプリの動作検証|
 |コンフィグ作成|各機器のコンフィグ作成|
 |運用マニュアル作成|無線クライアント証明書の発行及び失効の運用手順|
 |不具合の検証|証明書発行アプリの不具合に対応するための対策と動作検証|

### その他業務
|概要|内容|
|---|---|
|ルーティング経路のリプレース|別拠点にサーバーを移行する経路設計|
|本社 RT のリプレース|Cisco ISR での BGP 経路設計|
|拠点ネットワーク構築|IP-VPN, インターネット VPN とした拠点ネットワーク構築|
|既存拠点の新規セグメント追加|ルーティングテーブルとアクセスリストの設計|

<a id="anchor5"></a>

## 5. 保有資格

|年度|資格|
|---|---|
|2011 年 10 月|IPA 情報処理技術者試験 応用情報技術者|
|2019 年 07 月|LPIC level1|
|2019 年 11 月|CCNP ( Cisco Certified Network Professional Routing and Switching )|

<a id="anchor6"></a>

## 6. 学習していること
 - Linux
