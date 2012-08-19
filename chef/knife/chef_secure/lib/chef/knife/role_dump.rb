##
# Bartender client plugin for knife.
#
# @author Bryan Kroger ( bryan.kroger@hp.com )
# @copyright 2012 HPCS
require 'chef/knife'
require 'fileutils'

class Chef
	class Knife
  	class RoleDump < Knife
			deps do
				require 'chef/role'
				require 'chef/json_compat'
			end

			option :output_dir,
				:short => "-o DIR",
				:long => "--output-dir DIR",
				:description => "Send output to this location ( default: ~/tmp/chef/roles )"

    	banner "knife role dump"

			##
			# Default output directory: ~/tmp/chef/roles
			# This will make the directory using mkdir_p ( create parent dirs ) if it doesn't exist.
			# @TODO: background logging
    	def run
				fs_output_container = (config[:output_dir] == nil ? "%s/tmp/chef/roles" % ENV['HOME'] : config[:output_dir])
				FileUtils.mkdir_p( fs_output_container ) if(!File.exists?( fs_output_container ))
				Chef::Role.list.each do |role_name,role_url|
					#puts "Dumping %s to %s" % [role_name,fs_output_container]
					fout = File.open( "%s/%s.json" % [fs_output_container,role_name], 'w' )
					fout.puts JSON.pretty_generate(Chef::Role.load( role_name ).to_hash)
					fout.close
				end
				puts "Dump complete: %s" % fs_output_container
    	end

  	end
	end
end
