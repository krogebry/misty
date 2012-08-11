class JiraWorker
  require 'jira4r/jira4r'
  def initialize(jira_url,jira_user,jira_pass,jira_filters)
    @url          = jira_url
    @jira_user    = jira_user
    @jira_pass    = jira_pass
    @jira_filters = jira_filters
    @jira = Jira4R::JiraTool.new(2,@url)
    @jira.login(@jira_user,@jira_pass)
  end

  def get_results

    return_hash = Hash.new
    # For each defined filter in the config file, iterate over them and display the results.
    @jira_filters.each do | filter |
      filter_id = filter['filter_id']
      filter_name = filter['name']
      return_hash[filter_name] = Hash.new
      return_hash[filter_name]['name'] = filter['name']
      return_hash[filter_name]['description'] = filter['description']
      return_hash[filter_name]['method'] = filter['method']
      case filter['method']
      when "total"
        return_hash[filter_name]['total'] = @jira.getIssueCountForFilter(filter_id)
      when "list"  
        ##### BLOCKERS
        return_hash[filter_name]['tickets'] = Hash.new
        tickets = @jira.getIssuesFromFilter(filter_id)
        tickets.each do | ticket |
          return_hash[filter_name]['tickets'][ticket.key] = ticket.summary
        end
        return_hash[filter_name]['total'] = @jira.getIssueCountForFilter(filter_id)
      when "with_limit"
        if filter['offset'].nil? or filter['offset'] == ""
          offset = 1
        else
          offset = filter['offset']
        end
        if filter['limit'].nil? or filter['limit'] == ""
          limit = 1
        else
          limit = filter['limit']
        end

        results = @jira.getIssuesFromFilterWithLimit(filter_id,offset,limit)
        if !results.first
          return_hash[filter_name]['results'] = "NONE"
        else
          return_hash[filter_name]['results'] = results
        end
        
          
      end
    end

    return return_hash
  end
end
