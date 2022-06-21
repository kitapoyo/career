# -*- coding: utf-8 -*-

# gem install net-ping
require 'net/ping'
require 'socket'

RED = "\e[31;1m"
CYAN = "\e[36;1m"
WHITE = "\e[37;1m"

# Self IP address get
def my_address
    udp = UDPSocket.new
    udp.connect("128.0.0.0", 7)
    address = Socket.unpack_sockaddr_in(udp.getsockname)[1]
    udp.close
    # address is String Class
    return address
end

=begin
ping_list.txt format
192.168.1.1:hostname1
192.168.1.2:hostname2
=end

f = File.open('ping_list.txt')
read_file = f.read.split("\n")
f.close

read_file.map! do |host|
    host_check = host.split(":")
        host_check
end

loop do

    read_file.each do |dst|
        if dst.size == 2
            hostname = dst[1]
        else
            hostname = ""
        end
        # @host="", @port=7, @timeout=5, @exception=nil, @warning=nil, @duration=nil
        execute_ping = Net::Ping::External.new(dst[0])

        if execute_ping.ping?
            puts CYAN + "OK from" + " " + dst[0] + " " + hostname + " " + "source" + " " + my_address + " " + Time.at(Time.now, in: "+09:00").to_s + WHITE
        else
            puts RED + "NG to" + " " + dst[0] + " " + "source" + " " + my_address + " " + Time.at(Time.now, in: "+09:00").to_s + WHITE
        end

    # read_file each
    end

    sleep 1
# loop do
end
