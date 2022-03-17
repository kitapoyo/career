# Raspberry Pi 4
 - Raspberry Pi Imager
 - VNC Viewer
 - OS 32 bit
    ```
    Distributor ID: Raspbian
    Description:    Raspbian GNU/Linux 11 (bullseye)
    Release:        11
    Codename:       bullseye
    ```

## Set

### Root
 ```
 sudo passwd root
 ```

### sudo
 - ` sudo visudo `
    ```
    $USER ALL=(ALL:ALL) NOPASSWD: ALL
    ```

### tools
 ```
 sudo apt -y update && sudo apt -y upgrade
 sudo apt -y install vim xinetd telnetd traceroute hping3 nmap tcpdump wireshark snmp snmpd dnsutils
 sudo usermod -a -G wireshark $USER
 ```

### bashrc
 ```
 sudo cp ~/.bashrc ~/.bashrc.original
 echo 'umask 0000' >> ~/.bashrc
 echo 'PS1="${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[35m\] @ \h\[\033[01;33m\] \w\[\033[01;32m\] \$ \[\033[00m\]"' >> ~/.bashrc
 ```

### bash_aliases
 - ` vim ~/.bash_aliases `
    ```
    alias cp='cp -iv'
    alias mv='mv -iv'
    alias ls='ls --color=auto'
    alias df='df -h'
    alias ss='ss -atu'
    alias ll='ls -al'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ser='systemctl list-unit-files --type=service'
    alias sys='sudo systemctl status'
    alias resys='sudo systemctl restart'
    alias ensys='sudo systemctl enable'
    alias disys='sudo systemctl disable'
    alias sntr='sudo cat /var/log/snmptrapd/snmptrapd.log'
    ```

### APT Proxy
 - ` sudo vim /etc/apt/apt.conf `
    ```
    Acquire::http::Proxy "http://username:password@proxy:port";
    Acquire::https::Proxy "https://username:password@proxy:port";
    ```

## SNMP Trap

### install
 ```
 sudo apt -y install snmptrapd
 sudo mkdir /var/log/snmptrapd
 sudo cp /lib/systemd/system/snmptrapd.service /lib/systemd/system/snmptrapd.service.original
 ```

### config ( /lib/systemd/system/snmptrapd.service )
 - ` sudo vim /lib/systemd/system/snmptrapd.service `
    ```
    #ExecStart=/usr/sbin/snmptrapd -Lsd -f
    ExecStart=/usr/sbin/snmptrapd -Lf /var/log/snmptrapd/snmptrapd.log -f
    ```

### log
 - ` sudo cat /var/log/snmptrapd/snmptrapd.log `

## Samba

### install
 ```
 sudo apt -y install samba samba-common-bin
 sudo pdbedit -a $USER
 sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.original
 ```

### config ( /etc/samba/smb.conf )
 - ` sudo vim /etc/samba/smb.conf `
    ```
    [homes]
           browseable = No
           comment = Home Directories
           create mask = 0777
           directory mask = 0777
           read only = No
           valid users = %S
    ```

### boot
1. ` testparm `
2. ` sudo systemctl restart smbd nmbd `
3. ` \\RASPBERRYPI\$USER `

## FTP

### install
 ```
 sudo apt -y install vsftpd
 sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.original
 ```

### config ( /etc/vsftpd.conf )
 - ` sudo vim /etc/vsftpd.conf `
    ```
    write_enable=YES
    ascii_upload_enable=YES
    ascii_download_enable=YES
    ```

## TFTP

### install
 ```
 sudo apt -y install tftpd-hpa
 sudo cp /etc/default/tftpd-hpa /etc/default/tftpd-hpa.original
 ```

### config ( /etc/default/tftpd-hpa )
 - ` sudo vim /etc/default/tftpd-hpa `
    ```
    TFTP_USERNAME="tftp"
    TFTP_DIRECTORY="/home/$USER"
    TFTP_ADDRESS=":69"
    TFTP_OPTIONS="--secure --create"
    ```

## Ruby

### install
 ```
 sudo apt -y update
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
 rbenv install 3.1.0
 rbenv global 3.1.0
 ruby -v && which ruby
 ```

### config ( ~/.gemrc )
 - ` touch ~/.gemrc `
    ```
    echo "install: --no-document" >> ~/.gemrc && \
    echo "update: --no-document" >> ~/.gemrc
    gem update --system && gem --version
    ```

## Apache2

### install
 ```
 sudo apt -y install apache2
 ```

### config ( /etc/apache2/ )
 - ` sudo ls /etc/apache2/ `
 - ` sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.original `
 - Pass ： ` sudo ls /var/www/html/ `

## Nginx

### install

 ```
 sudo apt -y install nginx
 ```

### config
 - Main ： ` /etc/nginx/nginx.conf `
    ```
    sudo cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
    ```
 - Site ： `/etc/nginx/sites-available/default `
    ```
    sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.original
 - Check ： ` sudo nginx -t `

## Postfix ( SMTP )
 - log ： ` /var/log/mail.log `

### install
 ```
 sudo apt -y install postfix bsd-mailx
 ```

### set
 ```
 sudo dpkg-reconfigure postfix
 ```
1. mode ： ` Internet Site `
2. domain ： ` raspberrypi.flets-east.jp ` ( pi@raspberrypi.flets-east.jp )
3. admin mail address ： ` root@raspberrypi.flets-east.jp `
4. update sync ： ` No `
5. local address ： default
6. mail box size ： ` 0 ` ( unlimit )
7. local address extensions : ` null `
8. IP ： ` all `

### send
 ```
 telnet localhost 25
 EHLO raspberrypi.flets-east.jp
 MAIL FROM: root@raspberrypi.flets-east.jp
 RCPT TO: pi@raspberrypi.flets-east.jp
 DATA
 test message.
 .
 QUIT
 ```

### check
 ```
 mail
 q
 ```

### config
 - MTA ( Massage Transfer Agent ) ： ` /etc/postfix/main.cf `
    ```
    sudo cp /etc/postfix/main.cf /etc/postfix/main.cf.original
    postconf -n
    ```
 - Postfix Daemon ： ` /etc/postfix/master.cf `
    ```
    sudo cp /etc/postfix/master.cf /etc/postfix/master.cf.original
    submission inet n       -       y       -       -       smtpd
    ```

## BIND9 ( DNS )

### install
 ```
 sudo apt -y install bind9
 ```

### config ( /etc/bind/named.conf )
 - cache server ： ` /etc/bind/named.conf.options `
    ```
    forwarders { 8.8.8.8; 8.8.4.4; };
    allow-query { localhost; };
    ```
 - ` /etc/bind/named.conf.local `
 - ` /etc/bind/named.conf.default-zones `
