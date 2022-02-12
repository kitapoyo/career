# Raspberry Pi

 ```
 Distributor ID: Raspbian
 Description:    Raspbian GNU/Linux 11 (bullseye)
 Release:        11
 Codename:       bullseye
 ```

## Start

 ```
 sudo passwd root
 su -
 exit
 ```

 ```
 sudo apt -y update && sudo apt -y upgrade
 sudo apt -y install vim telnet telnetd traceroute hping3 nmap tcpdump wireshark snmp snmpd
 sudo usermod -a -G wireshark $USER
 ```

 ```
 sudo visudo
 $USER ALL=(ALL:ALL) NOPASSWD: ALL
 ```

 ```
 vim ~/.bash_aliases
 echo 'umask 0000' >> ~/.bashrc
 echo 'PS1="${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[35m\] @ \h\[\033[01;33m\] \w\[\033[01;32m\] \$ \[\033[00m\]"' >>  ~/.bashrc
 ```

## APT Proxy

 ```
 sudo vim /etc/apt/apt.conf
 ```

 ```
 Acquire::http::Proxy "http://username:password@proxy:port";
 Acquire::https::Proxy "https://username:password@proxy:port";
 ```

## SNMP Trap

 ```
 sudo apt -y install snmptrapd
 sudo mkdir /var/log/snmptrapd
 sudo cp /lib/systemd/system/snmptrapd.service /lib/systemd/system/snmptrapd.service.default
 sudo vim /lib/systemd/system/snmptrapd.service
 ```

 ```
 #ExecStart=/usr/sbin/snmptrapd -Lsd -f
 ExecStart=/usr/sbin/snmptrapd -Lf /var/log/snmptrapd/snmptrapd.log -f
 ```

 ```
 sudo systemctl daemon-reload
 sudo systemctl enable snmptrapd
 sudo systemctl start snmptrapd.service
 sudo cat /var/log/snmptrapd/snmptrapd.log
 ```

## Samba install

 ```
 sudo apt -y install samba samba-common-bin
 sudo pdbedit -a $USER
 sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.default
 sudo vim /etc/samba/smb.conf
 ```

 ```
 [homes]
        browseable = No
        comment = Home Directories
        create mask = 0777
        directory mask = 0777
        read only = No
        valid users = %S
 ```

1. ` testparm `
2. ` sudo systemctl restart smbd nmbd `
3. ` \\RASPBERRYPI\$USER `

## FTP

 ```
 sudo apt -y install vsftpd
 sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.default
 sudo vim /etc/vsftpd.conf
 ```

 ```
 write_enable=YES
 ascii_upload_enable=YES
 ascii_download_enable=YES
 ```

 ```
 sudo systemctl enable vsftpd
 sudo systemctl restart vsftpd
 ```

## TFTP

 ```
 sudo apt -y install tftpd-hpa
 sudo cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.default
 sudo vim /etc/default/tftpd-hpa
 ```

 ```
 TFTP_USERNAME="tftp"
 TFTP_DIRECTORY="/home/$USER"
 TFTP_ADDRESS=":69"
 TFTP_OPTIONS="--secure --create"
 ```

## Ruby

 ```
 sudo apt -y update && \
 sudo apt -y install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev \
 zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev gcc g++ make ruby-railties
 git clone https://github.com/sstephenson/rbenv.git .rbenv && \
 git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
 echo "# For rbenv" >> ~/.bashrc && \
 echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
 echo 'eval "$(~/.rbenv/bin/rbenv init -)"' >> ~/.bashrc
 source ~/.bashrc
 .rbenv/bin/rbenv init
 rbenv install -l
 ```

 ```
 rbenv install 3.1.0
 rbenv global 3.1.0
 ruby -v && which ruby
 touch ~/.gemrc && /
 echo "install: --no-document" >> ~/.gemrc && \
 echo "update: --no-document" >> ~/.gemrc
 gem update --system && gem --version
 ```
