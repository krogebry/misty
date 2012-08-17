##
#
# @author
require 'rubygems'
require 'pp'
require 'json'
require 'sequel'
require 'sequel/adapters/mysql2'
require 'bundler'

SINATRA_ROOT = File.join( File.dirname(__FILE__),".." )
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

ALog = Logger.new( STDOUT )

class Misty < Sinatra::Base
  VERSION = "0.0.2"

  configure do   
    set :haml, :format => :html5
    set :views, "%s/views" % SINATRA_ROOT
    set :public_folder, "%s/public" % SINATRA_ROOT
    enable :logging, :dump_errors, :raise_errors

    Dir.glob(File.join( "%s/mounts/" % SINATRA_ROOT, "*.rb" )).each do |filename|
      ALog.debug( "Loading mount: %s" % filename )
      require filename
    end
  end 
end

