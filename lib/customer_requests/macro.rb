# #Copyright 2011 ThoughtWorks, Inc.  All rights reserved.

module CustomerRequests
  class Macro
    def initialize(parameters, projects, current_user)
      @parameters = parameters
      @projects = Array(projects)
      @current_user = current_user
    end
    
    def execute
      data = get_data
      output data
    end
    
    def can_be_cached?
      false  # if appropriate, switch to true once you move your macro to production
    end
    
    def self.supports_project_group?
      true
    end
    
    private
    
    def get_this_card_name
      this_project = @projects.first
      this_project.execute_mql("SELECT name WHERE number=THIS CARD.number").first['name']
    end
    
    def replace_this_card_name_in_query(original_query)
      this_card_name = get_this_card_name
      query = original_query.gsub(/this card.name/i, "'#{this_card_name}'")
    end
    
    def get_data
      query = replace_this_card_name_in_query(@parameters['query'])
      that_project = @projects.last
      that_project.execute_mql(query)
    end
    
    def output(data)
      if data.any?
        columns = data.first.keys
        output = HtmlTable.new(columns)
        output.add_table do
          output.add_header
          data.each { |row| output.add_row(row) }
        end
      else
        "No cards"
      end
    end
  end
end