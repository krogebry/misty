#!/usr/bin/ruby
##
# Create a private-chef.rb config
require 'rubygems'
require 'pp'

EnvName = "prod0"

cfg_out = []
cfg_out.push( "topology 'ha'" )

hosts = {}
`hpcloud servers |grep #{EnvName}|awk -F"|" '{print $6 " " $3 " " $7}'|sed 's/^\s//'`.split( /\n/ ).each do |r|
  (ip,fqdn,internal_ip) = r.split
  hosts[ip] = fqdn
  role = fqdn.scan( /^(.*)[0-9]{1,}\.prod.*/ )[0][0]
  cfg_out.push( "server( '%s', { :ipaddress => '%s', :role => '%s' })" % [fqdn,internal_ip,role] )
end

#pp hosts

EnvKeyName = "kson-az3"

puts "--- /etc/hosts ---"
puts hosts.map{|ip,fqdn| "%s\t%s" % [ip,fqdn] }

puts "\n\n--- ~/.ssh/config ---"
hosts.each do |ip,fqdn|
  puts "Host %s" % fqdn
  puts "\tUser ubuntu"
  puts "\tIdentityFile %s/.ssh/keys/%s.pem" % [ENV['HOME'],EnvKeyName]
end

puts "\n--- private-chef ---"
cfg_out.push( "api_fqdn 'api.%s.ksonsoftware.com'" % EnvName )
cfg_out.push( "backend_vip 'backend.%s.ksonsoftware.com', { :device => 'eth0', :heartbeat_device => 'eth0' }" % EnvName )
puts "\n\n%s" % cfg_out.join( "\n" )

puts
