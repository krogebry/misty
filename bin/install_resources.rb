#!/usr/bin/ruby
##
#
require "rubygems"

ProdName = "prod0"

threads = []

`hpcloud servers|grep prod0|awk '{print $4}'`.split( /\n/ ).each do |fqdn|
  #puts "FQDN: %s" % fqdn
  #threads << Thread.new do
    cmd_mkdir = "ssh -o StrictHostKeyChecking=no %s 'sudo mkdir /etc/opscode ; sudo echo '127.0.0.1 %s' >> /etc/hosts ; sudo hostname %s' ;" % [fqdn,fqdn,fqdn]
    puts "CMD(mkdir): %s" % cmd_mkdir
    system( cmd_mkdir )

    next

    if(fqdn.match( /backend/ ))
      cmd_packages = "ssh -o StrictHostKeyChecking=no %s 'sudo apt-get install drbd8-utils"
      system( cmd_packages )
    end

    if(!fqdn.match( /backend0/ ))
      #cmd_push = "scp -o StrictHostKeyChecking=no private-chef.rb %s:~/" % fqdn
      #system( cmd_push )
      #cmd_move = "ssh -o StrictHostKeyChecking=no %s 'sudo mv private-chef.rb /etc/opscode'" % fqdn
      #system( cmd_move )

      cmd_push = "scp -o StrictHostKeyChecking=no -r opscode  %s:~/" % fqdn
      system( cmd_push )

      cmd_move = "ssh -o StrictHostKeyChecking=no %s 'sudo mv opscode/* /etc/opscode/'" % fqdn
      system( cmd_move )
    end

    #cmd_configure = "ssh -o StrictHostKeyChecking=no %s 'sudo private-chef-ctl reconfigure'" % fqdn
    #system( cmd_configure )
  #end
end

threads.each do |t| t.join end
