# Docker Install in CentOS7
1. [環境](#anchor1)
2. [VirtualBox の設定](#anchor2)
3. [CentOS7 のインストール](#anchor3)
4. [Docker のインストール](#anchor4)

<a id="anchor1"></a>

## 1. 環境
 - Windows 10 Home
 - VirtualBox 6.1
 - CentOS-7-x86_64-Minimal-2009

<a id="anchor2"></a>

## 2. VirtualBox の設定

|項目|設定|備考|
|---|---|---|
|タイプ|Linux||
|バージョン|Red Hat 64bit||
|ハードディスク|仮想ハードディスクを作成する||
|ファイルサイズ|50 GB|Docker Image を余裕をもって保存するため|
|ハードディスクのタイプ|VDI ( VirtualBox Disk Image )||
|プロセッサーの数|2|Kubernetes を使用するのに最低 CPU 2 必要|
|ネットワークアダプター|ブリッジモード|IP 確認コマンド ( $ ip a )|

<a id="anchor3"></a>

## 3. CentOS7 のインストール

|項目|設定|備考|
|---|---|---|
|言語|English|日本語の場合は文字化けする可能性があるため|
|KEYBOARD|Japanese|キーボードの設定項目|
|INSTALLATION DESTINATION|VDI|インストール先の選択項目|
|NETWORK & HOST NAME|Ethernet を Enable|Ethernet はデフォルトで無効|

<a id="anchor4"></a>

## 4. Docker のインストール

 ```:コマンド
 yum -y update
 yum -y yum-utils device-mapper-persistent-data lvm2 redhat-lsb
 yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
 yum -y install docker-ce docker-ce-cli containerd.io
 systemctl start docker
 systemctl enable docker
 ```

### バージョン確認

 ```:コマンド
 docker version
 ```
