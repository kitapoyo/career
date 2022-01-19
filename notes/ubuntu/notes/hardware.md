# ハードウェアの情報表示
1. [全般情報を表示 ( lshw )](#anchor1)
2. [CPU の状態 ( lscpu )](#anchor2)
3. [PCI デバイスの状態 ( lspci )](#anchor3)
4. [USB デバイスの状態 ( lsusb )](#anchor4)
5. [ストレージの状態 ( lsblk )](#anchor5)

<a id="anchor1"></a>

## 1. 全般情報を表示 ( lshw )
 - 全般情報を表示します。

    ```:コマンド
    lshw [ オプション ]
    ```

### オプション

|オプション|説明|
|---|---|
|-short|簡略して表示します。|
|-class|指定したクラスのみ表示します。<br>system , bus , memory , processor , display<br>network , multimedia , brigde , input , storage , disk , volume

<a id="anchor2"></a>

## 2. CPU の状態 ( lscpu )
 - CPU の状態を表示します。

    ```:コマンド
    lscpu [ オプション ]
    ```

<a id="anchor3"></a>

## 3. PCI デバイスの状態 ( lspci )
 - PCI デバイスの状態を表示します。

    ```:コマンド
    lspci [ オプション ]
    ```

### オプション

|オプション|説明|
|---|---|
|-v|詳細な情報を表示します。|
|-s < デバイス番号 >|デバイスを指定して表示します。|

<a id="anchor4"></a>

## 4. USB デバイスの状態 ( lsusb )
 - USB デバイスの状態を表示します。

    ```:コマンド
    lsusb [ オプション ]
    ```

<a id="anchor5"></a>

## 5. ストレージの状態 ( lsblk )
 - ストレージの状態を表示します。

    ```:コマンド
    lsblk [ オプション ]
    ```

    ```:表示例
    hoge@srv:~$ lsblk
    NAME                      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sda                         8:0    0   10G  0 disk
    tqsda1                      8:1    0    1M  0 part
    tqsda2                      8:2    0    1G  0 part /boot
    mqsda3                      8:3    0    9G  0 part
      mqubuntu--vg-ubuntu--lv 253:0    0    9G  0 lvm  /
    sr0                        11:0    1 57.8M  0 rom
    ```
    - **MAJ:MIN** は、メジャー番号およびマイナー番号です。これは、カーネルがデバイスを識別する番号です。
    - **/proc/devices** ファイルに、メジャー番号とデバイスの対応が記述されています。
