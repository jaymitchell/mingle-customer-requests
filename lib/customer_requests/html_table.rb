#Copyright 2011 ThoughtWorks, Inc.  All rights reserved.

module CustomerRequests
  class HtmlTable

    def initialize(columns)
      @builder = Builder::XmlMarkup.new(:indent => 2)
      @columns = columns
    end
    
    def add_table(&block)
      @builder.notextile do
        @builder.table do
          yield
        end
      end
    end
    
    def add_header
      @builder.tr do
        @columns.each do |column_head|
          @builder.th { @builder << cell_value(column_head) }
        end
      end
    end
    
    def add_row(row_data)
      @builder.tr do
        @columns.each do |key|
          @builder.td { @builder << cell_value(row_data[key].to_s) }
        end
      end
    end
    
    private
    
    def cell_value(value)
      value.escape_html.gsub(/\n/, '<br/>')
    end
  end
end