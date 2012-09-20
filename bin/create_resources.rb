#!/usr/bin/ruby
##
#
require "rubygems"
require "pp"
require "json"

ProdName = "prod0"
FlavorId = 105

json = JSON::parse(File.read( "layout.json" ))
#pp json

#threads = []
#cfg_out = []

json["clusters"].each do |cluster_name,cluster|
  cluster.each do |context,cfg|
    #pp cfg
    cfg["count"].times do |srvId|
      fqdn = "%s%i.%s.ksonsoftware.com" % [context,srvId,ProdName]
      cmd = "hpcloud servers:add %s 37933 %i -k kson-az3 -s default,chef-enterprise" % [fqdn, cfg["flavorId"]]
      system( cmd )
    end
  end
end

#threads.each do |t| t.join end
