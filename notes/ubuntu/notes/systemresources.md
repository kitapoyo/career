# システムリソース
1. [システムの稼働時間と平均負荷を表示 ( uptime )](#anchor1)
2. [CPU やメモリの利用率 ( top )](#anchor2)
3. [htop](#anchor3)
4. [メモリとスワップ ( free )](#anchor4)
5. [メモリ及び仮想メモリの詳細 ( vmstat )](#anchor5)
6. [メモリ及び仮想メモリの詳細 ( dstat )](#anchor6)

<a id="anchor1"></a>

## 1. uptime コマンド
 - システムの稼働時間と平均負荷を表示します。

    ```:コマンド例
    hoge@srv:~$ uptime
    04:33:12 up 15:16,  1 user,  load average: 0.00, 0.00, 0.00
    ```

    - **up 15:16** は、システムが稼働してから経過した時間が表示されています。
    - **1 user** は、ログイン中のユーザー数が表示されています。
    - **load average 0.00 0.00 0.00** は、直近の１分、５分、１５分の平均負荷を表示しています。<br>この数値は、CPU が他のプロセスを処理中であるため実行待ちとなっているプロセス数です。<br>目安は、CPU コア数です。 ` nproc ` コマンドで調べることができます。

<a id="anchor2"></a>

## 2. CPU やメモリの利用率 ( top )
 - CPU やメモリの利用率、システムの平均負荷などを継続的に ( ３秒間隔 ) 表示します。
 - 終了するには、` Q キー ` を押します。

    ```:コマンド例
    top - 04:41:28 up 15:25,  1 user,  load average: 0.00, 0.01, 0.00
    Tasks:  90 total,   1 running,  47 sleeping,   0 stopped,   0 zombie
    %Cpu(s):  0.7 us,  0.7 sy,  0.0 ni, 98.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
    KiB Mem :  1008732 total,   227160 free,    98904 used,   682668 buff/cache
    KiB Swap:  1852412 total,  1852412 free,        0 used.   760884 avail Mem

      PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
    ```

    - １行目は **uptime** コマンドとほぼ同じ内容が表示されます。
    - ２行目は実行プロセス数が表示されます。**zombie** は、実行が終了しているが、メモリに残っているプロセスです。
    - ３行目はCPU の状態を表示しています。
    - ４～５行目は、メモリとスワップの状態を表示しています。` free ` コマンドとほぼ同じ内容が表示されます。
    - 以降は、プロセスごとの情報が順に表示されます。デフォルトでは、CPU をより多く消費している順です。

### オプション

|オプション|説明|
|---|---|
|-b|対話モードではなく、バッチモードで実行します。|
|-n < 回数 >|表示を更新する回数を指定します。 ( 自動で終了します )|
|-d < 秒 >|表示を更新する間隔を指定します。|
|-u < ユーザー名 >|指定したユーザーのプロセスのみを表示します。|

### 表示項目

|項目|説明|
|---|---|
|PID|プロセス ID|
|USER|ユーザー名|
|PR|実行優先度|
|NI|nice 値 ( 優先度の決定に使用される値 )|
|VIRT|実行中の仮想メモリ ( KB )|
|RES|実行中の物理メモリ ( KB )|
|SHR|共有メモリサイズ|
|S|プロセスの状態 ( % )|
|%CPU|CPU の使用率 ( % )|
|%MEM|物理メモリの使用率 ( % )|
|TIME+|プロセスが実行してから使用した CPU 時間の総計|
|COMMAND|実行コマンド|

<a id="anchor3"></a>

## 3. htop
 - top コマンドを強化したコマンドラインツールです。

### インストール

 ```:コマンド
 sudo apt -y install htop
 ```

### 操作
 - ` F1 ~ F10 キー ` を使用して操作します。
 - 終了する場合は、` Q キー または F10 キー ` を押します。

<a id="anchor4"></a>

## 4. メモリとスワップ ( free )
 - メモリとスワップに関する情報を表示します。**-h** オプションを指定することで見やすくできます。
 - スワップは、ディスクの一部をメモリとして利用する機能です。

    ```:コマンド例
    hoge@srv:~$ free
                           total         used           free     shared  buff/cache     available
    Mem:        1008732       98828       225912         712      683992      760840
    Swap:       1852412               0     1852412
    ```

### 表示項目

|項目|説明|
|---|---|
|Mem|物理メモリサイズ|
|total|搭載している物理メモリサイズ|
|used|使用中のメモリサイズ ( バッファキャッシュ、ページキャッシュを含む )|
|free|空きメモリサイズ ( バッファキャッシュ、ページキャッシュを含まない )|
|shared|共有メモリサイズ|
|buff/cache|バッファとキャッシュおよびページキャッシュ|
|avaikable|新たなアプリケーション起動時に利用可能な物理メモリサイズ|
|Swap|スワップ領域|
|total|スワップ領域のサイズ|
|used|使用中のスワップ領域サイズ|
|free|空いているスワップ領域サイズ

### キャッシュの開放コマンド

 ```:コマンド
 sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"
 ```

<a id="anchor5"></a>

## 5. メモリ及び仮想メモリの詳細 ( vmstat )
 - メモリ及び仮想メモリの詳細な状態を継続的に監視することができます。

    ```:コマンド
    vmstat < 表示間隔 ( 秒 ) 回数 >
    ```

<a id="anchor6"></a>

## 6. メモリ及び仮想メモリの詳細 ( dstat )
 - メモリ及び仮想メモリの詳細な状態を継続的に監視することができます。<br>vmstat コマンドより表示が見やすいコマンドです。表示間隔はデフォルト１秒です。

    ```:コマンド
    dstat < 表示間隔 >
    ```

### インストール

 ```:コマンド
 sudo sudo apt -y install dstat
 ```

### オプション

|オプション|説明|
|---|---|
|-c|CPU の状態を表示します。|
|-d|ディスクの入出力を表示します。|
|-m|メモリの状態を表示します。|
|-n|ネットワークの入出力を表示します。|
|-g|ページの入出力を表示します。|
|-y|システムの状態を表示します。|
|-i|割り込みの状態を表示します。|
|-l|ロードアベレージを表示します。|
