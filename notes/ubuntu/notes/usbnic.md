# USB NIC の接続
1. ifconfig インストール
2. ネットワークデバイスの認識
3. 自動読み込み

## 1. ifconfig インストール

 ```:コマンド
 sudo apt -y install ifconfig
 ```

### 確認
 - USB ポートに差し込んだのみでは，ネットワークデバイスとして使用可能な状態にはなりません。
 - USB デバイスとして適切に認識されていることを確認します。

    ```:表示例
    hoge @ -bash 5.1.4 ~ $ lsusb
    Bus 001 Device 004: ID 0b95:772b ASIX Electronics Corp. AX88772B
    ```
    - こちらでは **ASIX Electronics Corp. AX88772B デバイス** が対象の USB-NIC です。

## 2. ネットワークデバイスの認識
 - ネットワークデバイスとして認識させます。

    ```:コマンド
    sudo lshw -c Network
    ```

 - インターフェースを起動します。

    ```:コマンド
    sudo ifconfig < インターフェース名 > up
    ```

## 3. 自動読み込み
1. **/etc/rc.local** に設定を追記します。

    ```:コマンド
    sudo lshw -c Network
    sudo ifconfig < デバイス名 > up
    ```

2. システムを再起動

    ```:コマンド
    sudo reboot
    ```

3. 確認

    ```:コマンド
    ifconfig
    ```
