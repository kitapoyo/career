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
7. [IT 業界転職前の経歴](#anchor7)

<a id="anchor1"></a>

## 1. 基本情報

|Key|Value|
|---|---|
|Nowadays|2022 01|
|Name|北野 泰隆 ( Kitano Yasutaka )|
|Age|29 ( 1992 02 ) |

### 概要
 - 主にオンプレミスのルーター ( 以後 RT ) , スイッチ ( 以後 SW ) の設計・構築業務を２年間担当しています。
 - 全国に支店を展開している企業様のネットワーク設計を行ったことから、<br>IP-VPN をメイン回線、インターネット VPN をバックアップ回線とした拠点のネットワーク設計を担当したいです。
 - また、機会があれば AWS 等のクラウドのインフラを担当したいと考えています。<br>ネットワークの業務経験を武器にして、クラウド案件に参加できるようにしたいです。

<a id="anchor2"></a>

## 2. 使用機器

|Vender|RT|L3SW|L2SW|Others|
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

|Vender|Technology|
|---|---|
|Cisco|BGP , RIP , HSRP , Route-Map<br>Rapid-PVST+ , RADIUS Authentication ( Account@Adapter+ ) , UDLD|
|Hewlett Packard|Policy Base Routing , VRRP<br>VSF ( Virtual Switching Framework ) , LAC ( Link Aggregation ) , Rapid-PVST+ , MSTP<br>fault-finder ( Storm Control ) , Loop-Protect<br>RADIUS Authentication ( Account@Adapter+ ) , Link-keepalive ( UDLD )<br>Aruba Central|
|Fujitsu|BGP , RIP , NAPT , IPsec , Ether IP Tunnel , PPPoE|
|Fortinet|HA , Wireless-Controller bridge-mode , RADIUS Authentication|
|Soliton|EAP-TLS|
|Others|GitHub Enterprise<br>Virtual Box<br>Lubuntu 18.04 , 20.04<br>Ruby 3.0.1<br>Python 3.9.1|

## 4. 職務経歴

<a id="anchor4a"></a>

### 拠点ルータのリプレース ( 2019/12 ~ 2020/05 )
 - こちらは、私のエンジニアとしての初めての案件になります。

#### プロジェクト概要
 - 約１６０拠点のルータ及び、FreeWifi 用の DC 内ルータの設計構築
 - 機器<br>Si-R G110B , Si-R GX500
 - 技術<br>IPsec , Ether IP , BGP , PPPoE
 - 人員<br>２名 ( プロパー１名 , 私 )

#### 担当業務
 - 基本設計<br>IPsec や 既存機器での踏襲技術を選定し、要件を満たす機能をまとめた設計書作成
 - 詳細設計<br>VLAN や IPSec Tunnel の IP アドレス と IKE 情報 を選定し、デザインシートの作成
 - 移行設計<br>既存環境からの移行時の手順書作成, 切り戻し手順作成
 - コンフィグ作成<br>古川電工製の Fujitsu 製と仕様が異なったコンフィグ作成
 - テスト<br>単体試験書作成 , 単体試験の実施<br>結合試験書作成 , 試験環境の構築 , 結合試験の実施
 - 展開作業<br>データセンター内でのサーバーラック ( １９インチラック ) 搭載等の現地作業
 - 展開後の追加要件対応
1. アクセスリストの追加
2. 対象経路受信用の BGP Filter の追加
3. 元の拠点を母屋として、新たに別棟を作成し、レイア２トンネルを繋ぐ設計・展開
4. 社内ネットワークをインターネットに向けるための NAT トラバーサルの追加

<a id="anchor4b"></a>

### 新規事務所ネットワークの構築 ( 2020/07 ~ 2020/12 )
 - Hewlett Packard ( 以下 HP ) Aruba 製の機器を初めて使用した案件です。

#### プロジェクト概要
 - スイッチ１０台、無線 AP １５台規模の新規事務所のネットワーク構築
 - 機器<br>Aruba 2930F 8G PoE+ 2SFP+ , Aruba 2930F 48G , Aruba 2530 24G , Account@Adapter+
 - 技術<br>VSF , Policy Route , Loop-Protect , LAC , RADIUS Autentication , Aruba Central
 - 人員<br>２名 ( プロパー１名 , 私 )

#### 担当業務
 - 基本設計<br>既存環境を後から、本ネットワークに接続するための Policy Route の設計<br>レイア２冗長化技術の VSF ( スタック ) を使用したネットワーク設計
 - コンフィグ作成<br>Account@Adapter+ の認証と冗長化設定ファイルの作成<br>Aruba SW のコンフィグ作成
 - テスト<br>単体試験書作成 , 単体試験の実施<br>結合試験書作成 , 試験環境の構築 , 結合試験の実施<br>SNMP 検証のため Lubuntu を使用して SNMP , PPPoE サーバーを使用
 - 展開作業<br>ネットワーク機器のインストール・キッティング作業<br>お客様運用チームのネットワークに接続し、遠隔作業にて参加
 - 運用マニュアルの作成<br>各 SW と Aruba Central の運用手順を作成
 - 展開後の追加要件対応
1. Policy Route の対象追加
2. アクセスリストの追加
3. Teams 遅延の原因調査
4. Aruba Central を使用した、リモートでのファームアップ

<a id="anchor4c"></a>

### 新規拠点ネットワークの構築 ( 2020/09 ~ 2020/12 )
 - 短納期で、ルータ機器のバグを発見するなどトラブルが目立ちました。

#### プロジェクト概要
 - RT ２台による SW を使用しない新規拠点ネットワークの構築
 - 機器<br>Si-R G210
 - 技術<br>BGP , Mac Base Authentication , VRRP
 - 人員<br>２名 ( プロパー１名 , 私 )

#### 担当業務
 - コンフィグ作成<br>BGP , VRRP , Mac 認証 を担当
 - テスト<br>単体試験書作成 , 単体試験の実施<br>結合試験書作成 , 試験環境の構築 , 結合試験の実施
 - 展開作業<br>ネットワーク機器のインストール・キッティング作業<br>ロット展開に向けた、コンフィグ作成ツールを Python３ で作成
 - バグの検証<br>Mac Base Authentication と VRRP にて、認証 VLAN が動作しない現象を調査

<a id="anchor4d"></a>

### 拠点ネットワーク機器のリプレース ( 2021/01 ~ 2021/12 )

#### プロジェクト概要
 - エンドオブサービスによる他ベンダー製機器の代わりに Aruba 機器で既存の拠点ネットワークをリプレース
 - 機器<br>Aruba 3810M 16SFP+ 2slot Switch , Aruba 2930F 48G , Aruba 2530 24G
 - 技術<br>VRRP , Rapid-PVST+ , MSTP , fault-finder , Loop-Protect , LAC , RADIUS Authentication , Link-keepalive
 - 人員<br>５名 ( プロパー１名 , 私 , 展開チーム３名 )

#### 担当業務
 - 基本設計<br>他ベンダー製の際に発覚した問題点の洗い出しと対策の調査<br>ベンダー独自の仕様や処理性能の調査<br>既存の踏襲と追加要件を考慮したアクセスリストの設計
 - コンフィグ作成<br>レイア３ SW , レイア２ SW コンフィグを作成<br>既存のアクセスリストを Aruba 機器に移植できるようなコンバートツールを ruby で作成<br>コンフィグ作成ツールを Ruby で作成後、お客様要望により Python３ にコンバート
 - テスト<br>単体試験書作成 , 単体試験の実施<br>結合試験書作成 , 試験環境の構築 , 結合試験の実施
 - 展開作業<br>ネットワーク機器のインストール・キッティング作業<br>お客様拠点に赴き、トラブル対応等のパイロット展開作業
 - 運用マニュアルの作成
 - 展開手順書作成
 - レイア２増設対応<br>STP , UDLD , LLDP , Loop-Protect , RADIUS など、異なるベンダー間での動作検証

<a id="anchor4e"></a>

### 公共団体ネットワークの無線 LAN 導入 ( 2021/12 ~ 現在 )

#### プロジェクト概要
 - LGWAN を使用しているネットワークに無線 LAN セグメントを導入する案件です。
 - 機器<br>FortiGate-100F , FortiAP-231F , NetAttest-EPS-ST05 , NetAttest-EPSAP-ST05
 - 技術<br>HA , Wireless-controller , RADIUS Authentication , EAP-TLS
 - 人員<br>３名 ( プロパー１名 , 私 , 他１名 )

#### 担当業務
 - 事前動作確認<br>基本設計の要件を満たすことの動作確認 ( EAP-TLS など )
 - 詳細設計<br>無線 LAN コントローラー , 無線 AP のパラメータシートの作成
 - コンフィグ作成<br>無線 LAN コントローラー , 無線 AP のコンフィグ作成
 - 運用マニュアルの作成

### その他業務
 - 運用チーム用のネットワーク経路リプレース
 - FortiGate の導入
 - 本社拠点 ISR ルーター ( Cisco ) のリプレース
 - メイン回線を IP-VPN 、バックアップ回線をインターネット VPN とした拠点ネットワークの構築
 - 既存拠点の新規セグメント追加
 - 既存拠点のインターネット用 RT 構築

<a id="anchor5"></a>

## 5. 保有資格
 - 2011 年 10 月 **IPA 情報処理技術者試験 応用情報技術者**
 - 2019 年 07 月 **LPIC level1**
 - 2019 年 11 月 **CCNP ( Cisco Certified Network Professional Routing and Switching )**

<a id="anchor6"></a>

## 6. 学習していること
 - Linux
 - AWS ( EC2 Amazon Linux2 , Infrastructure as code )

<a id="anchor7"></a>

## 7. IT 業界転職前の経歴
1. 大学卒業後、新卒として地元のスーパーマーケットに正社員として入社しました。約１年と半年ほどで退社しましたが、入社したことに後悔はしておりません。
 - 業務<br>シフト作成 , 接客 , 発注
2. 新卒入社した会社を退社後、東京でフリーターとして約３年間過ごしました。<br>業種は、アミューズメント施設で接客や店舗運営です。
 - 業務<br>接客,売上締め作業 , 入金 , 発注 , シフト作成 , アルバイト雇用の面接 , アルバイトの入社処理
