#!/usr/bin/ruby
##
#
require 'rubygems'                                                                                                                                                                  
require 'pp'                                                                                                                                                                        
require 'fog'                                                                                                                                                                       
require 'json'                                                                                                                                                                      
require 'net/http'                                                                                                                                                                  
                                                                                                                                                                                    
HPCSTenantId = 15127136674260                                                                                                                                                       
HPCSAccountId = 32546646582913
HPCSAccessKey = "P1NA4RE96J4PBWXPN9DB"
HPCSSecretKey = "CDo05N4yB4DwZ9yeQDQC4mM0Q0Yq4sxRESNjKaNH"
HPCSAuthURI = "https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/"

conn = Fog::Compute.new(
  :provider => "HP",
  :hp_auth_uri => HPCSAuthURI,
  :hp_avl_zone => "region-a.geo-1",
  :hp_tenant_id => HPCSTenantId,
  :hp_account_id => HPCSAccessKey,
  :hp_secret_key => HPCSSecretKey
)
pp conn
#servers = conn.servers
#servers.each do |srv|
  #pp srv
#end
conn.compute.servers.table([:id, :name, :state, :created_at])


