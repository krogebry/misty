#!/usr/bin/ruby
##
# Create user.
#
# @author
# @copyright
require 'rubygems'
require 'pp'
require 'mysql2'
require 'sequel'
require 'logger'

dbCfg = {
  "username" => "debian-sys-maint",
  "password" => "NVwQnaUovMtZwv3XOoUQ",
  "hostname" => "localhost",
  "port" => 3306
}

db = Sequel.connect( "mysql2://%s:%s@%s:%i/misty_production" % [
  dbCfg["username"],
  dbCfg["password"],
  dbCfg["hostname"],
  dbCfg["port"]
])

db.loggers << Logger.new( STDOUT )

user_id = db[:users].insert({
  :username => "bryan.kroger%i@hp.com" % rand(1000)
})

groups = 100.times{|i| "group_%i" % i}

rand(100).times do |i|
  db[:groups]
end
