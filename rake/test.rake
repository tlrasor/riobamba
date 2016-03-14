require 'rake/testtask'
namespace :Test do

  ENV["RACK_ENV"] = "test"

  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end

  task :all => [:test, :environment]
end