#Copyright 2009 ThoughtWorks, Inc.  All rights reserved.

%w[rubygems rake rake/clean rake/testtask fileutils macro_development_toolkit].each { |f| require f }

Dir['tasks/**/*.rake'].each { |t| load t }

desc "Run all tests"
task :test => ['test:units', 'test:integration']