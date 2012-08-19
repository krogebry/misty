##
# Dump environments.
#
# @author Bryan Kroger ( bryan.kroger@hp.com )
# @copyright 2012 HPCS
require 'chef/knife'
require 'different'

class Stubby
end

class Chef
	class Knife
  	class EnvironmentDiff < Knife
			deps do
				require 'chef/environment'
				require 'chef/json_compat'
			end

    	banner "knife environment diff"

			##
			# Default output directory: ~/tmp/chef/environments
			# This will make the directory using mkdir_p ( create parent dirs ) if it doesn't exist.
			# @TODO: Background logging.
			# @TODO: Better output.
    	def run
				if(ARGV.size >= 4)
					left = Chef::Environment.load( ARGV[2] ).to_hash

					right = if(ARGV[3].match( /\// ))
						(srv_name,env_name) = ARGV[3].split( "/" )
						filename = "%s/.chef/knife-%s.rb" % [ENV['HOME'],srv_name]
						#puts "Filename: %s" % filename
						config[:config_file] = filename
						self.configure_chef
						right = Chef::Environment.load( env_name ).to_hash
					else
						Chef::Environment.load( ARGV[3] ).to_hash
					end

					delta = different?( left, right )
					pp delta
				end
    	end

  	end
	end
end
