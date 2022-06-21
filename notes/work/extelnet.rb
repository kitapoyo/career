# -*- coding: utf-8 -*-

# gem install net-telnet
require 'net/telnet'

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

f = File.open('telnet_list.txt')
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
    pass = ""

    telnet = Net::Telnet.new("Host" => dst_address,"Prompt"=>/[$%#>:] \z/n,"Waittime"=>1)
    telnet.login(username, pass) { |c| print c }
    telnet.cmd('enable') { |c| print c }
    telnet.cmd('exit') { |c| print c }
    telnet.close

end
