##
# Mount points
#
# @author
# @copyright
module HPCS
  class Misty < Sinatra::Base

    get '/' do
      respond_to do | wants |
        wants.html {erb :index}
        #wants.json {"available endpoints are /chef and /jira".to_json}
      end
    end

    get '/jira' do
      jira_worker = JiraWorker.new(settings.jira_url,settings.jira_user,settings.jira_pass,settings.jira_filters) 
      return_hash = Hash.new
      return_hash = jira_worker.get_results
      respond_to do | wants |
        wants.html {haml :jira, :locals => {:data => return_hash }}
        wants.json {return_hash.to_json}
      end
    end

    get '/chef' do
      # setup the hash for the results
      chef_results = Hash.new
      settings.chef_servers.each do | cs |
        chef_query = ChefWorker.new(cs['knife_config_path'],cs['name'],cs['stale_node_timeout'])
        chef_results[cs['name']] = chef_query.get_stale_nodes
      end

      respond_to do | wants |
        wants.html {haml :chef, :locals => {:results => chef_results }}
        wants.json {chef_results.to_json}
      end
    end 

  end
end
