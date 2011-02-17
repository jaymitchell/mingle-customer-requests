#Copyright 2011 ThoughtWorks, Inc.  All rights reserved.

begin
  require 'macro_development_toolkit'
rescue LoadError
  require 'rubygems'
  require 'macro_development_toolkit'
end

if defined?(MinglePlugins)
  def load_all_files_in(dir)
    Dir[File.join(File.dirname(__FILE__), dir, '**', '*.rb')].each do |f|
      require f
    end
  end

  load_all_files_in('lib')

  MinglePlugins::Macros.register(CustomerRequests::Macro, 'customer-requests')
end 