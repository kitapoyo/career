# -*- coding: utf-8 -*-

# gem install net-ssh
require 'net/ssh'

RED = "\e[31;1m"
WHITE = "\e[37;1m"

=begin
File write mode
file = "cmdfile"
$stdout = File.open(file, 'a')
$stdout = STDOUT
=end

=begin
telnet_list.txt format
192.168.1.1:username1:password1
192.168.1.2:username2:password2
=end

f = File.open('ssh_list.txt')
read_file = f.read.split("\n")
f.close

read_file.map! do |host|
    host.split(":")
end


read_file.each do |dst|
    if dst.size != 3
        puts RED + dst.join(',') + " " + "is syntax error" + WHITE
        next
    end
    dst_address = dst[0]
    username = dst[1]
    pass = dst[2].chomp

    commands = [
        'ls -al',
        'date',
        'whoami'
    ]

    Net::SSH.start(dst_address, username, :password => pass) do |ssh|
        commands.each do |c|
            puts ssh.exec!(c)
            sleep 1
        end
    end

# read_file.each
end
