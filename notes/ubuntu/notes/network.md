# ネットワーク 関連シート
1. [ポート番号 ( /etc/services )](#anchor1)
2. [ホスト名 ( hostname )](#anchor2)
   - ホスト名の設定 ( /etc/hostname )
3. [ネットワークインターフェース](#anchor3)
   - ネットワークインターフェースの一覧表示 ( /sys/class/net )
   - ネットワークインターフェースの情報表示 ( lshw , ifconfig , ip , ethtool )
4. [IP アドレスの設定 ( netplan )](#anchor4)
   - DHCP を使用する場合

<a id="anchor1"></a>

## 1. ポート番号
 - ホスト上で動作しているアプリケーションを識別するための番号です。
 - **/etc/services** ファイルに定義されています。

    ```:コマンド
    cat /etc/services
    ```

<a id="anchor2"></a>

## 2. ホスト名 ( hostname)
 - ドメイン名とは、コンピューターが所属しているネットワーク上の領域です。<br>その領域内で、付けられた固有の名前がホスト名です。
 - 表示

    ```:コマンド
    hostname
    ```

 - ホスト名の変更

    ```:コマンド
    sudo hostname < 変更するホスト名 >
    ```

    - 一時的な変更で、システムを再起動するまで有効です。

### ホスト名の設定 ( /etc/hostname )
 - **/etc/hostname** ファイルに記述します。

    ```:コマンド
    sudo vim /etc/hostname
    ```

<a id="anchor3"></a>

## 3. ネットワークインターフェース
 - インターフェースには命名規則があります。

    |種別|説明|
    |----|----|
    |en|イーサーネット ( 有線 LAN )|
    |wl|無線 LAN|
    |ww|無線 WAN|

### ネットワークインターフェースの一覧表示 ( /sys/class/net )

 ```:コマンド
 ls -l /sys/class/net
 ```

### ネットワークインターフェースの情報表示 ( lshw , ifconfig , ip , ethtool )

 ```:コマンド
 sudo lshw -class network
 ```

 ```:コマンド
 ifconfig
 ```

 ```:コマンド
 ip a
 ```

 ```:コマンド
 sudo ethtool < インターフェース名 >
 ```

<a id="anchor4"></a>

## 4. IP アドレスの設定 ( netplan )
 - ubuntu 18.04 LTS から、ネットワークの設定構成が変更されました。
 - 設定ファイルは、**/etc/netplan/XX-installer-config.yaml** です。( XX はシステムによって異なります )
1. 設定ファイルを編集します。

    ```:コマンド
    sudo vim /etc/netplan/XX-installer-config.yaml
    ```

2. 以下のような内容を記述して保存します。

    ```:設定例
    [# This is the network config written by 'subiquity'
    network:
      ethernets:
        enp0s3:          # インターフェース名
          dhcp4: no
          dhcp6: no
          addresses: [ 192.168.1.1/24 ] # 設定するIPアドレス
          gateway4: 192.168.1.254 # デフォルトゲートウェイの設定
      version: 2
    ```

3. ネットワークの設定を反映させます。

    ```:コマンド
    sudo netplan apply
    ```

### DHCP を使用する場合
 - **/etc/netplan/XX-installer-config.yaml** ファイルを以下のように記述します。

    ```:設定例
    # This is the network config written by 'subiquity'
    network:
      ethernets:
        enp0s3:          # インターフェース名
          dhcp4: true
          dhcp6: true
          optional: true
          addresses: []
      version: 2
    ```

    ```:コマンド
    sudo dhclient < インターフェース名 >
    ```
