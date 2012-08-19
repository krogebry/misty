##
# Bartender client plugin for knife.
#
# @author	Bryan Kroger ( bryan.kroger@hp.com )
# @copyright 2012 HPCS
require 'chef/knife'

module HPCS
  class Bartender < Chef::Knife
    banner "knife bartender"
    def run
      puts "Listing"
    end
  end
end

