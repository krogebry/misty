##
#
require 'rubygems'
require 'pp'
require 'json'
require 'bundler'
require 'sinatra/respond_to'
require 'sinatra/contrib/all'

SINATRA_ROOT = File.join( File.dirname(__FILE__),".." )
Bundler.require(:default, (ENV['RACK_ENV'] || :development).to_sym)

module HPCS
  class Misty < Sinatra::Base
    VERSION = "0.0.1"

    register Sinatra::RespondTo
    set :haml, :format => :html5
    set :views, "%s/views" % SINATRA_ROOT
    set :public_folder, "%s/public" % SINATRA_ROOT

    configure do   
      yaml = YAML.load_file( "%s/config/config.yml" % SINATRA_ROOT )
      yaml.each_pair do |key, value|
        set(key.to_sym, value)
      end

      Dir.glob(File.join( "%s/mounts" % SINATRA_ROOT, "*.rb" )).each do |file_name|
        require file_name
      end
    end 
  end
end

