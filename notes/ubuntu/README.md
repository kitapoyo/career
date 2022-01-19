# Ubuntu Notes

## Doc Links
 - [UbuntuServerGuide](https://help.ubuntu.com/)
 - [CommunityHelpWiki](https://help.ubuntu.com/community/CommunityHelpWiki)
 - [Ubuntu 日本語フォーラム](https://forums.ubuntulinux.jp/)

## VirtualBox

|Item|File name|Description|
|---|---|---|
|Lubuntu install|**virtualbox_ubuntu.md**|VirtualBox に Ubuntu をインストール|

## Server Index

|Number|Sever name|Description|
|---|---|---|
|01|Apache|HTTP server|
|02|Nginx|Web , Proxy server|
|03|BIND9|DNS server|
|04|Samba|File server|
|05|Open SSH|SSH server , agent|
|06|Squid|Proxy server|
|07|MySQL<br>MariaDB|Database server|
|08|PostgreSQL|Database server|
|09|LXC ( Linux Container )|Container |
|10|LXD|Network container|

## Note Index

|Item|File name|Description|
|---|---|---|
|alias|**alias.md**|エイリアスの設定|
|APT ( Advanced Packaging Tool )|**apt.md**|パッケージ管理ツール|
|gzip , bzip2 command<br>tar command|**archive.md**|ファイル圧縮<br>ファイル展開|
|dump command<br>restore command |**backup.md**|バックアップ<br>リストア|
|bash ( .bashrc )|**bash.md**|バッシュの環境設定|
|command reference|**command_reference.md**|コマンドリファレンス|
|crontab|**crontab.md**|ジョブスケジューリング|
|fdick \| gdisk command|**devicefile.md**|デバイスファイルとパーティション|
|quota|**diskquota.md**|ディスククォータ管理|
|df , iostat , iotop commnad|**diskresources.md**|デバイスリソースの管理コマンド |
|hosts file \| nsswitch.conf \| dig commnad|**dns.md**|名前解決|
|dpkg|**dpkg.md**|dpkg でのパッケージ管理|
|locate , find command|**file_search.md**|ファイル検索|
|ext4 \| mkfs command|**filesystem.md**|ファイルシステム|
|ufw|**firewall_ufw.md**|ファイアウォール|
|/etc/group \| groups , id command<br>groupadd command<br>groupdel command|**group.md**|グループ情報<br>グループ作成<br>グループ削除|
|GRUB ( GRand Unified Bootloader ) |**grub.md**|ブートローダー|
|lshw , lscpu , lspci , lsusb , lsblk command|**hardware.md**|ハードウェアの情報表示|
|journalctl command \| journald.conf|**journalctl.md**|journalctl|
|ln command<br>ln -s , readlink command|**link.md**|ハードリンク<br>シンボリックリンク|
|/var/log<br>logrotate command|**logfile.md**|ログファイル<br>ローテーション|
|who , w , last , lastb , lastlog command|**login.md**|ユーザーログイン関連|
|man command|**manual.md**|Ubuntu マニュアル|
|mount command<br>umount command<br>/etc/fstab|**mount.md**|マウント<br>アンマウント<br>自動マウント|
|/etc/services<br>hostname command<br>/sys/class/net<br>lshw , ifconfig , ip , ethtool command<br>netplan command|**network.md**|ポート番号<br>ホスト名<br>インターフェース一覧<br>インターフェース情報<br>IP アドレス|
|ping command<br>netstat , ss command|**network_engineer.md**|疎通確認<br>Listen ポート確認|
|umask command<br>chmod command<br>chown command<br>chgrp command|**permission.md**|デフォルトのアクセス権<br>アクセス権の変更<br>所持者の変更<br>グループの変更|
|ps command|**process_monitoring.md**|プロセスの監視|
|rsyslog<br>logger command|**rsyslog.md**|rsyslog<br>ログメッセージの生成|
|Self-Monitoring Analysis and Reporting Technology|**smart.md**|自己診断機能 SMART|
|root user<br>sudo , visudo command|**superuser.md**|スーパーユーザー<br>sudo コマンド設定|
|systemd \| systemctl|**systemd.md**|systemd|
|uptime command<br>top , htop command<br>free command<br>vmstat , dstat Command|**systemresources.md**|システムの稼働時間と平均負荷を表示<br>CPU やメモリの利用率<br>メモリとスワップ<br>メモリ及び仮想メモリの詳細|
|usbnic|**usbnic.md**|USB NIC の登録|
|/etc/passwd<br>adduser command<br>passed command<br>pwgen command<br>userdel command<br>usermod command<br>chage command|**user.md**|ユーザー情報<br>ユーザー作成<br>パスワード変更<br>パスワード生成<br>ユーザー削除<br>ユーザー情報変更<br>アカウント期限変更|
|set , shopt command|**variable.md**|シェル変数|
