##
# Chef worker
#
# @author
# @copyright
class ChefWorker
  require 'chef/rest'
  require 'chef/search/query'

  def initialize(chef_knife_path, chef_server_name, stale_node_timeout)
    @best_before = stale_node_timeout
    @knife_path  = chef_knife_path
    @server_name = chef_server_name
  end

  def get_stale_nodes
    # use the correct config
    chef_results = Hash.new
    Chef::Config.from_file(@knife_path)
    timeout = Time.now.to_i - 7200
    query = Chef::Search::Query.new
    search = query.search('node',"ohai_time:[* TO #{@best_before}]").first
    search.each do | node |
      chef_results = { node.name => Time.at(node[:ohai_time]).strftime("%a %b %d %Y @ %H:%M:%S") }
    end
    return chef_results
  end
end
