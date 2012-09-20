#!/usr/bin/ruby
##
#
require "rubygems"

EnvName = "prod0"

threads = []

hosts = {}
`hpcloud servers |grep #{EnvName}|awk -F"|" '{print $6 " " $3 " " $7}'|sed 's/^\s//'`.split( /\n/ ).each do |r|
  threads << Thread.new do 
    (ip,fqdn,internal_ip) = r.split
    cmd = "hpcloud servers:remove %s" % fqdn
    puts "CMD: %s" % cmd
    system( cmd )
  end
end

threads.each do |t| t.join end
