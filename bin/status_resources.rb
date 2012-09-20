#!/usr/bin/ruby
##
#
require "rubygems"

ProdName = "prod0"

threads = []

`hpcloud servers|grep prod0|awk '{print $4}'`.split( /\n/ ).each do |fqdn|
  #threads << Thread.new do
    puts "FQDN: %s" % fqdn
    #cmd = "ssh -o StrictHostKeyChecking=no %s 'sudo private-chef-ctl status'" % fqdn
    cmd = "ssh -o StrictHostKeyChecking=no %s 'cat /etc/hosts'" % fqdn
    puts cmd
    system( cmd )
  #end
end

threads.each do |t| t.join end
