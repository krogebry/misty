##
# Mount points
#
# @author
# @copyright
#module HPCS
  class Misty < Sinatra::Base

    get '/' do
      #respond_to do | wants |
        #wants.html {erb :index}
        #wants.json {"available endpoints are /chef and /jira".to_json}
      #end
      erb :index
    end

  end
#end
